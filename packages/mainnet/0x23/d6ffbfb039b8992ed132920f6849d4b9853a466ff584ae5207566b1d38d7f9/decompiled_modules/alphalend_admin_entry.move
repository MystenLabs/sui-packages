module 0x61aafa2b768f59d8992dbdad6ca80c6ad1dd65492447de8f451c91daa8f59db3::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin::LLVGlobal, arg1: &mut 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::LLVPool<T0, T1>, arg2: &0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin::LLVPoolAdminCap, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x2::tx_context::TxContext) {
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin::assert_version(arg0);
        let v0 = 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::alphalend_position_cap_key();
        assert!(!0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::has_protocol_cap<T0, T1, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::AlphaLendPositionCapKey>(arg1, v0), 1);
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_validation::validate_alphalend_protocol<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg3));
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::store_protocol_cap<T0, T1, 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, arg2, v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg3, arg4));
    }

    // decompiled from Move bytecode v7
}

