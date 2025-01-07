module 0xaa76146010b9c4c3b0ba83ab48351ec791a8179cb19b5dedf22da2e331ca1cba::info {
    struct TestInfo has copy, drop {
        value: u64,
    }

    public fun get_income(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : 0x1::option::Option<u64> {
        let v0 = arg5 + arg4;
        let v1 = arg5 + (((((((((arg1 as u128) * (arg5 as u128) / (v0 as u128)) as u64) as u128) * (arg2 as u128) / (arg3 as u128)) as u64) as u128) * (arg6 as u128) / (10000 as u128)) as u64);
        let v2 = (((arg0 as u128) * (arg5 as u128) / (v0 as u128)) as u64) + (((arg5 as u128) * (arg7 as u128) / (1000000 as u128)) as u64);
        if (v1 >= v2) {
            return 0x1::option::some<u64>(v1 - v2)
        };
        0x1::option::none<u64>()
    }

    public fun get_reserve_balance<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_reserve_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_tank<T0>(arg0))
    }

    public fun optimize(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = ((0x2::math::sqrt_u128((arg4 as u128) * (((((arg1 as u128) * (arg2 as u128) / (arg3 as u128)) as u64) - arg0) as u128) / (arg5 as u128)) * (1000 as u128)) as u64);
        let v1 = if (arg4 < arg0) {
            if (v0 >= arg0) {
                v0 - arg4
            } else {
                arg0 - arg4
            }
        } else if (v0 >= arg4) {
            v0 - arg4
        } else {
            0
        };
        if (v1 <= 2000000000000000) {
            return v1
        };
        2000000000000000
    }

    public entry fun test<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, v2) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(v0, 0x1::option::destroy_some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v0)), arg2);
        let (v3, v4) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let v5 = TestInfo{value: optimize(v2, v1, v3, v4, get_reserve_balance<T0>(arg0), 500)};
        0x2::event::emit<TestInfo>(v5);
    }

    // decompiled from Move bytecode v6
}

