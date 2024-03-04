# 使用Node.js官方镜像作为基础镜像
FROM node:latest

# 安装MySQL（你可以选择不同的镜像，比如mysql:5.7）
FROM mysql:5.7

# 设置工作目录
WORKDIR /app

# 将项目文件复制到容器中
COPY . /app

# 安装项目依赖
RUN npm install

# 替换数据库配置（请根据你的实际配置修改）
RUN sed -i 's/database: .*/database: "hiolabsDB",/g' /app/src/common/config/database.js && \
    sed -i 's/user: .*/user: "root",/g' /app/src/common/config/database.js && \
    sed -i 's/password: .*/password: "qJz8TeQq",/g' /app/src/common/config/database.js && \
    sed -i 's/host: .*/host: "mysql",/g' /app/src/common/config/database.js

# 替换微信登录和微信支付配置（请将下列值替换为你的实际配置）
RUN sed -i 's/appid: .*/appid: "wxa1465a70b3beb8cb",/g' /app/src/common/config/config.js && \
    sed -i 's/secret: .*/secret: "your-secret",/g' /app/src/common/config/config.js && \
    sed -i 's/mch_id: .*/mch_id: "your-mch_id",/g' /app/src/common/config/config.js && \
    sed -i 's/partner_key: .*/partner_key: "your-partner_key",/g' /app/src/common/config/config.js && \
    sed -i 's/notify_url: .*/notify_url: "your-notify_url",/g' /app/src/common/config/config.js

# 导入数据库结构
COPY hiolabsDB.sql /docker-entrypoint-initdb.d/

# 映射端口
EXPOSE 8360

# 配置环境变量，例如你的数据库配置等
ENV MYSQL_DATABASE=hiolabsDB \
    MYSQL_ROOT_PASSWORD=qJz8TeQq \
    MYSQL_USER=root \
    MYSQL_PASSWORD=qJz8TeQq

# 启动应用
CMD ["npm", "start"]