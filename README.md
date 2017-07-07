PostgreSQL 10 Beta 与 Oracle 12c R2的性能比较
============================================

概述
----

个人以为，虽然PG最近发展迅速，但与垄断巨头Oracle相比，在功能上还有相当差距，比如PG10分区表不能建主键，而Oracle早在10g就实现了。  
问题是，大多数企业应用只用到了数据库的很小部分功能，如果这时PG不仅功能够用在性能上还可以超过Oracle，在使用维护上比Oracle更简单，那就为PG从互联网应用普及到企业应用奠定良好基础。  


硬件环境
-------

使用了两台DELL Rx730服务器，配置如下：

1. CPU   两个英特尔至强 E5-2650L
1. 内存  256G
1. 阵列  PERC H730P 集成 RAID控制器, 2GB 缓存
1. 硬盘  两个2.5寸250G硬盘，12个3.5寸6T硬盘
1. 网卡  两个Broadcom 5720 QP 1Gb 网卡

操作系统
--------

操作系统使用的是CoreOS alpha (1451.2.0)

    Client:
    Version:      17.05.0-ce
    API version:  1.29
    Go version:   go1.7.6
    Git commit:   89658be
    Built:        Thu Jun 22 21:55:46 2017
    OS/Arch:      linux/amd64

    Server:
    Version:      17.05.0-ce
    API version:  1.29 (minimum version 1.12)
    Go version:   go1.7.6
    Git commit:   89658be
    Built:        Thu Jun 22 21:55:46 2017
    OS/Arch:      linux/amd64
    Experimental: false

