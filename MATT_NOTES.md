## Fixes
https://stackoverflow.com/questions/829468/how-to-perform-boostfilesystem-copy-file-with-overwrite
https://www.boost.org/doc/libs/1_75_0/libs/filesystem/doc/reference.html
- 447
    - from: bf::copy_file(old_file, new_save_file, bf::copy_options::overwrite_existing);
    - to: bf::copy_file(old_file, new_save_file, bf::copy_option::overwrite_existing);
- 509
  - from: bf::copy_file(old_file, new_save_file, bf::copy_options::overwrite_existing);
  - to: bf::copy_file(old_file, new_save_file, bf::copy_option::overwrite_if_exists);
- Makefile
  - LIBS += -lboost_system

## Cheat
- docker cp src/houseedit.cpp awakemud_cp:/app/src/houseedit.cpp
- docker-compose down ; docker rmi awakemud-mud
- vi /app/SQL/gensql_new.sh