CREATE DATABASE seata_order;
CREATE DATABASE seata_storage;
CREATE DATABASE seata_account;


# seata_order库下建t_order表
CREATE TABLE t_order (
                         `id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         `user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id',
                         `product_id` BIGINT(11) DEFAULT NULL COMMENT '产品id',
                         `count` INT(11) DEFAULT NULL COMMENT '数量',
                         `money` DECIMAL(11,0) DEFAULT NULL COMMENT '金额',
                         `status` INT(1) DEFAULT NULL COMMENT '订单状态: 0:创建中; 1:已完结'
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SELECT * FROM t_order;

# seata_storage库下建t_storage表
CREATE TABLE t_storage (
                           `id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                           `product_id` BIGINT(11) DEFAULT NULL COMMENT '产品id',
                           `total` INT(11) DEFAULT NULL COMMENT '总库存',
                           `used` INT(11) DEFAULT NULL COMMENT '已用库存',
                           `residue` INT(11) DEFAULT NULL COMMENT '剩余库存'
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO seata_storage.t_storage(`id`, `product_id`, `total`, `used`, `residue`)
VALUES ('1', '1', '100', '0','100');

SELECT * FROM t_storage;


# seata_account库下建t_account表
CREATE TABLE t_account(
                          `id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
                          `user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id',
                          `total` DECIMAL(10,0) DEFAULT NULL COMMENT '总额度',
                          `used` DECIMAL(10,0) DEFAULT NULL COMMENT '已用余额',
                          `residue` DECIMAL(10,0) DEFAULT '0' COMMENT '剩余可用额度'
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO seata_account.t_account(`id`, `user_id`, `total`, `used`, `residue`)
VALUES ('1', '1', '1000', '0', '1000');

SELECT * FROM t_account;

# 按照上述3库分别建对应的回滚日志表
#
# 订单-库存-账户3个库下都需要建各自的回滚日志表
# \seata-server-0.9.0\seata\conf目录下的db_ undo_ log.sql
# 建表SQL
-- the table to store seata xid data
-- 0.7.0+ add context
-- you must to init this sql for you business databese. the seata server not need it.
-- 此脚本必须初始化在你当前的业务数据库中，用于AT 模式XID记录。与server端无关（注：业务数据库）
-- 注意此处0.3.0+ 增加唯一索引 ux_undo_log
drop table `undo_log`;
CREATE TABLE `undo_log` (
                            `id` bigint(20) NOT NULL AUTO_INCREMENT,
                            `branch_id` bigint(20) NOT NULL,
                            `xid` varchar(100) NOT NULL,
                            `context` varchar(128) NOT NULL,
                            `rollback_info` longblob NOT NULL,
                            `log_status` int(11) NOT NULL,
                            `log_created` datetime NOT NULL,
                            `log_modified` datetime NOT NULL,
                            `ext` varchar(100) DEFAULT NULL,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;






















