module 0x80d360fb8c0964d33a5e7415df8f26ddb2db87dbd58ef95e54d2041f1f5c053e::trial {
    struct TestInfo has copy, drop {
        value: u64,
        result: u64,
    }

    public fun optimize_by_trial_xsui<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>) : (u64, u64) {
        let v0 = 0xdd03647429c161fa9fe0b7cfb7ec76d361c30b71c4c68973a43bf9b133e52141::info::optimize(arg0, arg1, arg2, arg3, arg4, 500);
        if (v0 <= 100000000000000) {
            return (v0, 0)
        };
        let v1 = 100000000000000;
        let v2 = v1;
        if (arg4 + v1 < arg0) {
            v2 = arg0 - arg4;
        };
        let v3 = try_xsui<T0>(v2, arg0, arg1, arg4, arg5, arg6, arg7);
        while (v2 < 2000000000000000) {
            let v4 = v2 + 50000000000000;
            let v5 = try_xsui<T0>(v4, arg0, arg1, arg4, arg5, arg6, arg7);
            if (v5 > v3) {
                v2 = v4;
                v3 = v5;
            } else {
                let v6 = TestInfo{
                    value  : v4,
                    result : v5,
                };
                0x2::event::emit<TestInfo>(v6);
                break
            };
        };
        (v2, v3)
    }

    public entry fun test_trial<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg5: &0x2::clock::Clock) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, v2) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(v0, 0x1::option::destroy_some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v0)), arg5);
        let (v3, v4) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg5);
        let (v5, v6) = optimize_by_trial_xsui<T0>(v2, v1, v3, v4, 0xdd03647429c161fa9fe0b7cfb7ec76d361c30b71c4c68973a43bf9b133e52141::info::get_reserve_balance<T0>(arg0), arg2, arg3, arg4);
        let v7 = TestInfo{
            value  : v5,
            result : v6,
        };
        0x2::event::emit<TestInfo>(v7);
    }

    fun try_xsui<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>) : u64 {
        let v0 = (arg3 as u128) + (arg0 as u128);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg4, true, true, (((arg0 as u128) * (arg2 as u128) / v0) as u64));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg5, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg6, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2));
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3);
        let v5 = (((arg0 as u128) * (arg1 as u128) / v0) as u64) + (((arg0 as u128) * (500 as u128) / (1000000 as u128)) as u64);
        if (v4 > v5) {
            return v4 - v5
        };
        0
    }

    // decompiled from Move bytecode v6
}

