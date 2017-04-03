/*
Navicat PGSQL Data Transfer

Source Server         : pg1
Source Server Version : 90602
Source Host           : localhost:5432
Source Database       : tag
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90602
File Encoding         : 65001

Date: 2017-04-03 06:48:11
*/


-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS "public"."tags";
CREATE TABLE "public"."tags" (
"Id" int4 NOT NULL,
"Name" varchar(100) COLLATE "default" NOT NULL,
"Count" int4 NOT NULL,
"IsBlocked" int4 NOT NULL,
"CreatedTime" int4 NOT NULL
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO "public"."tags" VALUES ('1', 'آتش‌سوزی', '697', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('2', 'انسان', '1279', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('3', 'شده', '1294', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('4', 'MicroTugs', '1320', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('5', 'تکنیک‌های', '730', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('6', 'شوند.', '698', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('7', 'این', '1306', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('8', 'خود', '708', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('9', 'بیشتر', '685', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('10', 'کنفرانس', '706', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('11', 'مهندسین', '715', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('12', 'ربات‌ها', '1346', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('13', 'آزمایشگاه', '1294', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('14', 'اشیایی', '688', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('15', 'راز', '754', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('16', 'دانشگاه', '1301', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('17', 'نجات', '706', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('18', 'دوباره', '704', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('19', 'هنگامی', '735', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('20', 'استنفورد', '668', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('21', 'هنگام', '727', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('22', 'سازندگان', '721', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('23', 'عمودی', '721', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('24', 'به', '722', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('25', 'ولی', '706', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('26', 'هزار', '659', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('27', 'انسان‌های', '735', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('28', 'کشیدن', '735', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('29', 'سطح', '687', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('30', 'قدرت', '725', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('31', 'کوچک', '1313', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('32', 'قوی‌ترین', '714', '0', '1471759996');
INSERT INTO "public"."tags" VALUES ('33', 'کوچک‌ترین', '713', '0', '1471759997');
INSERT INTO "public"."tags" VALUES ('34', 'ریزگردها،', '5', '0', '1489869079');

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------

-- ----------------------------
-- Indexes structure for table tags
-- ----------------------------
CREATE INDEX "cnt" ON "public"."tags" USING btree ("Count");

-- ----------------------------
-- Primary Key structure for table tags
-- ----------------------------
ALTER TABLE "public"."tags" ADD PRIMARY KEY ("Id");
