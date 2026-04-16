module 0x69d4ebbaf3c4a86b5c42d16c92d85d37633661170391df2a92634e13ee02e07b::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::LLVGlobal, arg1: &mut 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::LLVPool<T0, T1>, arg2: &0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::LLVPoolAdminCap, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x2::tx_context::TxContext) {
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin::assert_version(arg0);
        let v0 = 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::alphalend_position_cap_key();
        assert!(!0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::has_protocol_cap<T0, T1, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::AlphaLendPositionCapKey>(arg1, v0), 1);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::store_protocol_cap<T0, T1, 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, arg2, v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg3, arg4));
    }

    // decompiled from Move bytecode v7
}

