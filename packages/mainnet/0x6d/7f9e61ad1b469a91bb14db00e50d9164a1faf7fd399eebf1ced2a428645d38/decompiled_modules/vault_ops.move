module 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault_ops {
    public fun close_vault(arg0: &0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg5: &mut 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>, arg6: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let (v0, v1) = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::close_position(arg1, arg2, 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::take_out_position<0x2::sui::SUI>(arg5), arg3, false, arg7);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v3, arg6);
        let (v4, v5) = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::fully_repay_with_strap<0x2::sui::SUI>(arg4, 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::take_out_strap<0x2::sui::SUI>(arg5), v3, arg7);
        0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::stop<0x2::sui::SUI>(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut v2, v5);
        (v4, v2)
    }

    public entry fun close_vault_entry(arg0: &0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg5: &mut 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = close_vault(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg6), arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v0, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun open_vault(arg0: &0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg4: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg5: &mut 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::precision<0x2::sui::SUI>(arg5);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let (v3, v4) = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::get_ticker_interval<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::lower_tick_deviation<0x2::sui::SUI>(arg5)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::upper_tick_deviation<0x2::sui::SUI>(arg5)), arg2);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg1, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4), arg8);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg1, arg2, &mut v5, 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::get_lp_amount(v2, 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::get_lp_ratio<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(v3, v4, v0, arg2), 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::neutral_coll_rate<0x2::sui::SUI>(arg5), v0), false, arg7);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(&v6);
        let v9 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::new<0x2::sui::SUI>(arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg1, arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_with_strap<0x2::sui::SUI>(arg3, arg4, &v9, arg7, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v2 - v8), v7, 0x1::option::none<address>(), arg8), v1, v6);
        0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::put_in_position<0x2::sui::SUI>(arg5, v5);
        0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::put_in_strap<0x2::sui::SUI>(arg5, v9);
        0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::run<0x2::sui::SUI>(arg5);
    }

    public fun rebalance(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg4: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg5: &mut 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::neutral_coll_rate<0x2::sui::SUI>(arg5);
        let v1 = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::precision<0x2::sui::SUI>(arg5);
        let v2 = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::borrow_strap<0x2::sui::SUI>(arg5);
        let (v3, v4) = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::close_position(arg0, arg1, 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::take_out_position<0x2::sui::SUI>(arg5), arg2, false, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<0x2::sui::SUI>(v2);
        let (v8, v9) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_with_interest_by_debtor<0x2::sui::SUI>(arg3, v7, arg6);
        let (v10, v11) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<0x2::sui::SUI>(arg4, arg6);
        let (v12, v13) = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::get_ticker_interval<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::lower_tick_deviation<0x2::sui::SUI>(arg5)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::upper_tick_deviation<0x2::sui::SUI>(arg5)), arg1);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v12), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v13), arg7);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, arg1, &mut v14, 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::get_lp_amount(0x2::balance::value<0x2::sui::SUI>(&v5) + v8 - (((((v9 as u128) * (v11 as u128) / (v10 as u128)) as u128) * (v0 as u128) / (v1 as u128)) as u64), 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::util::get_lp_ratio<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(v12, v13, v1, arg1), v0, v1), false, arg6);
        let (v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(&v15);
        let v18 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        let v19 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v6);
        if (v18 > v17) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up_coll<0x2::sui::SUI>(arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v18 - v17), v7, 0x1::option::some<address>(v7), arg6);
        };
        if (v19 > v16) {
            let v20 = 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, v19 - v16);
            assert!(0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v20) <= v9, 222);
            assert!(v9 - 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v20) > 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_min_bottle_size(arg3), 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v20));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up_coll<0x2::sui::SUI>(arg3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_with_strap<0x2::sui::SUI>(arg3, v2, v20, arg6), v7, 0x1::option::some<address>(v7), arg6);
        };
        if (v18 < v17) {
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::withdraw_with_strap<0x2::sui::SUI>(arg3, arg4, v2, arg6, v17 - v18, 0x1::option::some<address>(v7)));
        };
        if (v19 < v16) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_with_strap<0x2::sui::SUI>(arg3, arg4, v2, arg6, 0x2::balance::zero<0x2::sui::SUI>(), v16 - v19, 0x1::option::some<address>(v7), arg7));
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, arg1, v6, v5, v15);
        0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::put_in_position<0x2::sui::SUI>(arg5, v14);
    }

    // decompiled from Move bytecode v6
}

