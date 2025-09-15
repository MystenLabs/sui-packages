module 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::assert_is_compatible<T0>(arg0);
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::two_step_role::accept_role<0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::OwnerRole<T0>>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::owner_role_mut<T0>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::assert_is_compatible<T0>(arg0);
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::two_step_role::begin_role_transfer<0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::OwnerRole<T0>>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::owner_role_mut<T0>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::assert_is_compatible<T0>(arg0);
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::update_blocklister<T0>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::assert_is_compatible<T0>(arg0);
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::update_master_minter<T0>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::assert_is_compatible<T0>(arg0);
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::update_metadata_updater<T0>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::assert_is_compatible<T0>(arg0);
        0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::roles::update_pauser<T0>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

