module 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::go_live {
    struct AddLiquidityHook has drop {
        dummy_field: bool,
    }

    public fun go_live<T0, T1, T2>(arg0: &0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::admin::Admin, arg1: 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::seed_pool::SeedPool, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: 0x2::coin::TreasuryCap<T2>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        go_live_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::new_config(v0, v0 + arg5, v0 + arg6), arg7, arg8);
    }

    public fun go_live_<T0, T1, T2>(arg0: &0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::admin::Admin, arg1: 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::seed_pool::SeedPool, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: 0x2::coin::TreasuryCap<T2>, arg5: 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, _, _, v7, v8) = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::seed_pool::destroy_pool<T0, 0x2::sui::SUI, T1>(arg1);
        let v9 = v4;
        let v10 = v1;
        let v11 = v0;
        assert!(v7, 0);
        assert!(0x2::balance::value<T0>(&v11) == 0, 0);
        0x2::balance::destroy_zero<T0>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg7), 0x2::tx_context::sender(arg7));
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        assert!(v12 == 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::utils::mist(30000), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10, (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up((v12 as u256), 50000000000000000, 1000000000000000000) as u64)), arg7), 0x2::tx_context::sender(arg7));
        let v13 = 0x2::balance::split<T1>(&mut v9, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math::div_mul(0x2::balance::value<T1>(&v9), 10000, 8000));
        let v14 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::new_cap(arg7);
        let v15 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::new(&mut v14, arg7);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<0x2::sui::SUI>(&mut v15, arg2);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::add<T1>(&mut v15, arg3);
        let v16 = 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::interest_pool::new_hooks_builder(arg7);
        let v17 = AddLiquidityHook{dummy_field: false};
        0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::interest_pool::add_rule<AddLiquidityHook>(&mut v16, 0x1::string::utf8(0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::interest_pool::start_add_liquidity_name()), v17);
        let v18 = 0x1::vector::empty<u256>();
        let v19 = &mut v18;
        0x1::vector::push_back<u256>(v19, 400000);
        0x1::vector::push_back<u256>(v19, 145000000000000);
        let v20 = 0x1::vector::empty<u256>();
        let v21 = &mut v20;
        0x1::vector::push_back<u256>(v21, 2000000000000);
        0x1::vector::push_back<u256>(v21, 146000000000000);
        0x1::vector::push_back<u256>(v21, 600000);
        let v22 = 0x1::vector::empty<u256>();
        let v23 = &mut v22;
        0x1::vector::push_back<u256>(v23, 260000000000000000);
        0x1::vector::push_back<u256>(v23, 450000000000000000);
        0x1::vector::push_back<u256>(v23, 200000000000000);
        let (v24, v25, v26) = 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::interest_clamm_volatile::new_2_pool_with_hooks<0x2::sui::SUI, T1, T2>(arg6, &v15, v16, 0x2::coin::from_balance<0x2::sui::SUI>(v10, arg7), 0x2::coin::from_balance<T1>(v13, arg7), 0x2::coin::treasury_into_supply<T2>(arg4), v18, v20, (0x2::balance::value<0x2::sui::SUI>(&v10) as u256) * 1000000000000000000 / (0x2::balance::value<T1>(&v13) as u256), v22, arg7);
        let v27 = v24;
        0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::interest_pool::share<0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::curves::Volatile>(v27);
        0x2::transfer::public_share_object<0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::staking_pool::StakingPool<T0, T1, T2>>(0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::staking_pool::new<T0, T1, T2>(0x2::object::id<0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::interest_pool::InterestPool<0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::curves::Volatile>>(&v27), v9, 0x2::coin::into_balance<T2>(v26), arg5, v25, v8, arg7));
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<0x2::sui::SUI>(&mut v15, &v14);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::remove_and_destroy<T1>(&mut v15, &v14);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::destroy(v15, &v14);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::destroy<0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals::CoinDecimalsWitness>(v14);
    }

    public fun go_live_default<T0, T1, T2>(arg0: &0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::admin::Admin, arg1: 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::seed_pool::SeedPool, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: 0x2::coin::TreasuryCap<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        go_live_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::default_config(arg5), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

