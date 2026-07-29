module 0xd88ec02ad87a7b4c72269836bd54154533163e6daaf8c6db759499ba71562122::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::LLVGlobal, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::assert_version(arg0);
        let v0 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::navi_account_cap_key();
        assert!(!0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::has_protocol_cap<T0, T1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::NaviAccountCapKey>(arg1, v0), 1);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::store_protocol_cap<T0, T1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2), arg2);
    }

    public fun register_navi_leg_auth<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::LLVGlobal, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::assert_version(arg0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::register_protocol_leg_auth<T0, T1, 0xd88ec02ad87a7b4c72269836bd54154533163e6daaf8c6db759499ba71562122::navi_entry::NaviLegAuth>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_NAVI(), arg2);
    }

    // decompiled from Move bytecode v7
}

