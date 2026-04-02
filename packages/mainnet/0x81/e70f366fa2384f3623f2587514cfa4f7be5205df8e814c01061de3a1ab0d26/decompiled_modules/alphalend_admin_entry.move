module 0x628c8974d7796a6df325d76e13b57ca006cc58561a696ada90a34f23534ca3ba::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::store_protocol_cap<T0, T1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, arg2, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::alphalend_position_cap_key(), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg3, arg4));
    }

    // decompiled from Move bytecode v7
}

