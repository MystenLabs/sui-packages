module 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::graduation {
    struct TokenGraduatedEvent has copy, drop {
        coin_address: address,
        graduation_time: u64,
        target_price: u64,
        actual_initial_price: u64,
        price_difference_bps: u64,
        token_utilization_bps: u64,
        cetus_pool_sui_liquidity: u64,
        cetus_pool_token_liquidity: u64,
        total_supply_in_circulation: u64,
        amm_pool_id: address,
        market_cap: u64,
    }

    struct CetusPoolCreatedEvent has copy, drop {
        pool_id: address,
        position_id: address,
        token_a_type: 0x1::string::String,
        token_b_type: 0x1::string::String,
        initial_liquidity_a: u64,
        initial_liquidity_b: u64,
        tick_spacing: u32,
        sqrt_price: u128,
    }

    fun calculate_actual_amm_price(arg0: u64, arg1: u64, arg2: u8) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::pow(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(10), (arg2 as u64))))), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1)))
    }

    fun calculate_full_range_ticks() : (u32, u32) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200)
    }

    public fun calculate_initial_sqrt_price(arg0: u64, arg1: u64) : u128 {
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::sqrt(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(1000000)), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1))) << 64
    }

    fun calculate_price_difference_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(v0), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(10000)), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg0)))
    }

    public fun check_graduation_eligibility(arg0: &0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::Launchpad, arg1: u64, arg2: bool) : bool {
        if (arg2) {
            return false
        };
        arg1 >= 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::get_graduation_threshold(arg0)
    }

    public fun execute_graduation<T0>(arg0: &mut 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::Launchpad, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: address, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg13: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg14: &0x2::coin::CoinMetadata<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (u64, u64, address) {
        assert!(!arg9, 0);
        assert!(check_graduation_eligibility(arg0, arg10, arg9), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::from_balance<T0>(arg3, arg16);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = calculate_initial_sqrt_price(v0, v2);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg11, arg12, arg1, arg16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg11, arg12, 200, &v4, arg16);
        let (v5, v6) = calculate_full_range_ticks();
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2_with_creation_cap<T0, 0x2::sui::SUI>(arg11, arg12, &v4, 200, v3, 0x1::string::utf8(b""), v5, v6, v1, 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg16), arg14, arg13, false, arg15, arg16);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_simple_info(arg12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::new_pool_key<T0, 0x2::sui::SUI>(200)));
        let v14 = 0x2::object::id_to_address(&v13);
        let v15 = calculate_actual_amm_price(v0, v2, 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::get_token_decimals(arg0));
        let v16 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v12);
        let v17 = CetusPoolCreatedEvent{
            pool_id             : v14,
            position_id         : 0x2::object::id_to_address(&v16),
            token_a_type        : arg6,
            token_b_type        : 0x1::string::utf8(b"SUI"),
            initial_liquidity_a : v2,
            initial_liquidity_b : v0,
            tick_spacing        : 200,
            sqrt_price          : v3,
        };
        0x2::event::emit<CetusPoolCreatedEvent>(v17);
        let v18 = @0x0;
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v12, v18);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v4, v18);
        let v19 = 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::get_admin(arg0);
        if (0x2::coin::value<T0>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v19);
        } else {
            0x2::coin::destroy_zero<T0>(v11);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v19);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
        };
        let v20 = TokenGraduatedEvent{
            coin_address                : arg5,
            graduation_time             : 0x2::clock::timestamp_ms(arg15),
            target_price                : arg7,
            actual_initial_price        : v15,
            price_difference_bps        : calculate_price_difference_bps(arg7, v15),
            token_utilization_bps       : 10000,
            cetus_pool_sui_liquidity    : v0,
            cetus_pool_token_liquidity  : v2,
            total_supply_in_circulation : arg8,
            amm_pool_id                 : v14,
            market_cap                  : 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg7), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg8 / 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::pow(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(10), (0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::get_token_decimals(arg0) as u64)))))),
        };
        0x2::event::emit<TokenGraduatedEvent>(v20);
        (v0, v2, v14)
    }

    public fun get_estimated_amm_liquidity(arg0: u64, arg1: u64) : (u64, u64) {
        (arg0, arg1)
    }

    public fun get_graduation_progress(arg0: &0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::Launchpad, arg1: u64) : (u64, u64, u64) {
        let v0 = 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::get_graduation_threshold(arg0);
        let v1 = if (v0 > 0) {
            0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::as_u64(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::div(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::mul(0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(arg1), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(10000)), 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils::from_u64(v0)))
        } else {
            0
        };
        (arg1, v0, v1)
    }

    public fun validate_graduation_economics(arg0: &0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::Launchpad, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : (bool, u64, u64) {
        if (arg1 < 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::token_launcher::get_min_graduation_sui_liquidity(arg0)) {
            return (false, 0, 0)
        };
        (true, calculate_price_difference_bps(arg2, calculate_actual_amm_price(arg1, arg3, arg4)), 10000)
    }

    // decompiled from Move bytecode v6
}

