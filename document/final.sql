-- MySQL Script generated by MySQL Workbench
-- 06/06/17 15:29:58
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `orp`.`sort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`sort` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(20) NOT NULL COMMENT '分类名',
  `stage` VARCHAR(4) NOT NULL COMMENT '分类等级',
  `up` INT NULL COMMENT '上级分类编号',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `sort_self_fk1_idx` (`up` ASC),
  CONSTRAINT `sort_self_fk1`
    FOREIGN KEY (`up`)
    REFERENCES `orp`.`sort` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(60) NOT NULL COMMENT '产品名',
  `price` DECIMAL(10,2) NOT NULL COMMENT '原价',
  `saleprice` DECIMAL(10,2) NOT NULL COMMENT '促销价',
  `storenum` INT NOT NULL DEFAULT 0 COMMENT '库存',
  `score` INT NOT NULL DEFAULT 0 COMMENT '购买获得积分',
  `scale1` VARCHAR(140) NULL COMMENT '规格分类1',
  `scale2` VARCHAR(140) NULL COMMENT '规格分类2',
  `scale3` VARCHAR(140) NULL COMMENT '规格分类3',
  `picture` VARCHAR(100) NOT NULL COMMENT '图片',
  `descript` JSON NULL COMMENT '产品详细参数',
  `morepic` VARCHAR(200) NULL COMMENT '细节图片',
  `sort1` INT NOT NULL COMMENT '一级分类',
  `sort2` INT NOT NULL COMMENT '二级分类',
  `sort3` INT NOT NULL COMMENT '三级分类',
  `brand` VARCHAR(20) NULL COMMENT '品牌',
  `hotpoint` VARCHAR(20) NULL COMMENT '选购热点',
  `viewnum` INT NOT NULL DEFAULT 0 COMMENT '浏览量',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `product_sort_fk1_idx` (`sort1` ASC),
  INDEX `product_sort_fk1_idx1` (`sort2` ASC),
  INDEX `product_sort_fk3_idx` (`sort3` ASC),
  CONSTRAINT `product_sort_fk1`
    FOREIGN KEY (`sort1`)
    REFERENCES `orp`.`sort` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_sort_fk2`
    FOREIGN KEY (`sort2`)
    REFERENCES `orp`.`sort` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_sort_fk3`
    FOREIGN KEY (`sort3`)
    REFERENCES `orp`.`sort` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`combo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`combo` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `product1` INT NOT NULL COMMENT '产品1',
  `product2` INT NOT NULL COMMENT '产品2',
  `product3` INT NULL COMMENT '产品3',
  `totalprice` DECIMAL(10,2) NOT NULL COMMENT '套餐总价',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `combo_product_fk2_idx` (`product2` ASC),
  INDEX `combo_product_fk1_idx` (`product1` ASC),
  INDEX `combo_product_fk3_idx` (`product3` ASC),
  CONSTRAINT `combo_product_fk1`
    FOREIGN KEY (`product1`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `combo_product_fk2`
    FOREIGN KEY (`product2`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `combo_product_fk3`
    FOREIGN KEY (`product3`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`validate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`validate` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `descript1` VARCHAR(50) NOT NULL COMMENT '安全问题一',
  `descript2` VARCHAR(50) NOT NULL COMMENT '安全问题二',
  `answer1` VARCHAR(50) NOT NULL COMMENT '答案一',
  `answer2` VARCHAR(50) NOT NULL COMMENT '答案二',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `name` VARCHAR(20) NOT NULL COMMENT '昵称',
  `account` VARCHAR(20) NOT NULL COMMENT '账号',
  `password` VARCHAR(40) NOT NULL COMMENT '密码',
  `sex` CHAR(2) NULL COMMENT '性别',
  `birthday` DATETIME NULL COMMENT '生日',
  `phone` VARCHAR(11) NOT NULL COMMENT '手机号',
  `validateid` INT NULL COMMENT '验证问题编号',
  `email` VARCHAR(50) NULL COMMENT '邮箱',
  `score` INT NOT NULL DEFAULT 0 COMMENT '积分',
  `paidpwd` VARCHAR(12) NULL COMMENT '支付密码',
  `license` VARCHAR(18) NULL COMMENT '身份证',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `user_validate_fk1_idx` (`validateid` ASC),
  CONSTRAINT `user_validate_fk1`
    FOREIGN KEY (`validateid`)
    REFERENCES `orp`.`validate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`place` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `accept` VARCHAR(20) NOT NULL COMMENT '收件人姓名',
  `phone` VARCHAR(11) NOT NULL COMMENT '收件手机号',
  `provice` VARCHAR(20) NOT NULL COMMENT '省份',
  `city` VARCHAR(20) NOT NULL COMMENT '城市',
  `area` VARCHAR(20) NOT NULL COMMENT '区',
  `detail` VARCHAR(60) NULL COMMENT '详细地址',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `place_user_fk1_idx` (`userid` ASC),
  CONSTRAINT `place_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`discount` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `use` INT NOT NULL COMMENT '抵消金额',
  `limit` INT NOT NULL COMMENT '使用下限金额',
  `begin` DATETIME NOT NULL COMMENT '有效期始',
  `end` DATETIME NOT NULL COMMENT '有效期止',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `discount_user_fk1_idx` (`userid` ASC),
  CONSTRAINT `discount_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `discountid` INT NULL COMMENT '使用优惠券编号',
  `placeid` INT NOT NULL COMMENT '收货地址编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `time` DATETIME NOT NULL DEFAULT now() COMMENT '订单产生时间',
  `trancode` VARCHAR(16) NULL COMMENT '快递单号',
  `carrier` VARCHAR(12) NULL COMMENT '物流',
  `trandetail` VARCHAR(1000) NULL COMMENT '物流信息',
  `total` DECIMAL(10,2) NULL COMMENT '总计金额',
  `tranprice` DECIMAL(5,1) NULL COMMENT '运费',
  `delay` VARCHAR(10) NULL COMMENT '是否延长收货',
  `pay` VARCHAR(20) NULL COMMENT '支付方式',
  `note` VARCHAR(60) NULL COMMENT '客户留言',
  `status` VARCHAR(10) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `order_user_fk1_idx` (`userid` ASC),
  INDEX `order_place_fk1_idx` (`placeid` ASC),
  INDEX `order_discount_fk1_idx` (`discountid` ASC),
  CONSTRAINT `order_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_place_fk1`
    FOREIGN KEY (`placeid`)
    REFERENCES `orp`.`place` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_discount_fk1`
    FOREIGN KEY (`discountid`)
    REFERENCES `orp`.`discount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productid` INT NOT NULL,
  `userid` INT NOT NULL,
  `orderid` INT NOT NULL,
  `level` VARCHAR(8) NOT NULL,
  `time` DATETIME NOT NULL DEFAULT now(),
  `descript` VARCHAR(200) NULL,
  `picture` VARCHAR(80) NULL,
  `status` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `comment_product_fk1_idx` (`productid` ASC),
  INDEX `comment_user_fk1_idx` (`userid` ASC),
  INDEX `comment_order_kf1_idx` (`orderid` ASC),
  CONSTRAINT `comment_product_fk1`
    FOREIGN KEY (`productid`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_order_kf1`
    FOREIGN KEY (`orderid`)
    REFERENCES `orp`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`shopitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`shopitem` (
  `productid` INT NOT NULL COMMENT '产品编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `productnum` INT NOT NULL DEFAULT 1 COMMENT '产品数量',
  PRIMARY KEY (`productid`, `userid`),
  INDEX `shop_user_fk_idx` (`userid` ASC),
  CONSTRAINT `shop_product_fk1`
    FOREIGN KEY (`productid`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `shop_user_fk`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`orderitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`orderitem` (
  `orderid` INT NOT NULL COMMENT '订单编号',
  `productid` INT NOT NULL COMMENT '产品编号',
  `productnum` INT NOT NULL COMMENT '产品数量',
  PRIMARY KEY (`orderid`, `productid`),
  INDEX `order_product_fk1_idx` (`productid` ASC),
  CONSTRAINT `order_product_fk1`
    FOREIGN KEY (`productid`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_item_fk1`
    FOREIGN KEY (`orderid`)
    REFERENCES `orp`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `productid` INT NOT NULL COMMENT '产品编号',
  `orderid` INT NOT NULL COMMENT '订单编号',
  `date` DATETIME NOT NULL DEFAULT now() COMMENT '申请时间',
  `type` VARCHAR(10) NOT NULL COMMENT '售后类型',
  `reason` VARCHAR(20) NOT NULL COMMENT '申请原因',
  `backmoney` DECIMAL(10,2) NULL COMMENT '退款金额',
  `detail` VARCHAR(500) NULL COMMENT '详细描述',
  `picture` VARCHAR(50) NULL COMMENT '上传图片',
  `banktime` DATETIME NULL COMMENT '银行处理时间',
  `success` DATETIME NULL COMMENT '售后完成时间',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `service_order_fk1_idx` (`orderid` ASC),
  INDEX `service_product_fk1_idx` (`productid` ASC),
  CONSTRAINT `service_order_fk1`
    FOREIGN KEY (`orderid`)
    REFERENCES `orp`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `service_product_fk1`
    FOREIGN KEY (`productid`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`score`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`score` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `scoreadd` INT NOT NULL COMMENT '积分变动量',
  `time` DATETIME NULL DEFAULT now() COMMENT '变化时间',
  PRIMARY KEY (`id`),
  INDEX `score_user_fk1_idx` (`userid` ASC),
  CONSTRAINT `score_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`collect`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`collect` (
  `productid` INT NOT NULL COMMENT '产品编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `date` DATETIME NOT NULL DEFAULT now() COMMENT '收藏日期',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`productid`, `userid`),
  INDEX `collect_user_fk1_idx` (`userid` ASC),
  CONSTRAINT `collect_product_fk1`
    FOREIGN KEY (`productid`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `collect_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`foot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`foot` (
  `userid` INT NOT NULL COMMENT '用户编号',
  `productid` INT NOT NULL COMMENT '产品编号',
  `date` DATETIME NOT NULL DEFAULT now() COMMENT '浏览日期',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`userid`, `productid`),
  INDEX `foot_product_fk1_idx` (`productid` ASC),
  CONSTRAINT `foot_product_fk1`
    FOREIGN KEY (`productid`)
    REFERENCES `orp`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `foot_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '消息编号',
  `userid` INT NOT NULL COMMENT '用户编号',
  `type` VARCHAR(10) NOT NULL COMMENT '消息类型',
  `detail` VARCHAR(200) NOT NULL COMMENT '详细说明',
  `time` DATETIME NOT NULL DEFAULT now() COMMENT '消息时间',
  PRIMARY KEY (`id`),
  INDEX `message_user_fk1_idx` (`userid` ASC),
  CONSTRAINT `message_user_fk1`
    FOREIGN KEY (`userid`)
    REFERENCES `orp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(20) NOT NULL COMMENT '角色名',
  `detail` VARCHAR(50) NULL COMMENT '描述',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` VARCHAR(20) NOT NULL COMMENT '姓名',
  `account` VARCHAR(20) NOT NULL COMMENT '账号',
  `password` VARCHAR(20) NOT NULL COMMENT '密码',
  `roleid` INT NOT NULL COMMENT '角色id',
  `phone` VARCHAR(11) NULL COMMENT '手机号',
  `status` VARCHAR(10) NULL DEFAULT '在职' COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `staff_role_fk1_idx` (`roleid` ASC),
  CONSTRAINT `staff_role_fk1`
    FOREIGN KEY (`roleid`)
    REFERENCES `orp`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`top`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`top` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` VARCHAR(45) NOT NULL COMMENT '标题',
  `detail` VARCHAR(1200) NOT NULL COMMENT '内容',
  `date` DATETIME NOT NULL DEFAULT now() COMMENT '日期',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`menu` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parentid` INT NULL COMMENT '父级菜单',
  `name` VARCHAR(12) NOT NULL COMMENT '标题',
  `detail` VARCHAR(50) NULL COMMENT '说明',
  `url` VARCHAR(50) NOT NULL COMMENT '指向地址',
  `status` VARCHAR(10) NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  INDEX `menu_self_fk1_idx` (`parentid` ASC),
  CONSTRAINT `menu_self_fk1`
    FOREIGN KEY (`parentid`)
    REFERENCES `orp`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orp`.`menu_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orp`.`menu_role` (
  `menuid` INT NOT NULL COMMENT '菜单编号',
  `roleid` INT NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`menuid`, `roleid`),
  INDEX `fk_role_id_idx` (`roleid` ASC),
  CONSTRAINT `fk_menu_id`
    FOREIGN KEY (`menuid`)
    REFERENCES `orp`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_id`
    FOREIGN KEY (`roleid`)
    REFERENCES `orp`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
