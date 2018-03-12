4xxi Symfony Skeleton
==========

4xxi Symfony Skeleton is an extension for the official [Symfony Skeleton](https://github.com/symfony/skeleton) 
(recommended way for starting new projects using [Symfony Flex](https://symfony.com/doc/current/setup/flex.html)). 
It's main idea is to keep simplicity of official Skeleton, while adding must-have dependencies and default configs used
in 4xxi for developing majority of the projects. It contains bare Symfony Skeleton with the following additions:

* A minimal set of must have bundles for production environment
    * ORM Pack (Doctrine + Migrations)
    * FrameworkExtraBundle (Annotations)
    * MonologBundle
    * Sensiolabs SecurityChecker
* A set of bundles and tools that are necessary for development
    * [Maker Bundle](https://symfony.com/doc/current/bundles/SymfonyMakerBundle/index.html)
    * [PHP CS Fixer](https://cs.sensiolabs.org/)
    * [Deployer](https://deployer.org/)
    * Debug Pack (Debug + Profiler + Dumper)
* Docker Compose and Docker Sync configs optimized for development under Linux and MacOS
* Deployer config
* Template for README.md with installation instructions

Creating new project 
==========

Creating new project with 4xxi Symfony Skeleton is as easy as running
```bash
composer create-project 4xxi/skeleton <project_name> 
```
where `<project_name>` is the directory where you want to setup a new project. New project is ready for development 
immediately after this step.

## Additional configurations

### Docker
4xxi Symfony Skeleton comes with Docker configuration for local development (includes PHP 7.1, nginx and PostgreSQL)
on Linux and MacOS.

* Follow instructions in `docker-sync.yml` and `docker-compose-sync.yml` and update `project_name-data-sync` volume 
  with the real name of your project. This is needed to keep a unique name for data volume used by Docker Sync for 
  developers working simultaneously on several projects.
* Optional: Add additional PHP extensions to PHP Docker container by following instructions in 
  `config/docker/php/Dockerfile`.
* Optional: Add additinal services (like Redis, RabbitMQ, Elasticsearch) in docker-compose.yml.

### Deployer
Deployer is pre-configured for Symfony Flex directory structure and deployment flow used in 4xxi. The only things that 
are left for manual configuration are repository settings and deploy targets:

* Update `deploy.php` with proper project name and repository configuration.
* Update `config/deployer/hosts.yaml` with proper configuration for deployment targets.

### Add Bundles and dependencies that are required by our project
Projects created by Flex include only the mininum amount of dependencies by default. Most of additional components that 
were previously a part of Symfony Standard Edition are not installed, so it is up to you to install them if they are 
really needed.

Most of components could be installed and auto-configured by Flex by running:
```bash
composer req <component>
```
The list of common Components that may be needed for the project:

* api
* asset
* form
* security
* serializer
* mailer
* translation
* twig
* validator
* workflow

### Update installation instructions

When you are done with previous steps, update Installation Instructions and remove everything above them in this file.

Installation Instructions
==========

Everything below is a template for Installation Instructions. It should be updated with the full steps for setting up
your project.

## Requirements

* [Docker and Docker Compose](https://docs.docker.com/engine/installation)
* [MacOS Only]: Docker Sync (run `gem install docker-sync` to install it)

## Configuration

Application configuration is stored in `.env` file. 

### HTTP port
If you have nginx or apache installed and using 80 port on host system you can either stop them before proceeding or 
reconfigure Docker to use another port by changing value of `SERVER_HTTP_PORT` in `.env` file.

### Application environment
You can change application environment to `dev` of `prod` by changing `APP_ENV` variable in `.env` file.

### DB name and credentials
DB name and credentials could by reconfigured by changing variables with `POSTGRES` prefix in `.env` file. It is 
recommended to restart containers after changing these values (new database will be automatically created on containers 
start).

## Installation

### 1. Start Containers and install dependencies 
On Linux:
```bash
docker-compose up -d
```
On MacOS:
```bash
docker-sync-stack start
```
### 2. Run migrations, install fixtures
```bash
docker-compose exec php bin/console doctrine:migrations:migrate
```

### 3. Build frontend
Place instructions to build frontend here.

### 4. Open project
Just go to [http://localhost](http://localhost)


Application commands
==========
Add application-specific console commands and their description here.


Useful commands and shortcuts
==========

## Shortcuts
It is recommended to add short aliases for the following frequently used container commands:

* `docker-compose exec php php` to run php in container
* `docker-compose exec php composer` to run composer
* `docker-compose exec php bin/console` to run Symfony CLI commands
* `docker-compose exec db psql` to run PostgreSQL commands


## Checking code style and running tests
Fix code style by running PHP CS Fixer:
```bash
docker-compose exec php vendor/bin/php-cs-fixer fix
```

Run PHP Unit Tests:
```bash
docker-compose exec php bin/phpunit
```