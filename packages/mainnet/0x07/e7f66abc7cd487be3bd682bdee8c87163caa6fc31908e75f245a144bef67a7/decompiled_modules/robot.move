module 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::robot {
    public fun after_set_boost<T0>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_robot(arg0, 0x2::tx_context::sender(arg5)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::after_set_boost<T0>(arg1, arg2, arg3, arg4);
    }

    public fun set_boost(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_robot(arg0, 0x2::tx_context::sender(arg4)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::set_boost(arg1, *0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public fun after_set_boost_batch<T0>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg4: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg5: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg6: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg7: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_robot(arg0, 0x2::tx_context::sender(arg9)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::after_set_boost<T0>(arg1, arg2, arg3, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::after_set_boost<T0>(arg1, arg2, arg4, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::after_set_boost<T0>(arg1, arg2, arg5, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::after_set_boost<T0>(arg1, arg2, arg6, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::after_set_boost<T0>(arg1, arg2, arg7, arg8);
    }

    public fun settle_batch<T0>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Pool<T0>, arg3: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg4: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg5: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg6: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg7: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Deposit<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_robot(arg0, 0x2::tx_context::sender(arg9)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::settle<T0>(arg1, arg2, arg3, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::settle<T0>(arg1, arg2, arg4, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::settle<T0>(arg1, arg2, arg5, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::settle<T0>(arg1, arg2, arg6, arg8);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::settle<T0>(arg1, arg2, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

