module 0x80af0e4ef49f4cad2bf12353c72d0c64bf4b26ab71474f23b284e3b9c709ca7::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVGlobal, arg1: &mut 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::LLVPool<T0, T1>, arg2: &0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::LLVPoolAdminCap, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x2::tx_context::TxContext) {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_admin::assert_version(arg0);
        let v0 = 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::alphalend_position_cap_key();
        assert!(!0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::has_protocol_cap<T0, T1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::AlphaLendPositionCapKey>(arg1, v0), 1);
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::store_protocol_cap<T0, T1, 0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, arg2, v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg3, arg4));
    }

    // decompiled from Move bytecode v7
}

