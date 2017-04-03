// XODB is the common interface for database operations that can be used with
// types from schema '{{ schema .Schema }}'.
//
// This should work with database/sql.DB and database/sql.Tx.
type XODB interface {
	Exec(string, ...interface{}) (sql.Result, error)
	Query(string, ...interface{}) (*sql.Rows, error)
	QueryRow(string, ...interface{}) *sql.Row
}

// XOLog provides the log func used by generated queries.
var  _sqlLogFile *os.File
var XOLog = func(strings ...interface{}) {
	if config.IS_DEBUG && false{
        if _sqlLogFile == nil{
            _sqlLogFile,_ = os.OpenFile("./logs_sql_"+helper.IntToStr(helper.TimeNow())+".sql", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
        }
        _sqlLogFile.WriteString(fmt.Sprintln(strings...))
        _sqlLogFile.Sync()
	}
 }

// ScannerValuer is the common interface for types that implement both the
// database/sql.Scanner and sql/driver.Valuer interfaces.
type ScannerValuer interface {
	sql.Scanner
	driver.Valuer
}

// StringSlice is a slice of strings.
type StringSlice []string

// quoteEscapeRegex is the regex to match escaped characters in a string.
var quoteEscapeRegex = regexp.MustCompile(`([^\\]([\\]{2})*)\\"`)

// Scan satisfies the sql.Scanner interface for StringSlice.
func (ss *StringSlice) Scan(src interface{}) error {
	buf, ok := src.([]byte)
	if !ok {
		return errors.New("invalid StringSlice")
	}

	// change quote escapes for csv parser
	str := quoteEscapeRegex.ReplaceAllString(string(buf), `$1""`)
	str = strings.Replace(str, `\\`, `\`, -1)

	// remove braces
	str = str[1:len(str)-1]

	// bail if only one
	if len(str) == 0 {
		*ss = StringSlice([]string{})
		return nil
	}

	// parse with csv reader
	cr := csv.NewReader(strings.NewReader(str))
	slice, err := cr.Read()
	if err != nil {
		fmt.Printf("exiting!: %v\n", err)
		return err
	}

	*ss = StringSlice(slice)

	return nil
}

// Value satisfies the driver.Valuer interface for StringSlice.
func (ss StringSlice) Value() (driver.Value, error) {
	v := make([]string, len(ss))
	for i, s := range ss {
		v[i] = `"` + strings.Replace(strings.Replace(s, `\`, `\\\`, -1), `"`, `\"`, -1) + `"`
	}
	return "{" + strings.Join(v, ",") + "}", nil
}

// Slice is a slice of ScannerValuers.
type Slice []ScannerValuer


////////////// ME /////////////
type whereClause struct  {
    condition string
    args        []interface{}
}

type updateClause struct {
    col string
    val interface{}
}

func whereClusesToSql(wheres []whereClause, whereSep string ) (string, []interface{}) {
    var wheresArr []string
    for _,w := range wheres{
        wheresArr = append(wheresArr,w.condition)
    }
    wheresStr := strings.Join(wheresArr, whereSep)

    var args []interface{}
    for _,w := range wheres{
        args = append(args,w.args...)
    }
    return wheresStr , args
}

type postgresDollar struct  {
    i int //current counter
}

func (dollar *postgresDollar) nextDollar() string {
	dollar.i += 1
	return fmt.Sprintf(" $%d ",dollar.i)	
}

func (dollar *postgresDollar) nextNum() int {
	dollar.i += 1
	return dollar.i
}

func (dollar *postgresDollar) nextManys(size int) string {
	if size < 1 {
		return ""
	}

	if size == 1 {
		return dollar.nextDollar()
	}

	start:= dollar.i +1
	//end:= start + size

	outArry:= []string{}
	for n:=0; n < size;n++{
		outArry = append(outArry, fmt.Sprintf("$%d",start) )
		start++
	}
	dollar.i = start -1
	
	return  " "+strings.Join(outArry,",")+" "
}



