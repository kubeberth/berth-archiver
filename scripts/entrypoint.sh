#!/bin/bash -x

set -eu

mc alias set minio ${URL} ${ACCESS_KEY} ${SECRET_KEY}

if [ ${MODE} == "Create" ]; then
  if [ ${SOURCE} == "Archive" ]; then
    mc cp "${TARGET}/${SOURCE_NAME}.qcow2" "./${ARCHIVE_NAME}.qcow2"
    mc cp "./${ARCHIVE_NAME}.qcow2" ${TARGET}
  elif [ ${SOURCE} == "Disk" ]; then
    if [ ${VOLUME_MODE} == "Block" ]; then
      qemu-img convert -c -o compat=0.10 -f raw "/dev/${SOURCE_NAME}" -O qcow2 "${ARCHIVE_NAME}.qcow2"
    elif [ ${VOLUME_MODE} == "Filesystem" ]; then
      qemu-img convert -c -o compat=0.10 -f raw "/tmp/${SOURCE_NAME}/disk.img" -O qcow2 "${ARCHIVE_NAME}.qcow2"
    fi
    mc cp "${ARCHIVE_NAME}.qcow2" ${TARGET}
  fi
elif [ ${MODE} == "Delete" ]; then
  mc rm "${TARGET}/${ARCHIVE_NAME}.qcow2"
fi

exit 0
