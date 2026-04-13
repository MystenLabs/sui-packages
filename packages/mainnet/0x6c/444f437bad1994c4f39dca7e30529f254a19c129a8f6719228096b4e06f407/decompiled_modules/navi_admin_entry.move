module 0x6c444f437bad1994c4f39dca7e30529f254a19c129a8f6719228096b4e06f407::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::LLVGlobal, arg1: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg2: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::LLVPoolAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::assert_version(arg0);
        let v0 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::navi_account_cap_key();
        assert!(!0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::has_protocol_cap<T0, T1, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::NaviAccountCapKey>(arg1, v0), 1);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::store_protocol_cap<T0, T1, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, arg2, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3));
    }

    // decompiled from Move bytecode v7
}

