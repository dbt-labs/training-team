--this will be used when an organization wants all developers working in the same schema (i.e. no unique dev schemas)
--this will ensure that no developer is creating/replacing existing tables and views that other developers are utilizing as they share schemas


--this macro is dependent on the creation of an environment variable called DBT_IN_DEV
--the environment variable is set to true in the dev environment and defaults to false in all others
{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if custom_alias_name is none -%}

        {% if env_var('DBT_IN_DEV') == 'true' %}
        
--this will prepend the target.schema (developer specific) to the node to make model names unique in the data platform
              {{ target.schema }}_{{ node.name }}

            {%- else -%}

                   {{ node.name }}

        {% endif %}
 

    {%- else -%}
    
        {% if env_var('DBT_IN_DEV') == 'true' %}

--this will ensure that, if a custom alias is created for a model, the target.schema (developer specific) is still prepended
              {{ target.schema }}_{{ custom_alias_name | trim }}

            {%- else -%}

                     {{ custom_alias_name | trim }}

        {% endif %}

    {%- endif -%}

{%- endmacro %}