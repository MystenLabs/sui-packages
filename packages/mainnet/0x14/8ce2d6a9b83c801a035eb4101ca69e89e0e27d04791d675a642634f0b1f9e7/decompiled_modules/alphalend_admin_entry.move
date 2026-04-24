module 0x148ce2d6a9b83c801a035eb4101ca69e89e0e27d04791d675a642634f0b1f9e7::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVGlobal, arg1: &mut 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>, arg2: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVPoolAdminCap, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x2::tx_context::TxContext) {
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::assert_version(arg0);
        let v0 = 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::alphalend_position_cap_key();
        assert!(!0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::has_protocol_cap<T0, T1, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::AlphaLendPositionCapKey>(arg1, v0), 1);
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::store_protocol_cap<T0, T1, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, arg2, v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg3, arg4));
    }

    // decompiled from Move bytecode v7
}

