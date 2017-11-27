<?php

namespace Deployer;

require 'recipe/symfony3.php';

// Application settings
set('application', 'my_project');                   // Set application name
set('repository', '');                              // Set repository
inventory('config/deployer/hosts.yaml');            // Set deploy targets in this file

// Basic settings
set('default_stage', 'dev');
set('ssh_multiplexing', false);
set('allow_anonymous_stats', false);
set('git_tty', true);

// Shared and writable files/dirs between deploys
add('shared_files', []);
set('clear_paths', []);
set('shared_dirs', ['var/log', 'var/sessions']);
set('writable_dirs', ['var/cache', 'var/log', 'var/sessions']);

// Additional pre and post deploy jobs
before('deploy:symlink', 'database:migrate');
after('deploy:failed', 'deploy:unlock');
after('deploy:symlink', 'php-fpm:restart');
