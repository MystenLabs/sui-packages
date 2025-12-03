module 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::robot {
    public entry fun set_k_for_robot_v2<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::ACL, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        assert!(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::is_robot(arg0, 0x2::tx_context::sender(arg3)), 1);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_k<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_liquidity_provider_fee_rate_for_robot_v2<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::ACL, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        assert!(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::is_robot(arg0, 0x2::tx_context::sender(arg3)), 1);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_liquidity_provider_fee_rate<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_protocol_fee_rate_for_robot_v2<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::ACL, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        assert!(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::ownable::is_robot(arg0, 0x2::tx_context::sender(arg3)), 1);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_protocol_fee_rate<T0, T1>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

