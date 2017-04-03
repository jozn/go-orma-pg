package main

import (
	"fmt"
	_ "github.com/go-sql-driver/mysql"
    _ "github.com/lib/pq"
	"github.com/jmoiron/sqlx"
    "time"
    "math/rand"
)

var DB *sqlx.DB
var DB2 *sqlx.DB

const DEBUG = false

func main() {
	var err error
	//DB, err = sqlx.Connect("mysql", "root:123456@tcp(localhost:3307)/ms_test?charset=utf8mb4")
	DB2, err = sqlx.Connect("mysql", "root:123456@tcp(localhost:3307)/ms?charset=utf8mb4")
	DB, err = sqlx.Connect("postgres", "user=postgres dbname=tag sslmode=disable")
	DB.MapperFunc(func(s string) string { return s })
	if err != nil {
		panic("DB")
	}
	fmt.Println("hjb")

    //go playGet()
    go playUpdate()
    time.Sleep(1000*time.Second)
	//play()
	//update()
    //playselect()
    //playselect2()

    //go insertMysql()
    //go upMysql()
    //playselectMysql()
	_ = DB

}

func play() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

	for i := n; i < n +10000000; i++ {
		p := Tag{}
        p.Id = i
		p.Name = fmt.Sprintf("%d",i)
		p.CreatedTime = i

		err := p.Insert(DB)
		if err != nil {
			//fmt.Println(err)
		}
        if i % 10000 == 0{
            fmt.Println(time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
	}

}

func playselect() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        NewTag_Selector().Id_EQ(rand.Intn(n))
        if i % 10000 == 0{
            fmt.Println(time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }

}

func playselect2() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        DB.Get(&Tag{},"select * from tags where id =$1",rand.Intn(n))
        if i % 10000 == 0{
            fmt.Println(time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }

}

func playselectMysql() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        DB2.Get(&Tag{},"select * from tags_copy where id =?",rand.Intn(n))
        if i % 10000 == 0{
            fmt.Println(time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }

}

func insertMysql() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        DB2.Exec("insert  into `tags_copy`(`Name`,`Count`,`IsBlocked`,`CreatedTime`) values (?,?,?,?) ","dsada",25,1,n)
        if i % 10000 == 0{
            fmt.Println(time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }
}

func upMysql() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        DB2.Exec("update `tags_copy` set `Name`= 'dasdas' where Id = ? ",n)
        if i % 10000 == 0{
            fmt.Println("up my: ",time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }
}

func play4() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {

        t,_ := DB.Begin()
        for j := 0; j < 2000; j++ {
            p := Tag{}
            p.Id = i
            p.Name = fmt.Sprintf("%d",i)
            p.CreatedTime = i

            p.Insert(t)
        }

        t.Commit()

        if i % 5 == 0{
            fmt.Println(time.Now().Sub(t1), " ", (i/5) )
            t1 = time.Now()
        }
    }

}

func playGet() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        t,err:=TagById(DB,rand.Intn(n))
        if err != nil{
            continue
        }
        t.Count = i
        t.Save(DB)
        if i % 10000 == 0{
            fmt.Println("u : ",time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }

}

func playUpdate() {
    n,err := NewTag_Selector().Select_Id().OrderBy_Id_Desc().GetInt(DB)
    if err != nil{
        panic(err)
    }
    t1 := time.Now()

    for i := n; i < n +10000000; i++ {
        DB.Exec(`update tags_copy set "Count"= 589 where Id = $1 `,n)
        if i % 10000 == 0{
            fmt.Println("u : ",time.Now().Sub(t1), " ", (i/1000) )
            t1 = time.Now()
        }
    }

}

func update() {
	for i := 0; i < 10; i++ {
		/*		cnt, err := NewComment_Updater().CreatedTime_GT(10).Text("ssss").Update(DB)
						fmt.Println("ttt: ", cnt)
						if err != nil {
							fmt.Println(err)
						}

						cnt, err = NewComment_Updater().UserId(12).Text("uuuuu").Text_EQ("ssss").CreatedTime_LE(100).Update(DB)
						fmt.Println("uuu: ", cnt)
						if err != nil {
							fmt.Println(err)
						}

						NewComment_Updater().Text_Like("%s").Text("LIKE").Update(DB)
				        NewComment_Selector().Select_Id().Id_
				        u,_:=NewUser_Selector().Get()
				        u.Save(DB)
				        NewRecommendUser_Selecter().UserId_EQ(12).OrderBy_Id_Desc().GetAll()*/
	}
}

func m() {
	w := whereClause{}
	w.condition = "ddd"
}
