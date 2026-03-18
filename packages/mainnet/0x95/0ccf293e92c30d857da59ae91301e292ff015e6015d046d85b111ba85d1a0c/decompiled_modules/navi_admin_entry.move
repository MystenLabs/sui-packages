module 0x950ccf293e92c30d857da59ae91301e292ff015e6015d046d85b111ba85d1a0c::navi_admin_entry {
    public entry fun init_navi_account_cap<T0, T1>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &mut 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::store_protocol_cap<T0, T1, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::navi_account_cap_key(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3));
    }

    // decompiled from Move bytecode v6
}

