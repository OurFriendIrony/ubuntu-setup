#!/bin/bash

application="${1}.desktop"
home="/home/${USER}"
favourites_source="/usr/share/applications"
favourites_dest="${home}/.cinnamon/panel-launchers"
favourites_config="${home}/.cinnamon/configs/grouped-window-list@cinnamon.org/3.json"

already_exists() {
  test=$(jq '.["pinned-apps"].value[] | select( contains("'${application}'") ) ' ${favourites_config} )
  if [[ -n "${test}" ]]
    then echo true; else echo false; fi
}

if ! $(already_exists) ; then
  # symlink the desktop file
  ln -sf "${favourites_source}/${application}" "${favourites_dest}/${application}"

  # Add the desktop file name to the configuration file
  jq --indent 4 '.["pinned-apps"].value[.["pinned-apps"].value| length] |= .+ "'${application}'"' "${favourites_config}" > "${favourites_config}_tmp" && mv "${favourites_config}_tmp" "${favourites_config}"
fi


