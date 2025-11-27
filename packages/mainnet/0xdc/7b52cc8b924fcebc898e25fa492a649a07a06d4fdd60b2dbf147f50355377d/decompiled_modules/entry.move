module 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::assert_is_compatible<T0>(arg0);
        0xf0ff90bc955da6698827e49c8f6deeb054bd3ba6117f8574211c4b6a3aa97016::two_step_role::accept_role<0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::OwnerRole<T0>>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::owner_role_mut<T0>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::assert_is_compatible<T0>(arg0);
        0xf0ff90bc955da6698827e49c8f6deeb054bd3ba6117f8574211c4b6a3aa97016::two_step_role::begin_role_transfer<0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::OwnerRole<T0>>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::owner_role_mut<T0>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::assert_is_compatible<T0>(arg0);
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::update_blocklister<T0>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::assert_is_compatible<T0>(arg0);
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::update_master_minter<T0>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::assert_is_compatible<T0>(arg0);
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::update_metadata_updater<T0>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::assert_is_compatible<T0>(arg0);
        0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::roles::update_pauser<T0>(0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

