module 0xb3a1b5a105a7de087cad11ffa3e9e0aff4481e264bb94c9341b174a023132c31::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::store_protocol_cap<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::navi_account_cap_key(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3));
    }

    // decompiled from Move bytecode v6
}

