package com.caq.cloud.config;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan({"com.caq.cloud.dao"})
public class MyBatisConfig {
}
