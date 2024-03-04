# 使用官方Node.js镜像创建一个新镜像
FROM node:latest

# 创建并设置应用的工作目录
WORKDIR /app

# 将应用的文件复制到容器内的工作目录
COPY . /app

# 执行npm install来安装应用的依赖
RUN npm install

# 对外暴露应用在容器内运行时的端口
EXPOSE 8360

# 运行应用
CMD ["npm", "start"]