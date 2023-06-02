--this will be used when an organization wants all developers working in the same schema (i.e. no unique dev schemas)

--this macro is dependent on the creation of an environment variable called DBT_IN_DEV
--the environment variable is set to true in the dev environment and defaults to false in all others

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    
    {% if env_var('DBT_IN_DEV') == 'true' %}
    
--this is where you will indicate the specific schema to which the dev environment will write
            whatever_schema
            
    {%- elif custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {{ default_schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}