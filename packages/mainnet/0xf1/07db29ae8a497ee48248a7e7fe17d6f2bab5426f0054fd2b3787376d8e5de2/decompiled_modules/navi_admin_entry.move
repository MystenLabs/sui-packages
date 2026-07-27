module 0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_entry::authorize(arg0);
        let v0 = 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::navi_account_cap_key();
        assert!(!0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::has_protocol_cap<T0, T1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::NaviAccountCapKey>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_NAVI(), v0), 1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::store_protocol_cap<T0, T1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_NAVI(), v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2), arg2);
    }

    public fun migrate(arg0: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_entry::migration_witness();
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::migrate_ext_version<0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_entry::NaviLegAuth>(arg0, arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_NAVI(), 0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_entry::package_version(), &v0, arg2);
    }

    public fun register_navi_leg_auth<T0, T1>(arg0: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin::LLVGlobal, arg1: &mut 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_entry::authorize(arg0);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_pool::register_protocol_leg_auth<T0, T1, 0x2ab66cab8679dcf55efcfc7e71e3ead4b2d2b8a574a94efa8838121874578101::navi_entry::NaviLegAuth>(arg1, 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::PROTOCOL_NAVI(), arg2);
    }

    // decompiled from Move bytecode v7
}

