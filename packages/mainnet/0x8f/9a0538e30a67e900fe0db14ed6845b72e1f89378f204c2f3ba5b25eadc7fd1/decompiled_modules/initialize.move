module 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::initialize {
    struct AddLiquidityHook has drop {
        dummy_field: bool,
    }

    public fun sui(arg0: u64) : u64 {
        1000000000 * arg0
    }

    public fun init_secondary_market<T0: key, T1: key, T2: key>(arg0: &0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::admin::Admin, arg1: 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::SeedPool, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: 0x2::coin::TreasuryCap<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, _, _, v7, v8) = 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound_curve_amm::destroy_pool<T0, 0x2::sui::SUI, T1>(arg1);
        let v9 = v4;
        let v10 = v1;
        let v11 = v0;
        assert!(v7, 0);
        assert!(0x2::balance::value<T0>(&v11) == 0, 0);
        0x2::balance::destroy_zero<T0>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg6), 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg6), 0x2::tx_context::sender(arg6));
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        assert!(v12 == sui(30000), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10, (0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::mul_div_up((v12 as u256), 50000000000000000, 1000000000000000000) as u64)), arg6), 0x2::tx_context::sender(arg6));
        let v13 = 0x2::balance::split<T1>(&mut v9, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::math::div_mul(0x2::balance::value<T1>(&v9), 10000, 8000));
        let v14 = 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::new(arg6);
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::add<0x2::sui::SUI>(&mut v14, arg2);
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::coin_decimals::add<T1>(&mut v14, arg3);
        let v15 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_hooks_builder(arg6);
        let v16 = AddLiquidityHook{dummy_field: false};
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::add_rule<AddLiquidityHook>(&mut v15, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_add_liquidity()), v16);
        let v17 = 0x1::vector::empty<u256>();
        let v18 = &mut v17;
        0x1::vector::push_back<u256>(v18, 400000);
        0x1::vector::push_back<u256>(v18, 145000000000000);
        let v19 = 0x1::vector::empty<u256>();
        let v20 = &mut v19;
        0x1::vector::push_back<u256>(v20, 2000000000000);
        0x1::vector::push_back<u256>(v20, 146000000000000);
        0x1::vector::push_back<u256>(v20, 600000);
        let v21 = 0x1::vector::empty<u256>();
        let v22 = &mut v21;
        0x1::vector::push_back<u256>(v22, 260000000000000000);
        0x1::vector::push_back<u256>(v22, 450000000000000000);
        0x1::vector::push_back<u256>(v22, 200000000000000);
        let (v23, v24, v25) = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_clamm_volatile_hooks::new_2_pool<0x2::sui::SUI, T1, T2>(arg5, v15, 0x2::coin::from_balance<0x2::sui::SUI>(v10, arg6), 0x2::coin::from_balance<T1>(v13, arg6), &v14, 0x2::coin::treasury_into_supply<T2>(arg4), v17, v19, (0x2::balance::value<0x2::sui::SUI>(&v10) as u256) * 1000000000000000000 / (0x2::balance::value<T1>(&v13) as u256), v21, arg6);
        let v26 = v23;
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::share<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>(v26);
        0x2::transfer::public_share_object<0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::staking_pool::StakingPool<T0, T1, T2>>(0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::staking_pool::new<T0, T1, T2>(0x2::object::id<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::curves::Volatile>>(&v26), v9, 0x2::coin::into_balance<T2>(v25), 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::vesting::default_config(arg5), v24, v8, arg6));
        0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::coin_decimals::destroy_coin_decimals(v14, arg6);
    }

    // decompiled from Move bytecode v6
}

