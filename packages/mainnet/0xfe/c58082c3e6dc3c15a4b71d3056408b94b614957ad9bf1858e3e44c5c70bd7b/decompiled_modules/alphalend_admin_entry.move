module 0x1b3b6dd59b769d2b64c132cd3a652eead09091a47016ea2c1ea963c7123ea1b4::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::LLVGlobal, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::assert_version(arg0);
        let v0 = 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::alphalend_position_cap_key();
        assert!(!0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::has_protocol_cap<T0, T1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::AlphaLendPositionCapKey>(arg1, v0), 1);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_validation::validate_alphalend_protocol<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2));
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::store_protocol_cap<T0, T1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg3), arg3);
    }

    public fun register_alphalend_leg_auth<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::LLVGlobal, arg1: &mut 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin::assert_version(arg0);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::register_protocol_leg_auth<T0, T1, 0x1b3b6dd59b769d2b64c132cd3a652eead09091a47016ea2c1ea963c7123ea1b4::alphalend_entry::AlphaLendLegAuth>(arg1, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_ALPHALEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

