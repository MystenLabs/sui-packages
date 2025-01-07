module 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::go_live {
    struct AddLiquidityHook has drop {
        dummy_field: bool,
    }

    public fun go_live<T0, T1>(arg0: &0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::admin::Admin, arg1: 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::seed_pool::SeedPool<0x2::sui::SUI, T0>, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x2::coin::TreasuryCap<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        go_live_<0x2::sui::SUI, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::vesting::new_config(v0, v0 + arg6, v0 + arg7), arg8, arg9);
    }

    public fun go_live_<T0, T1, T2>(arg0: &0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::admin::Admin, arg1: 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::seed_pool::SeedPool<T0, T1>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2::coin::CoinMetadata<T2>, arg5: 0x2::coin::TreasuryCap<T2>, arg6: 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::vesting::VestingConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, _, v9, v10) = 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::seed_pool::destroy_pool<T0, T1>(arg1);
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
        assert!(v15 == 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::utils::mist(0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::seed_pool::gamma_s(&v11)), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up((v15 as u256), 50000000000000000, 1000000000000000000) as u64)), arg8), 0x2::tx_context::sender(arg8));
        let v16 = 0x2::balance::split<T1>(&mut v12, 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::math::div_mul(0x2::balance::value<T1>(&v12), 10000, 8000));
        let v17 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::new_cap(arg8);
        let v18 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::new(&mut v17, arg8);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T0>(&mut v18, arg2);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T1>(&mut v18, arg3);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T2>(&mut v18, arg4);
        let v19 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::new_hooks_builder(arg8);
        let v20 = AddLiquidityHook{dummy_field: false};
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::add_rule<AddLiquidityHook>(&mut v19, 0x1::string::utf8(0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::start_add_liquidity_name()), v20);
        let v21 = 0x1::vector::empty<u256>();
        let v22 = &mut v21;
        0x1::vector::push_back<u256>(v22, 400000);
        0x1::vector::push_back<u256>(v22, 145000000000000);
        let v23 = 0x1::vector::empty<u256>();
        let v24 = &mut v23;
        0x1::vector::push_back<u256>(v24, 2000000000000);
        0x1::vector::push_back<u256>(v24, 146000000000000);
        0x1::vector::push_back<u256>(v24, 600000);
        let v25 = 0x1::vector::empty<u256>();
        let v26 = &mut v25;
        0x1::vector::push_back<u256>(v26, 26000000);
        0x1::vector::push_back<u256>(v26, 45000000);
        0x1::vector::push_back<u256>(v26, 200000000000000);
        let (v27, v28, v29) = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::new_2_pool_with_hooks<T0, T1, T2>(arg7, &v18, v19, 0x2::coin::from_balance<T0>(v13, arg8), 0x2::coin::from_balance<T1>(v16, arg8), 0x2::coin::treasury_into_supply<T2>(arg5), v21, v23, (0x2::balance::value<T0>(&v13) as u256) * 1000000000000000000 / (0x2::balance::value<T1>(&v16) as u256), v25, arg8);
        let v30 = v27;
        let v31 = 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::staking_pool::new<T0, T1, T2>(0x2::object::id<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::InterestPool<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>>(&v30), v12, 0x2::coin::into_balance<T2>(v29), arg6, v28, v6, v7, v5, arg8);
        let v32 = 0x2::object::id<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::InterestPool<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>>(&v30);
        let v33 = 0x2::object::id<0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::staking_pool::StakingPool<T0, T1, T2>>(&v31);
        0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::events::go_live<T0, T1, T2>(0x2::object::id_to_address(&v32), 0x2::object::id_to_address(&v33));
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::share<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>(v30);
        0x2::transfer::public_share_object<0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::staking_pool::StakingPool<T0, T1, T2>>(v31);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T1>(&mut v18, &v17);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T2>(&mut v18, &v17);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T0>(&mut v18, &v17);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::destroy(v18, &v17);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::destroy<0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimalsWitness>(v17);
    }

    public fun go_live_default<T0, T1>(arg0: &0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::admin::Admin, arg1: 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::seed_pool::SeedPool<0x2::sui::SUI, T0>, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x2::coin::TreasuryCap<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        go_live_<0x2::sui::SUI, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::vesting::default_config(arg6), arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

