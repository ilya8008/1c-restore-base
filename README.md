1c-restore-base
=========

Роль восстанавливает базы PostgreSQL и регестрирует их на сервере 1C.

Название базы данных берется из файла дампа.

Требования
--------------

Установленный сервер БД PostgreSQL и сервер 1С.
В каталог files/dumps нужно поместить файлы дампов БД .sql.gz, которые нужно восстановить.

Переменные
--------------

Переменные не используются.

Пример playbook
--------------

```
- name: Restore base
  hosts: erp
  become: true
  roles:
    - 1c-restore-base
```