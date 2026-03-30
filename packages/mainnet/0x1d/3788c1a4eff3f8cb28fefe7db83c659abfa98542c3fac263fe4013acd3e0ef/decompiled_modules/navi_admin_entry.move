module 0xcf822cf5deb2ec729f5d05dc57b6b6df7f6df256e489c2e5bd820579c12ea8ce::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVGlobal, arg1: &mut 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::LLVPool<T0, T1>, arg2: &0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::LLVPoolAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_admin::assert_version(arg0);
        0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::store_protocol_cap<T0, T1, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, arg2, 0xc0b2d3f71a30453e0606923a024acf9597909c8c5ec78ee84ee00d2d26f269d3::llv_pool::navi_account_cap_key(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3));
    }

    // decompiled from Move bytecode v6
}

