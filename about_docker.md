Tool - Generic Filter [Dockerfile]
=======

Metadata
-----------

 * **@name**: Tool - Generic Filter [Dockerfile]
 * **@version**: 0.1
 * **@authors**: Nils Paulhe <nils.paulhe@inra.fr> (Only the docker part)
 * **@date creation**: 2017/09/04
 * **@main usage**: create a Docker environment / container for "Tool - Generic Filter"

 About
-----------
For all informations about the tool please refer to its [README file](README.txt). 
For further informations about PhenoMeNal project and the people involved, Please refer to [PhenoMeNal github](https://github.com/phnmnl) main page. 
 
Configuration
-----------

### Requirement:
 * Docker Engine, Docker skills
 * a Galaxy server docker compliant

### Warning:
 * These scripts are provided WITHOUT ANY WARRANTY. 
 * These scripts should be run by an administrator system (expert).

Services provided
-----------
Build a docker container for "Tool - Generic Filter" Galaxy Tool.
Provide a XML Galaxy wrapper: [generic_filter.docker.xml](generic_filter.docker.xml)
 
Technical description
-----------

### Create the docker container

``` bash
docker build -t docker-registry.phenomenal-h2020.eu/phnmnl/tool-generic_filter:2017.06 .
```

### Add the tool in Galaxy

Note: the files name and path are just examples. Adapt them to your own Galaxy configuration / practices.

If required, add in `config/job_conf.xml` file the minimal docker options:

``` xml
    <destinations default="docker_local">
        <destination id="local" runner="local"/>
        <destination id="docker_local" runner="local">
          <param id="docker_enabled">true</param>
          <param id="docker_sudo">false</param>
       </destination>
    </destinations>
```

For more options please refer to the [official documentation](https://galaxyproject.org/admin/tools/docker/).

Copy or create a symbolic link of [generic_filter.docker.xml](generic_filter.docker.xml) file into your `tools/docker` directory (feel free to create or change the target directory). 
Then add this XML resource in your `config/tool_conf.xml` file. For example:

``` xml
    <section id="docker_tools" name="Docker Tools">
      <tool file="docker/generic_filter.docker.xml"/>
    </section>
```

Notes
-----------
TODO

License (Dockerfile only!)
-----------
This script is under the following license:
GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
 ```
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
 
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
```