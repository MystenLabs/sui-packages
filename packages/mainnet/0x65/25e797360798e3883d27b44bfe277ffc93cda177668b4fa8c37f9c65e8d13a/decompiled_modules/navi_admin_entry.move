module 0x863f7d66acce207fbc06fe8fa6f6b0dc3fca1b822481eedd94a2fcd32fc11755::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin::LLVGlobal, arg1: &mut 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg2: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin::LLVPoolAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin::assert_version(arg0);
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::navi_account_cap_key();
        assert!(!0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::has_protocol_cap<T0, T1, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::NaviAccountCapKey>(arg1, v0), 1);
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::store_protocol_cap<T0, T1, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, arg2, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3));
    }

    // decompiled from Move bytecode v7
}

