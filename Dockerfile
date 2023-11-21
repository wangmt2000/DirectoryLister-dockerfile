FROM php:8.3.0RC6-zts-alpine3.18

# 安装 zip 扩展
RUN apk --no-cache add libzip-dev zip && docker-php-ext-install zip

# 下载并解压 DirectoryLister
ADD https://github.com/DirectoryLister/DirectoryLister/releases/download/3.12.3/DirectoryLister-3.12.3.tar.gz /var/www/html/

# 解压文件
RUN tar -xzf /var/www/html/DirectoryLister-3.12.3.tar.gz -C /var/www/html/

# 删除压缩包
RUN rm /var/www/html/DirectoryLister-3.12.3.tar.gz

# 定义工作目录
WORKDIR /var/www/html/DirectoryLister

# 安装所需的 PHP 扩展和依赖
RUN apk --no-cache add \
    php-xml \
    php-mbstring \
    php-gd \
    php-dom \
    php-fileinfo

# 设置文件权限（根据需要进行调整）
RUN chown -R www-data:www-data /var/www/html/DirectoryLister

# 暴露容器的 9000 端口（如果需要与主机进行连接）
EXPOSE 9000

# 指定容器启动时执行的命令（根据需要进行调整）
CMD ["php", "-F"]
