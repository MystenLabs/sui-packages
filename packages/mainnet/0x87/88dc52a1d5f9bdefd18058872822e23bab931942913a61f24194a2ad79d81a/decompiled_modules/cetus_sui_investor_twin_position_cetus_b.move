module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b {
    struct TickRange has copy, store {
        lower: u32,
        upper: u32,
    }

    struct LiquidityBalances<phantom T0, phantom T1> {
        liquidity: u128,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    struct LiquidityAmounts has copy, drop {
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct Investor<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        major: TickRange,
        minor: TickRange,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        emergency_balance_a_major: 0x2::balance::Balance<T0>,
        emergency_balance_b_major: 0x2::balance::Balance<T1>,
        emergency_balance_a_minor: 0x2::balance::Balance<T0>,
        emergency_balance_b_minor: 0x2::balance::Balance<T1>,
        free_rewards: 0x2::bag::Bag,
        minimum_swap_amount: u64,
        performance_fee: u64,
        performance_fee_max_cap: u64,
        is_emergency: bool,
    }

    struct RebalanceEvent has copy, drop {
        cetus_pool_id: 0x2::object::ID,
        new_major_lower: u32,
        new_major_upper: u32,
        new_minor_lower: u32,
        new_minor_upper: u32,
        old_major_lower: u32,
        old_major_upper: u32,
        old_minor_lower: u32,
        old_minor_upper: u32,
        old_major_position: 0x2::object::ID,
        old_minor_position: 0x2::object::ID,
        new_major_position: 0x2::object::ID,
        new_minor_position: 0x2::object::ID,
        major_liquidity_before: u128,
        minor_liquidity_before: u128,
        major_liquidity_after: u128,
        minor_liquidity_after: u128,
        major_amount_a_before: u64,
        major_amount_b_before: u64,
        minor_amount_a_before: u64,
        minor_amount_b_before: u64,
        major_amount_a_after: u64,
        major_amount_b_after: u64,
        minor_amount_a_after: u64,
        minor_amount_b_after: u64,
        current_tick: u32,
        current_sqrt_price: u128,
    }

    struct RepositionEvent has copy, drop {
        cetus_pool_id: 0x2::object::ID,
        new_major_lower: u32,
        new_major_upper: u32,
        new_minor_lower: u32,
        new_minor_upper: u32,
        old_major_lower: u32,
        old_major_upper: u32,
        old_minor_lower: u32,
        old_minor_upper: u32,
        old_major_position: 0x2::object::ID,
        old_minor_position: 0x2::object::ID,
        new_major_position: 0x2::object::ID,
        new_minor_position: 0x2::object::ID,
        major_liquidity_before: u128,
        minor_liquidity_before: u128,
        major_liquidity_after: u128,
        minor_liquidity_after: u128,
        major_amount_a_before: u64,
        major_amount_b_before: u64,
        minor_amount_a_before: u64,
        minor_amount_b_before: u64,
        major_amount_a_after: u64,
        major_amount_b_after: u64,
        minor_amount_a_after: u64,
        minor_amount_b_after: u64,
        current_tick: u32,
        current_sqrt_price: u128,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        major_liquidity: u128,
        minor_liquidity: u128,
        emergency_amount_a_from_major: u64,
        emergnecy_amount_b_from_major: u64,
        emergency_amount_a_from_minor: u64,
        emergnecy_amount_b_from_minor: u64,
        current_tick: u32,
        current_sqrt_price: u128,
    }

    struct DepositEvent has copy, drop {
        pay_amount_a: u64,
        pay_amount_b: u64,
        free_balance_a: u64,
        free_balance_b: u64,
        major_minor: u8,
    }

    struct SplitAndSwapEventNew has copy, drop {
        to_split: u256,
        free_balance: u64,
        location: u64,
    }

    struct InvestorCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        major_position_id: 0x2::object::ID,
        minor_position_id: 0x2::object::ID,
        major_tick_lower: u32,
        major_tick_upper: u32,
        minor_tick_lower: u32,
        minor_tick_upper: u32,
    }

    fun close_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg0, arg1);
    }

    public(friend) fun autocompound<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = autocompound_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        let v5 = 0;
        if (0x2::balance::value<T0>(&v3) > 0 || 0x2::balance::value<T1>(&v2) > 0) {
            let v6 = 0x2::balance::value<T0>(&v3);
            v4 = v6;
            let v7 = 0x2::balance::value<T1>(&v2);
            v5 = v7;
            let (v8, v9) = split_major_minor_by_amount<T0, T1>(arg0, arg5, v6, v7, true);
            let v10 = v9;
            let v11 = v8;
            let (v12, v13) = split_major_minor_by_amount<T0, T1>(arg0, arg5, v6, v7, false);
            let v14 = v13;
            let v15 = v12;
            if ((v6 - v11.amount_a - v10.amount_a) * (v7 - v11.amount_b - v10.amount_b) < (v6 - v15.amount_a - v14.amount_a) * (v7 - v15.amount_b - v14.amount_b)) {
                let v16 = &mut v3;
                let v17 = &mut v2;
                deposit_internal<T0, T1>(arg0, arg2, arg5, v16, v17, v11.amount_a, v11.amount_b, v10.amount_a, v10.amount_b, arg6);
            } else {
                let v18 = &mut v3;
                let v19 = &mut v2;
                deposit_internal<T0, T1>(arg0, arg2, arg5, v18, v19, v15.amount_a, v15.amount_b, v14.amount_a, v14.amount_b, arg6);
            };
        };
        receive_free_balances<T0, T1>(arg0, v3, v2);
        (v4, v5)
    }

    fun autocompound_internal<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition");
        let v1 = 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition");
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg5));
        if (0x1::option::is_some<u64>(&v3)) {
            0x2::balance::join<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg5, v0, arg3, true, arg8));
            0x2::balance::join<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg5, v1, arg3, true, arg8));
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>())) {
            0x2::balance::join<T1>(&mut v2, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())));
        };
        let v4 = 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v4, 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())));
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg5));
        if (0x1::option::is_some<u64>(&v5)) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg5, v0, arg3, true, arg8));
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg5, v1, arg3, true, arg8));
        };
        let v6 = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v4);
        if (v6 >= arg0.minimum_swap_amount) {
            let (v7, v8) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::converter::swap_a2b<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>(arg2, arg4, 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v4, arg9), true, v6, arg8, arg9);
            0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v7);
            0x2::balance::join<T1>(&mut v2, 0x2::coin::into_balance<T1>(v8));
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()), v4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(), v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, (((0x2::balance::value<T1>(&v2) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T1>(&mut arg0.free_balance_b, v2);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg5, v0, true);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg5, v1, true);
        0x2::balance::join<T0>(&mut v12, v13);
        0x2::balance::join<T1>(&mut v11, v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, (((0x2::balance::value<T0>(&v12) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, (((0x2::balance::value<T1>(&v11) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T0>(&mut v12, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v11, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        let (v15, v16) = get_total_balance_in_ratio<T0, T1>(arg0, arg1, arg2, v12, v11, arg5, arg8, arg9);
        let v17 = v16;
        let v18 = v15;
        0x2::balance::join<T0>(&mut v18, arg6);
        0x2::balance::join<T1>(&mut v17, arg7);
        let TickRange {
            lower : v19,
            upper : v20,
        } = arg0.major;
        let (_, v22, v23, v24, v25) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_tools::get_balances_in_ratio<T0, T1>(arg5, v19, v20, v18, v17, true);
        receive_free_balances<T0, T1>(arg0, v24, v25);
        (v22, v23)
    }

    public fun calc_major_minor<T0, T1>(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: u64, arg7: bool) : (u64, u64, u64, u64, u32, u32) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg4);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4);
        if (arg7) {
            let v8 = arg5 * 9000 / 10000;
            let v9 = arg5 - v8;
            let (_, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), v0, v1, v8, true);
            let v13 = arg6 - v12;
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), v0, v1, v9, true);
            let (v17, v18, v19, v20) = if (v16 == v13) {
                (v8, v15, v16, arg2)
            } else {
                let v21 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
                let v22 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_tools::get_price_lower_end_by_amount_b(v1, v13, v14)), v21), v21);
                let (_, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v22, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), v0, v1, v9, true);
                (v11, v24, v25, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v22))
            };
            (v17, v12, v18, v19, v20, arg3)
        } else {
            let v26 = arg6 * 9000 / 10000;
            let v27 = arg6 - v26;
            let (_, v29, v30) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), v0, v1, v26, false);
            let v31 = arg5 - v29;
            let (v32, v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), v0, v1, v27, false);
            let (v35, v36, v37) = if (v33 == v31) {
                (v34, arg3, v33)
            } else {
                let v38 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
                let v39 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_tools::get_price_upper_end_by_amount_a(v1, v31, v32)), v38), v38);
                let (_, v41, v42) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), v39, v0, v1, v27, false);
                (v42, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v39), v41)
            };
            (v29, v30, v37, v35, arg2, v36)
        }
    }

    public fun collect_and_convert_reward_to_sui<T0, T1, T2>(arg0: &mut Investor<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg1));
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg1, 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition"), arg4, true, arg5);
            0x2::balance::join<T2>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg1, 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition"), arg4, true, arg5));
            let v2 = 0x1::type_name::get<T2>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, v2)) {
                0x2::balance::join<T2>(&mut v1, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, v2)));
            };
            let v3 = 0x2::balance::value<T2>(&v1);
            if (v3 >= arg0.minimum_swap_amount) {
                let (v4, v5) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::converter::swap_a2b<T2, 0x2::sui::SUI>(arg3, arg2, 0x2::coin::from_balance<T2>(v1, arg6), true, v3, arg5, arg6);
                0x2::coin::destroy_zero<T2>(v4);
                let v6 = 0x1::type_name::get<0x2::sui::SUI>();
                if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, v6)) {
                    0x2::balance::join<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, v6), 0x2::coin::into_balance<0x2::sui::SUI>(v5));
                } else {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, v6, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
                };
            } else {
                let v7 = 0x1::type_name::get<T2>();
                if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, v7)) {
                    0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, v7), v1);
                } else {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, v7, v1);
                };
            };
        };
    }

    public fun consume<T0, T1>(arg0: LiquidityBalances<T0, T1>) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let LiquidityBalances {
            liquidity : v0,
            balance_a : v1,
            balance_b : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun create_investor<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::DevCap, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = TickRange{
            lower : arg1,
            upper : arg2,
        };
        let v2 = TickRange{
            lower : arg3,
            upper : arg4,
        };
        let v3 = Investor<T0, T1>{
            id                        : v0,
            major                     : v1,
            minor                     : v2,
            free_balance_a            : 0x2::balance::zero<T0>(),
            free_balance_b            : 0x2::balance::zero<T1>(),
            emergency_balance_a_major : 0x2::balance::zero<T0>(),
            emergency_balance_b_major : 0x2::balance::zero<T1>(),
            emergency_balance_a_minor : 0x2::balance::zero<T0>(),
            emergency_balance_b_minor : 0x2::balance::zero<T1>(),
            free_rewards              : 0x2::bag::new(arg7),
            minimum_swap_amount       : 100000,
            performance_fee           : 2000,
            performance_fee_max_cap   : 5000,
            is_emergency              : false,
        };
        let v4 = &mut v3;
        let (v5, v6) = create_positions<T0, T1>(v4, arg5, arg6, arg7);
        0x2::transfer::public_share_object<Investor<T0, T1>>(v3);
        let v7 = InvestorCreatedEvent{
            id                : 0x2::object::uid_to_inner(&v0),
            major_position_id : v5,
            minor_position_id : v6,
            major_tick_lower  : arg1,
            major_tick_upper  : arg2,
            minor_tick_lower  : arg3,
            minor_tick_upper  : arg4,
        };
        0x2::event::emit<InvestorCreatedEvent>(v7);
    }

    fun create_positions<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"MajorPosition") && !0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"MinorPosition"), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::position_existed());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg1, arg0.major.lower, arg0.major.upper, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg1, arg0.minor.lower, arg0.minor.upper, arg3);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition", v0);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition", v1);
        (0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1))
    }

    fun deposit_add_position_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (0x2::balance::value<T0>(&arg3) == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, 0x2::balance::value<T1>(&arg4), false, arg5)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, 0x2::balance::value<T0>(&arg3), true, arg5)
        };
        let v1 = v0;
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::split<T1>(&mut arg4, v3), v1);
        (v2, v3, arg3, arg4)
    }

    fun deposit_internal<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        deposit_major<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(arg3, arg5), 0x2::balance::split<T1>(arg4, arg6), arg9);
        deposit_minor<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(arg3, arg7), 0x2::balance::split<T1>(arg4, arg8), arg9);
    }

    public(friend) fun deposit_major<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition");
        let (v1, v2, v3, v4) = deposit_add_position_liquidity<T0, T1>(arg1, arg2, v0, arg3, arg4, arg5);
        0x2::balance::join<T0>(&mut arg0.free_balance_a, v3);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, v4);
        let v5 = DepositEvent{
            pay_amount_a   : v1,
            pay_amount_b   : v2,
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            major_minor    : 1,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public(friend) fun deposit_minor<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition");
        let (v1, v2, v3, v4) = deposit_add_position_liquidity<T0, T1>(arg1, arg2, v0, arg3, arg4, arg5);
        0x2::balance::join<T0>(&mut arg0.free_balance_a, v3);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, v4);
        let v5 = DepositEvent{
            pay_amount_a   : v1,
            pay_amount_b   : v2,
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            major_minor    : 2,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::EmergencyCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        assert!(!arg0.is_emergency, 9223377590247489535);
        arg0.is_emergency = true;
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition"));
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition"), v0, arg4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition"));
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition"), v3, arg4);
        0x2::balance::join<T0>(&mut arg0.emergency_balance_a_major, v1);
        0x2::balance::join<T0>(&mut arg0.emergency_balance_a_minor, v4);
        0x2::balance::join<T1>(&mut arg0.emergency_balance_b_major, v2);
        0x2::balance::join<T1>(&mut arg0.emergency_balance_b_minor, v5);
        let v6 = EmergencyWithdrawEvent{
            major_liquidity               : v0,
            minor_liquidity               : v3,
            emergency_amount_a_from_major : 0x2::balance::value<T0>(&arg0.emergency_balance_a_major),
            emergnecy_amount_b_from_major : 0x2::balance::value<T1>(&arg0.emergency_balance_b_major),
            emergency_amount_a_from_minor : 0x2::balance::value<T0>(&arg0.emergency_balance_a_minor),
            emergnecy_amount_b_from_minor : 0x2::balance::value<T1>(&arg0.emergency_balance_b_minor),
            current_tick                  : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3)),
            current_sqrt_price            : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v6);
    }

    fun get_total_balance_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg4));
        };
        let TickRange {
            lower : v0,
            upper : v1,
        } = arg0.major;
        let (_, v3, v4, v5, v6) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_tools::get_balances_in_ratio<T0, T1>(arg5, v0, v1, arg3, arg4, true);
        let v7 = v4;
        let v8 = v3;
        receive_free_balances<T0, T1>(arg0, v5, v6);
        let (_, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.upper), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 1000000000000, true);
        let v12 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v13 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v12 > 0) {
            let v14 = v12 / 2;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, true, true, v14);
            let v16 = (v10 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v15) as u256) + (v14 as u256) * (v11 as u256);
            let v17 = if (v16 > 0) {
                (v12 as u256) * (v11 as u256) * (v14 as u256) / v16
            } else {
                0
            };
            let v18 = SplitAndSwapEventNew{
                to_split     : v17,
                free_balance : 0x2::balance::value<T0>(&arg0.free_balance_a),
                location     : 41,
            };
            0x2::event::emit<SplitAndSwapEventNew>(v18);
            if (v17 >= (arg0.minimum_swap_amount as u256)) {
                let (v19, v20) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::converter::swap_a2b<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v17 as u64)), arg7), true, (v17 as u64), arg6, arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T1>(&mut v7, 0x2::coin::into_balance<T1>(v20));
                0x2::balance::join<T0>(&mut v8, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v13 > 0) {
            let v21 = v13 / 2;
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, false, true, v21);
            let v23 = (v11 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v22) as u256) + (v21 as u256) * (v10 as u256);
            let v24 = if (v23 > 0) {
                (v13 as u256) * (v10 as u256) * (v21 as u256) / v23
            } else {
                0
            };
            let v25 = SplitAndSwapEventNew{
                to_split     : v24,
                free_balance : 0x2::balance::value<T1>(&arg0.free_balance_b),
                location     : 42,
            };
            0x2::event::emit<SplitAndSwapEventNew>(v25);
            if (v24 >= (arg0.minimum_swap_amount as u256)) {
                let (v26, v27) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::converter::swap_b2a<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v24 as u64)), arg7), true, (v24 as u64), arg6, arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v27, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T0>(&mut v8, 0x2::coin::into_balance<T0>(v26));
                0x2::balance::join<T1>(&mut v7, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v8, v7)
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>) : (u128, u128) {
        (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition")), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition")))
    }

    public fun is_emergency<T0, T1>(arg0: &Investor<T0, T1>) : bool {
        arg0.is_emergency
    }

    public fun liquidity_amounts_amount_a(arg0: &LiquidityAmounts) : u64 {
        arg0.amount_a
    }

    public fun liquidity_amounts_amount_b(arg0: &LiquidityAmounts) : u64 {
        arg0.amount_b
    }

    public fun liquidity_amounts_liquidity(arg0: &LiquidityAmounts) : u128 {
        arg0.liquidity
    }

    public fun major_ticks<T0, T1>(arg0: &Investor<T0, T1>) : (u32, u32) {
        (arg0.major.lower, arg0.major.upper)
    }

    public fun minor_ticks<T0, T1>(arg0: &Investor<T0, T1>) : (u32, u32) {
        (arg0.minor.lower, arg0.minor.upper)
    }

    fun prepare_autocompound_balance<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition");
        let v1 = 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition");
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg5));
        if (0x1::option::is_some<u64>(&v3)) {
            0x2::balance::join<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg5, v0, arg3, true, arg8));
            0x2::balance::join<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg5, v1, arg3, true, arg8));
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>())) {
            0x2::balance::join<T1>(&mut v2, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())));
        };
        let v4 = 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v4, 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())));
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg5));
        if (0x1::option::is_some<u64>(&v5)) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg5, v0, arg3, true, arg8));
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg5, v1, arg3, true, arg8));
        };
        let v6 = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v4);
        if (v6 >= arg0.minimum_swap_amount) {
            let (v7, v8) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::converter::swap_a2b<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>(arg2, arg4, 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v4, arg9), true, v6, arg8, arg9);
            0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v7);
            0x2::balance::join<T1>(&mut v2, 0x2::coin::into_balance<T1>(v8));
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()), v4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(), v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, (((0x2::balance::value<T1>(&v2) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T1>(&mut arg0.free_balance_b, v2);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg5, v0, true);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg5, v1, true);
        0x2::balance::join<T0>(&mut v12, v13);
        0x2::balance::join<T1>(&mut v11, v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, (((0x2::balance::value<T0>(&v12) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v11, (((0x2::balance::value<T1>(&v11) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T0>(&mut v12, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v11, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        0x2::balance::join<T0>(&mut v12, arg6);
        0x2::balance::join<T1>(&mut v11, arg7);
        (v12, v11)
    }

    public fun rebalance_no_swap<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::RebalanceCap, arg2: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: bool, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition");
        let v1 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition");
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg11, arg6, arg7, arg13);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1);
        let TickRange {
            lower : v5,
            upper : v6,
        } = arg0.major;
        let TickRange {
            lower : v7,
            upper : v8,
        } = arg0.minor;
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v3, false);
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v7), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v4, false);
        let v13 = arg0.major.lower;
        let v14 = arg0.major.upper;
        let v15 = arg0.minor.lower;
        let v16 = arg0.minor.upper;
        arg0.major.lower = arg6;
        arg0.major.upper = arg7;
        arg0.minor.lower = arg8;
        arg0.minor.upper = arg9;
        let (v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg11, &mut v0, v3, arg12);
        let v19 = v18;
        let v20 = v17;
        let (v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg11, &mut v1, v4, arg12);
        0x2::balance::join<T0>(&mut v20, v21);
        0x2::balance::join<T1>(&mut v19, v22);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition", v0);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition", v1);
        let (v23, v24) = prepare_autocompound_balance<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg11, v20, v19, arg12, arg13);
        let v25 = v24;
        let v26 = v23;
        let (v27, v28, v29, v30, v31, v32) = calc_major_minor<T0, T1>(arg0.major.lower, arg0.major.upper, arg0.minor.lower, arg0.minor.upper, arg11, 0x2::balance::value<T0>(&v26), 0x2::balance::value<T1>(&v25), arg10);
        if (arg0.minor.lower != v31 || arg0.minor.upper != v32) {
            arg0.minor.lower = v31;
            arg0.minor.upper = v32;
        };
        close_position<T0, T1>(arg11, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition"), arg3);
        close_position<T0, T1>(arg11, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition"), arg3);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition", v2);
        let v33 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg11, v31, v32, arg13);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition", v33);
        assert!(0x2::balance::value<T0>(&v26) > 0 && 0x2::balance::value<T1>(&v25) > 0, 9223380197292638207);
        deposit_major<T0, T1>(arg0, arg3, arg11, 0x2::balance::split<T0>(&mut v26, v27), 0x2::balance::split<T1>(&mut v25, v28), arg12);
        deposit_minor<T0, T1>(arg0, arg3, arg11, 0x2::balance::split<T0>(&mut v26, v29), 0x2::balance::split<T1>(&mut v25, v30), arg12);
        let v34 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition"));
        let v35 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition"));
        let (v36, v37) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.upper), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v34, false);
        let (v38, v39) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.upper), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v35, false);
        let v40 = RebalanceEvent{
            cetus_pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg11),
            new_major_lower        : arg0.major.lower,
            new_major_upper        : arg0.major.upper,
            new_minor_lower        : arg0.minor.lower,
            new_minor_upper        : arg0.minor.upper,
            old_major_lower        : v13,
            old_major_upper        : v14,
            old_minor_lower        : v15,
            old_minor_upper        : v16,
            old_major_position     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            old_minor_position     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            new_major_position     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v2),
            new_minor_position     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v33),
            major_liquidity_before : v3,
            minor_liquidity_before : v4,
            major_liquidity_after  : v34,
            minor_liquidity_after  : v35,
            major_amount_a_before  : v9,
            major_amount_b_before  : v10,
            minor_amount_a_before  : v11,
            minor_amount_b_before  : v12,
            major_amount_a_after   : v36,
            major_amount_b_after   : v37,
            minor_amount_a_after   : v38,
            minor_amount_b_after   : v39,
            current_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11)),
            current_sqrt_price     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11),
        };
        0x2::event::emit<RebalanceEvent>(v40);
        receive_free_balances<T0, T1>(arg0, v26, v25);
    }

    public fun receive_free_balances<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
    }

    public fun reposition<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::AdminCap, arg2: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: bool, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition"));
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition"));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition"));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition"));
        let (v4, v5) = withdraw_major<T0, T1>(arg0, v2, arg3, arg11, arg12);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = withdraw_minor<T0, T1>(arg0, v3, arg3, arg11, arg12);
        let v10 = v9;
        let v11 = v8;
        0x2::balance::join<T0>(&mut v7, v11);
        0x2::balance::join<T1>(&mut v6, v10);
        let (v12, v13) = autocompound_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg11, v7, v6, arg12, arg13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg11, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition"));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg11, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition"));
        let v14 = arg0.major.lower;
        let v15 = arg0.major.upper;
        let v16 = arg0.minor.lower;
        let v17 = arg0.minor.upper;
        arg0.major.lower = arg6;
        arg0.major.upper = arg7;
        arg0.minor.lower = arg8;
        arg0.minor.upper = arg9;
        let (v18, v19) = create_positions<T0, T1>(arg0, arg11, arg3, arg13);
        let (_, v21, v22, v23, v24) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_tools::get_balances_in_ratio<T0, T1>(arg11, arg0.major.lower, arg0.major.upper, v12, v13, true);
        let v25 = v22;
        let v26 = v21;
        receive_free_balances<T0, T1>(arg0, v23, v24);
        if (0x2::balance::value<T0>(&v26) > 0 || 0x2::balance::value<T1>(&v25) > 0) {
            let (v27, v28) = split_major_minor_by_amount<T0, T1>(arg0, arg11, 0x2::balance::value<T0>(&v26), 0x2::balance::value<T1>(&v25), arg10);
            let v29 = v28;
            let v30 = v27;
            deposit_major<T0, T1>(arg0, arg3, arg11, 0x2::balance::split<T0>(&mut v26, v30.amount_a), 0x2::balance::split<T1>(&mut v25, v30.amount_b), arg12);
            deposit_minor<T0, T1>(arg0, arg3, arg11, 0x2::balance::split<T0>(&mut v26, v29.amount_a), 0x2::balance::split<T1>(&mut v25, v29.amount_b), arg12);
        };
        let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MajorPosition"));
        let v32 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"MinorPosition"));
        let (v33, v34) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.upper), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v31, false);
        let (v35, v36) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.upper), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v32, false);
        let v37 = RepositionEvent{
            cetus_pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg11),
            new_major_lower        : arg0.major.lower,
            new_major_upper        : arg0.major.upper,
            new_minor_lower        : arg0.minor.lower,
            new_minor_upper        : arg0.minor.upper,
            old_major_lower        : v14,
            old_major_upper        : v15,
            old_minor_lower        : v16,
            old_minor_upper        : v17,
            old_major_position     : v0,
            old_minor_position     : v1,
            new_major_position     : v18,
            new_minor_position     : v19,
            major_liquidity_before : v2,
            minor_liquidity_before : v3,
            major_liquidity_after  : v31,
            minor_liquidity_after  : v32,
            major_amount_a_before  : 0x2::balance::value<T0>(&v7),
            major_amount_b_before  : 0x2::balance::value<T1>(&v6),
            minor_amount_a_before  : 0x2::balance::value<T0>(&v11),
            minor_amount_b_before  : 0x2::balance::value<T1>(&v10),
            major_amount_a_after   : v33,
            major_amount_b_after   : v34,
            minor_amount_a_after   : v35,
            minor_amount_b_after   : v36,
            current_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11)),
            current_sqrt_price     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11),
        };
        0x2::event::emit<RepositionEvent>(v37);
        receive_free_balances<T0, T1>(arg0, v26, v25);
    }

    entry fun set_minimum_swap_amount<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::DevCap, arg1: &mut Investor<T0, T1>, arg2: u64) {
        arg1.minimum_swap_amount = arg2;
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::AdminCap, arg1: &mut Investor<T0, T1>, arg2: u64) {
        assert!(arg2 <= arg1.performance_fee_max_cap, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::fee_too_high_error());
        arg1.performance_fee = arg2;
    }

    public(friend) fun split_major_minor_by_amount<T0, T1>(arg0: &Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool) : (LiquidityAmounts, LiquidityAmounts) {
        split_major_minor_by_amount_internal<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2, arg3, arg4)
    }

    fun split_major_minor_by_amount_internal<T0, T1>(arg0: &Investor<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : (LiquidityAmounts, LiquidityAmounts) {
        let (v0, v1) = if (arg5) {
            (arg3, arg4)
        } else {
            (arg4, arg3)
        };
        let v2 = v0 * 9000 / 10000;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.major.upper), arg1, arg2, v2, arg5);
        let v6 = if (arg5) {
            v5
        } else {
            v4
        };
        let v7 = v1 - v6;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.upper), arg1, arg2, v0 - v2, arg5);
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = if (arg5) {
            v10
        } else {
            v9
        };
        if (v7 < v14) {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.minor.upper), arg1, arg2, v7, !arg5);
            v13 = v15;
            v12 = v16;
            v11 = v17;
        };
        let v18 = LiquidityAmounts{
            liquidity : v3,
            amount_a  : v4,
            amount_b  : v5,
        };
        let v19 = LiquidityAmounts{
            liquidity : v13,
            amount_a  : v12,
            amount_b  : v11,
        };
        (v18, v19)
    }

    public(friend) fun split_major_minor_by_liquidity<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool) : (LiquidityBalances<T0, T1>, LiquidityBalances<T0, T1>) {
        let (v0, v1) = major_ticks<T0, T1>(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v0);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v6 = if (arg4) {
            0x2::balance::value<T0>(&arg2)
        } else {
            0x2::balance::value<T1>(&arg3)
        };
        let (v7, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v2, v3, v4, v5, v6, arg4);
        let v10 = v7 * 9000 / 10000;
        let v11 = v7 - v10;
        let (v12, v13) = minor_ticks<T0, T1>(arg0);
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v12), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v13), v4, v5, v11, false);
        let (v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v2, v3, v4, v5, v10, true);
        0x2::balance::join<T0>(&mut arg2, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut arg3, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        if (v14 <= 0x2::balance::value<T0>(&arg2) && v15 <= 0x2::balance::value<T1>(&arg3)) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, arg2);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, arg3);
            let v20 = LiquidityBalances<T0, T1>{
                liquidity : v10,
                balance_a : 0x2::balance::split<T0>(&mut arg2, v16),
                balance_b : 0x2::balance::split<T1>(&mut arg3, v17),
            };
            let v19 = LiquidityBalances<T0, T1>{
                liquidity : v11,
                balance_a : 0x2::balance::split<T0>(&mut arg2, v14),
                balance_b : 0x2::balance::split<T1>(&mut arg3, v15),
            };
            (v20, v19)
        } else {
            let (v21, v22) = if (v14 > 0x2::balance::value<T0>(&arg2) && v15 > 0x2::balance::value<T1>(&arg3)) {
                let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v12), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v13), v4, v5, 0x2::balance::value<T0>(&arg2), true);
                let (v26, v27, v28) = if (v25 > 0x2::balance::value<T1>(&arg3)) {
                    let (v29, v30, v31) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v12), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v13), v4, v5, 0x2::balance::value<T1>(&arg3), false);
                    (v31, v29, v30)
                } else {
                    (v25, v23, v24)
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, arg2);
                0x2::balance::join<T1>(&mut arg0.free_balance_b, arg3);
                let v32 = LiquidityBalances<T0, T1>{
                    liquidity : v10,
                    balance_a : 0x2::balance::split<T0>(&mut arg2, v16),
                    balance_b : 0x2::balance::split<T1>(&mut arg3, v17),
                };
                let v22 = LiquidityBalances<T0, T1>{
                    liquidity : v27,
                    balance_a : 0x2::balance::split<T0>(&mut arg2, v28),
                    balance_b : 0x2::balance::split<T1>(&mut arg3, v26),
                };
                (v32, v22)
            } else {
                let (v33, v34) = if (v14 > 0x2::balance::value<T0>(&arg2)) {
                    let (v35, v36, v37) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v12), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v13), v4, v5, 0x2::balance::value<T0>(&arg2), true);
                    0x2::balance::join<T0>(&mut arg0.free_balance_a, arg2);
                    0x2::balance::join<T1>(&mut arg0.free_balance_b, arg3);
                    let v38 = LiquidityBalances<T0, T1>{
                        liquidity : v10,
                        balance_a : 0x2::balance::split<T0>(&mut arg2, v16),
                        balance_b : 0x2::balance::split<T1>(&mut arg3, v17),
                    };
                    let v34 = LiquidityBalances<T0, T1>{
                        liquidity : v35,
                        balance_a : 0x2::balance::split<T0>(&mut arg2, v36),
                        balance_b : 0x2::balance::split<T1>(&mut arg3, v37),
                    };
                    (v38, v34)
                } else {
                    let (v39, v40, v41) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v12), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v13), v4, v5, 0x2::balance::value<T1>(&arg3), false);
                    0x2::balance::join<T0>(&mut arg0.free_balance_a, arg2);
                    0x2::balance::join<T1>(&mut arg0.free_balance_b, arg3);
                    let v42 = LiquidityBalances<T0, T1>{
                        liquidity : v10,
                        balance_a : 0x2::balance::split<T0>(&mut arg2, v16),
                        balance_b : 0x2::balance::split<T1>(&mut arg3, v17),
                    };
                    let v34 = LiquidityBalances<T0, T1>{
                        liquidity : v39,
                        balance_a : 0x2::balance::split<T0>(&mut arg2, v40),
                        balance_b : 0x2::balance::split<T1>(&mut arg3, v41),
                    };
                    (v42, v34)
                };
                let v22 = v34;
                (v33, v22)
            };
            let v19 = v22;
            (v21, v19)
        }
    }

    public(friend) fun user_emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::split<T0>(&mut arg0.emergency_balance_a_major, (((arg1 as u256) * (0x2::balance::value<T0>(&arg0.emergency_balance_a_major) as u256) / (arg2 as u256)) as u64));
        let v1 = 0x2::balance::split<T1>(&mut arg0.emergency_balance_b_major, (((arg1 as u256) * (0x2::balance::value<T1>(&arg0.emergency_balance_b_major) as u256) / (arg2 as u256)) as u64));
        0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg0.emergency_balance_a_minor, (((arg3 as u256) * (0x2::balance::value<T0>(&arg0.emergency_balance_a_minor) as u256) / (arg4 as u256)) as u64)));
        0x2::balance::join<T1>(&mut v1, 0x2::balance::split<T1>(&mut arg0.emergency_balance_b_minor, (((arg3 as u256) * (0x2::balance::value<T1>(&arg0.emergency_balance_b_minor) as u256) / (arg4 as u256)) as u64)));
        (v0, v1)
    }

    public(friend) fun withdraw_major<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MajorPosition");
        withdraw_position<T0, T1>(v0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun withdraw_minor<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"MinorPosition");
        withdraw_position<T0, T1>(v0, arg1, arg2, arg3, arg4)
    }

    fun withdraw_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, arg0, arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

