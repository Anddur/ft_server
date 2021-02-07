# 42'S FT_SERVER SUBJECT

<h2>MANDATORY PART</h2>
<br>

- You must set up a web server with Nginx, in only one docker container. The container OS must be debian buster.
- You must place all the necessary files for the configuration of your server in a folder called <samp>srcs</samp>.
- Your <samp>Dockerfile</samp> file should be at the root of your repository. It will build your container. You can’t use docker-compose.
- All the necessary files for your WordPress website should be in the folder <samp>srcs</samp>.
- Your web server must be able to run several services at the same time. The services will be a WordPress website, phpMyAdmin and MySQL. You will need to make sure your SQL database works with the WordPress and phpMyAdmin.
- Your server should be able to use the SSL protocol.
- You will have to make sure that, depending on the url, your server redirects to the
correct website.
- You will also need to make sure your server is running with an autoindex that must be able to be disabled.
