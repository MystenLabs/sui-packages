module 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::go_live {
    struct AddLiquidityHook has drop {
        dummy_field: bool,
    }

    public fun go_live<T0, T1>(arg0: &0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::admin::Admin, arg1: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::seed_pool::SeedPool<0x2::sui::SUI, T0>, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x2::coin::TreasuryCap<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        go_live_<0x2::sui::SUI, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::new_config(v0, v0 + arg6, v0 + arg7), arg8, arg9);
    }

    public fun go_live_<T0, T1, T2>(arg0: &0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::admin::Admin, arg1: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::seed_pool::SeedPool<T0, T1>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2::coin::CoinMetadata<T2>, arg5: 0x2::coin::TreasuryCap<T2>, arg6: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, _, v9, v10) = 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::seed_pool::destroy_pool<T0, T1>(arg1);
        let v11 = v9;
        let v12 = v4;
        let v13 = v1;
        let v14 = v0;
        assert!(v10 == true, 0);
        assert!(0x2::balance::value<T1>(&v14) == 0, 1);
        0x2::balance::destroy_zero<T1>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg8), 0x2::tx_context::sender(arg8));
        let v15 = 0x2::balance::value<T0>(&v13);
        assert!(v15 == 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::utils::mist(0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::seed_pool::gamma_s(&v11)), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up((v15 as u256), 50000000000000000, 1000000000000000000) as u64)), arg8), 0x2::tx_context::sender(arg8));
        let v16 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::new_cap(arg8);
        let v17 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::new(&mut v16, arg8);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T0>(&mut v17, arg2);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T1>(&mut v17, arg3);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T2>(&mut v17, arg4);
        let v18 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::new_hooks_builder(arg8);
        let v19 = AddLiquidityHook{dummy_field: false};
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::add_rule<AddLiquidityHook>(&mut v18, 0x1::string::utf8(0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::start_add_liquidity_name()), v19);
        let v20 = 0x1::vector::empty<u256>();
        let v21 = &mut v20;
        0x1::vector::push_back<u256>(v21, 400000);
        0x1::vector::push_back<u256>(v21, 145000000000000);
        let v22 = 0x1::vector::empty<u256>();
        let v23 = &mut v22;
        0x1::vector::push_back<u256>(v23, 2000000000000);
        0x1::vector::push_back<u256>(v23, 146000000000000);
        0x1::vector::push_back<u256>(v23, 600000);
        let v24 = 0x1::vector::empty<u256>();
        let v25 = &mut v24;
        0x1::vector::push_back<u256>(v25, 26000000);
        0x1::vector::push_back<u256>(v25, 45000000);
        0x1::vector::push_back<u256>(v25, 200000000000000);
        let (v26, v27, v28) = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::new_2_pool_with_hooks<T0, T1, T2>(arg7, &v17, v18, 0x2::coin::from_balance<T0>(v13, arg8), 0x2::coin::from_balance<T1>(v12, arg8), 0x2::coin::treasury_into_supply<T2>(arg5), v20, v22, (0x2::balance::value<T0>(&v13) as u256) * 1000000000000000000 / (0x2::balance::value<T1>(&v12) as u256), v24, arg8);
        let v29 = v26;
        let v30 = 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::staking_pool::new<T0, T1, T2>(0x2::object::id<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::InterestPool<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>>(&v29), (0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::seed_pool::gamma_m(&v11) as u64), 0x2::coin::into_balance<T2>(v28), arg6, v27, v6, v7, v5, arg8);
        let v31 = 0x2::object::id<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::InterestPool<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>>(&v29);
        let v32 = 0x2::object::id<0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::staking_pool::StakingPool<T0, T1, T2>>(&v30);
        0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::events::go_live<T0, T1, T2>(0x2::object::id_to_address(&v31), 0x2::object::id_to_address(&v32));
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::share<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>(v29);
        0x2::transfer::public_share_object<0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::staking_pool::StakingPool<T0, T1, T2>>(v30);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T1>(&mut v17, &v16);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T2>(&mut v17, &v16);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T0>(&mut v17, &v16);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::destroy(v17, &v16);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::destroy<0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimalsWitness>(v16);
    }

    public fun go_live_default<T0, T1>(arg0: &0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::admin::Admin, arg1: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::seed_pool::SeedPool<0x2::sui::SUI, T0>, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x2::coin::TreasuryCap<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        go_live_<0x2::sui::SUI, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::default_config(arg6), arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

