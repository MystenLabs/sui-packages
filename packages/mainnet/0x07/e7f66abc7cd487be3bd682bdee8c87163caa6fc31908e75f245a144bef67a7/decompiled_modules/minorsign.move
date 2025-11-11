module 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::minorsign {
    public fun add_pool<T0>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_minor_sign(arg0, 0x2::tx_context::sender(arg2)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::add_pool<T0>(arg1, arg2);
    }

    public fun add_reward_config<T0, T1>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_minor_sign(arg0, 0x2::tx_context::sender(arg7)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::add_reward_config<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun flip_boost<T0, T1>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_minor_sign(arg0, 0x2::tx_context::sender(arg4)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::flip_boost<T0, T1>(arg2, arg3);
    }

    public fun set_pool<T0>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_minor_sign(arg0, 0x2::tx_context::sender(arg4)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::set_pool<T0>(arg2, arg3);
    }

    public fun set_reward_config<T0, T1>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_minor_sign(arg0, 0x2::tx_context::sender(arg6)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::set_reward_config<T0, T1>(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

