module 0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::alphafi_bluefin_type_2_investor {
    struct Investor<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        lower_tick: u32,
        upper_tick: u32,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        emergency_balance_a: 0x2::balance::Balance<T0>,
        emergency_balance_b: 0x2::balance::Balance<T1>,
        free_rewards: 0x2::bag::Bag,
        minimum_swap_amount: u64,
        performance_fee: u64,
        performance_fee_max_cap: u64,
        is_emergency: bool,
    }

    struct RebalancePoolEvent has copy, drop {
        investor_id: 0x2::object::ID,
        amount_a_before: u64,
        amount_b_before: u64,
        amount_a_after: u64,
        amount_b_after: u64,
        liquidity_before: u128,
        liquidity_after: u128,
        lower_tick_before: u32,
        upper_tick_before: u32,
        lower_tick_after: u32,
        upper_tick_after: u32,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        free_balance_a: u64,
        free_balance_b: u64,
        location: u64,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount_a: u64,
        compound_amount_b: u64,
        total_amount_a: u64,
        total_amount_b: u64,
        current_liquidity: u128,
        fee_collected_a: u64,
        fee_collected_b: u64,
        free_balance_a: u64,
        free_balance_b: u64,
    }

    public(friend) fun autocompound<T0, T1, T2, T3>(arg0: &mut Investor<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = autocompound_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v1;
        let v4 = v0;
        if (0x2::balance::value<T0>(&v4) > 100 || 0x2::balance::value<T1>(&v3) > 100) {
            deposit<T0, T1>(arg0, arg2, arg4, v4, v3, v2, arg9);
        } else {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, v4);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, v3);
        };
    }

    fun autocompound_internal<T0, T1, T2, T3>(arg0: &mut Investor<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, bool) {
        let v0 = 0x2::coin::zero<T3>(arg10);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T3>(arg4)) {
            0x2::coin::join<T3>(&mut v0, 0x2::coin::from_balance<T3>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg9, arg2, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position")), arg10));
        };
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, 0xdd5c4badc89f08fb2ff3c1827411c9bafbed54c64c17d8ab969f637364ca8b4f::blue::BLUE>(arg4)) {
            let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, 0xdd5c4badc89f08fb2ff3c1827411c9bafbed54c64c17d8ab969f637364ca8b4f::blue::BLUE>(arg9, arg2, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"));
            update_free_rewards<T0, T1, 0xdd5c4badc89f08fb2ff3c1827411c9bafbed54c64c17d8ab969f637364ca8b4f::blue::BLUE>(arg0, v1);
        };
        let v2 = 0x2::balance::zero<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>()) == true) {
            0x2::balance::join<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>(&mut v2, 0x2::balance::withdraw_all<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>>(&mut arg0.free_rewards, 0x1::type_name::get<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>())));
        };
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, 0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>(arg4)) {
            0x2::balance::join<0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>(&mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, 0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>(arg9, arg2, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position")));
        };
        update_free_rewards<T0, T1, 0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT>(arg0, v2);
        let v3 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(&mut v3, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())));
        };
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T2>(arg4)) {
            0x2::balance::join<T2>(&mut v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg9, arg2, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position")));
        };
        let v4 = 0x2::balance::value<T2>(&v3);
        if (v4 >= arg0.minimum_swap_amount) {
            let (v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg9, arg2, arg5, v3, 0x2::balance::zero<T3>(), true, true, v4, v4, 4295048016);
            0x2::balance::destroy_zero<T2>(v5);
            0x2::coin::join<T3>(&mut v0, 0x2::coin::from_balance<T3>(v6, arg10));
        } else {
            update_free_rewards<T0, T1, T2>(arg0, v3);
        };
        update_free_rewards<T0, T1, T3>(arg0, 0x2::coin::into_balance<T3>(v0));
        let v7 = 0;
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            let v8 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>());
            let v9 = 0x2::balance::value<0x2::sui::SUI>(v8);
            if (v9 >= arg0.minimum_swap_amount) {
                let (v10, v11) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T1, 0x2::sui::SUI>(arg3, arg7, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(v8), arg10), true, v9, arg9, arg10);
                let v12 = v10;
                0x2::coin::destroy_zero<0x2::sui::SUI>(v11);
                v7 = (0x2::coin::value<T1>(&v12) as u128) * (arg0.performance_fee as u128) / 10000;
                0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::coin::into_balance<T1>(v12));
            };
        };
        let (_, _, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg9, arg2, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"));
        let v17 = v16;
        let v18 = v15;
        let v19 = (0x2::balance::value<T0>(&v18) as u128) * (arg0.performance_fee as u128) / 10000;
        let v20 = v7 + (0x2::balance::value<T1>(&v17) as u128) * (arg0.performance_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut v18, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v17, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v18, (v19 as u64)), arg10), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v17, (v20 as u64)), arg10), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        let (v21, v22) = if (arg8 == false) {
            let v23 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg6);
            let v24 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
            let v25 = if (v23 == 100) {
                v24 * 999749968 / 1000000000
            } else if (v23 == 10000) {
                v24 * 992471662 / 1000000000
            } else {
                v24 * 994987437 / 1000000000
            };
            let v26 = if (v23 == 100) {
                v24 * 1000249968 / 1000000000
            } else if (v23 == 10000) {
                v24 * 1007472083 / 1000000000
            } else {
                v24 * 1004987562 / 1000000000
            };
            get_total_balance_in_ratio_with_limit<T0, T1>(arg0, arg2, arg3, v18, v17, arg4, arg6, v25, v26, arg8, arg9, arg10)
        } else {
            let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4);
            let v28 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4);
            let v29 = if (v27 >= 100 && v27 <= 500) {
                v28 * 999499874 / 1000000000
            } else if (v27 >= 1000 && v27 <= 2500) {
                v28 * 997496867 / 1000000000
            } else {
                v28 * 992471662 / 1000000000
            };
            let v30 = if (v27 >= 100 && v27 <= 500) {
                v28 * 1000499875 / 1000000000
            } else if (v27 >= 1000 && v27 <= 2500) {
                v28 * 1002496882 / 1000000000
            } else {
                v28 * 1007472083 / 1000000000
            };
            get_total_balance_in_ratio_with_limit<T0, T1>(arg0, arg2, arg3, v18, v17, arg4, arg6, v29, v30, arg8, arg9, arg10)
        };
        let (_, v32, v33, v34) = get_balances_in_ratio<T0, T1>(arg0, v21, v22, arg4, true, arg10);
        let v35 = v33;
        let v36 = v32;
        if (0x2::balance::value<T0>(&v36) <= 100 && 0x2::balance::value<T1>(&v35) <= 100) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut v36));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut v35));
        };
        let (v37, v38) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, b"Position")), false);
        let v39 = AutoCompoundingEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount_a : 0x2::balance::value<T0>(&v36),
            compound_amount_b : 0x2::balance::value<T1>(&v35),
            total_amount_a    : v37,
            total_amount_b    : v38,
            current_liquidity : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, b"Position")),
            fee_collected_a   : (v19 as u64),
            fee_collected_b   : (v20 as u64),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
        };
        0x2::event::emit<AutoCompoundingEvent>(v39);
        (v36, v35, v34)
    }

    fun close_position<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg3, arg2, arg0, arg1);
    }

    public fun create_investor<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::Version, arg2: u32, arg3: u32, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::assert_current_version(arg1);
        let v0 = 0x2::object::new(arg6);
        0x2::dynamic_field::add<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v0, b"Position", 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg5, arg4, arg2, arg3, arg6));
        let v1 = Investor<T0, T1>{
            id                      : v0,
            lower_tick              : arg2,
            upper_tick              : arg3,
            free_balance_a          : 0x2::balance::zero<T0>(),
            free_balance_b          : 0x2::balance::zero<T1>(),
            emergency_balance_a     : 0x2::balance::zero<T0>(),
            emergency_balance_b     : 0x2::balance::zero<T1>(),
            free_rewards            : 0x2::bag::new(arg6),
            minimum_swap_amount     : 100000,
            performance_fee         : 2000,
            performance_fee_max_cap : 5000,
            is_emergency            : false,
        };
        0x2::transfer::public_share_object<Investor<T0, T1>>(v1);
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: &0x2::clock::Clock) {
        let (v0, v1) = if (0x2::balance::value<T0>(&arg3) == 0 || arg5 == false) {
            let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg6, arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"), arg3, arg4, 0x2::balance::value<T1>(&arg4), false);
            let _ = v3;
            let _ = v2;
            (v4, v5)
        } else {
            let (v8, v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg6, arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"), arg3, arg4, 0x2::balance::value<T0>(&arg3), true);
            let _ = v9;
            let _ = v8;
            (v10, v11)
        };
        0x2::balance::join<T0>(&mut arg0.free_balance_a, v0);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, v1);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::EmergencyCap, arg2: &0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::Version, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::assert_current_version(arg2);
        arg0.is_emergency = true;
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, b"Position")), arg5);
        0x2::balance::join<T0>(&mut arg0.emergency_balance_a, v2);
        0x2::balance::join<T1>(&mut arg0.emergency_balance_b, v3);
    }

    public(friend) fun get_amounts<T0, T1>(arg0: &Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, b"Position")), false)
    }

    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, bool) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        if (0x2::balance::value<T0>(&arg1) == 0 || 0x2::balance::value<T1>(&arg2) == 0) {
            (0, arg1, arg2, !(0x2::balance::value<T0>(&arg1) == 0))
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), v1)) {
            let (v6, _, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T0>(&arg1), true);
            let v9 = 0x2::balance::value<T1>(&arg2);
            if (v8 <= v9) {
                if (arg4 == false) {
                    let v10 = v9 - v8;
                    assert!((v10 as u128) * 1000000000 / (v9 as u128) <= 10000000, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::difference_too_high());
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v10), arg5), 0x2::tx_context::sender(arg5));
                };
                0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
                (v6, arg1, 0x2::balance::split<T1>(&mut arg2, v8), true)
            } else {
                let (v11, v12, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
                let v14 = 0x2::balance::value<T0>(&arg1);
                assert!(v12 <= v14, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::insufficient_balance_to_add_liquidity());
                if (arg4 == false) {
                    let v15 = v14 - v12;
                    assert!((v15 as u128) * 1000000000 / (v14 as u128) <= 10000000, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::difference_too_high());
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v15), arg5), 0x2::tx_context::sender(arg5));
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
                (v11, 0x2::balance::split<T0>(&mut arg1, v12), arg2, false)
            }
        } else {
            let (v16, v17, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
            let v19 = 0x2::balance::value<T0>(&arg1);
            assert!(v17 <= v19, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::insufficient_balance_to_add_liquidity());
            if (arg4 == false) {
                let v20 = v19 - v17;
                assert!((v20 as u128) * 1000000000 / (v19 as u128) <= 10000000, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::difference_too_high());
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v20), arg5), 0x2::tx_context::sender(arg5));
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
            (v16, 0x2::balance::split<T0>(&mut arg1, v17), arg2, false)
        }
    }

    fun get_total_balance_in_ratio_with_limit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u128, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x2::balance::value<T1>(&arg4) == 0) {
                return (arg3, arg4)
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)) && 0x2::balance::value<T0>(&arg3) == 0) {
                return (arg3, arg4)
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg4));
        };
        let (_, v1, v2, _) = get_balances_in_ratio<T0, T1>(arg0, arg3, arg4, arg5, true, arg11);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let (v7, v8) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), v6)) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 1000000000000, true);
            let _ = v9;
            (v10, v11)
        } else {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 1000000000000, false);
            let _ = v13;
            (v14, v15)
        };
        let v16 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v17 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v16 > 0) {
            if (arg9 == false) {
                let v18 = v16 / 2;
                let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg6, true, true, v18);
                let v20 = (v7 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v19) as u256) + (v18 as u256) * (v8 as u256);
                let v21 = if (v20 > 0) {
                    (v16 as u256) * (v8 as u256) * (v18 as u256) / v20
                } else {
                    0
                };
                if (v21 >= (arg0.minimum_swap_amount as u256)) {
                    let (v22, v23) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b_with_fixed_limit<T0, T1>(arg2, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v21 as u64)), arg11), true, (v21 as u64), arg8, arg10, arg11);
                    0x2::coin::destroy_zero<T0>(v22);
                    0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(v23));
                    0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
                };
            } else {
                let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg5, true, true, v16 / 2, arg7);
                let v25 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v24) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v24);
                let v26 = (v7 as u256) * (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v24) as u256) + (v25 as u256) * (v8 as u256);
                let v27 = if (v26 > 0) {
                    (v16 as u256) * (v8 as u256) * (v25 as u256) / v26
                } else {
                    0
                };
                if (v27 >= (arg0.minimum_swap_amount as u256)) {
                    let (v28, v29) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg10, arg1, arg5, 0x2::balance::split<T0>(&mut arg0.free_balance_a, (v27 as u64)), 0x2::balance::zero<T1>(), true, true, (v27 as u64), (v27 as u64), arg7);
                    0x2::balance::destroy_zero<T0>(v28);
                    0x2::balance::join<T1>(&mut v4, v29);
                    0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
                };
            };
        } else if (v17 > 0) {
            if (arg9 == false) {
                let v30 = v17 / 2;
                let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg6, false, true, v30);
                let v32 = (v8 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v31) as u256) + (v30 as u256) * (v7 as u256);
                let v33 = if (v32 > 0) {
                    (v17 as u256) * (v7 as u256) * (v30 as u256) / v32
                } else {
                    0
                };
                if (v33 >= (arg0.minimum_swap_amount as u256)) {
                    let (v34, v35) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a_with_fixed_limit<T0, T1>(arg2, arg6, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v33 as u64)), arg11), true, (v33 as u64), arg7, arg10, arg11);
                    0x2::coin::destroy_zero<T1>(v35);
                    0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(v34));
                    0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
                };
            } else {
                let v36 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg5, false, true, v17 / 2, arg8);
                let v37 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v36) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v36);
                let v38 = (v8 as u256) * (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v36) as u256) + (v37 as u256) * (v7 as u256);
                let v39 = if (v38 > 0) {
                    (v17 as u256) * (v7 as u256) * (v37 as u256) / v38
                } else {
                    0
                };
                if (v39 >= (arg0.minimum_swap_amount as u256)) {
                    let (v40, v41) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg10, arg1, arg5, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.free_balance_b, (v39 as u64)), false, true, (v39 as u64), (v39 as u64), arg8);
                    0x2::balance::destroy_zero<T1>(v41);
                    0x2::balance::join<T0>(&mut v5, v40);
                    0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
                };
            };
        };
        (v5, v4)
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>) : u128 {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, b"Position"))
    }

    public fun is_emergency<T0, T1>(arg0: &Investor<T0, T1>) : bool {
        arg0.is_emergency
    }

    public fun rebalance<T0, T1, T2, T3>(arg0: &mut Investor<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::RebalanceCap, arg2: &0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::Version, arg3: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: u32, arg7: u32, arg8: u32, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun rebalance_v2<T0, T1, T2, T3>(arg0: &mut Investor<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::RebalanceCap, arg2: &0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::Version, arg3: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: u32, arg7: u32, arg8: u32, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::assert_current_version(arg2);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg9, arg6, arg7, arg15);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg9), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9), v2, false);
        let v5 = arg0.lower_tick;
        let v6 = arg0.upper_tick;
        arg0.lower_tick = arg6;
        arg0.upper_tick = arg7;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg10);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg10);
        let v9 = if (v7 == 100) {
            v8 * 999749968 / 1000000000
        } else if (v7 == 10000) {
            v8 * 992471662 / 1000000000
        } else {
            v8 * 994987437 / 1000000000
        };
        let v10 = if (v7 == 100) {
            v8 * 1000249968 / 1000000000
        } else if (v7 == 10000) {
            v8 * 1007472083 / 1000000000
        } else {
            v8 * 1004987562 / 1000000000
        };
        let v11 = v2 / (arg8 as u128);
        let v12 = v2 % (arg8 as u128);
        let v13 = 0;
        while (v13 < arg8 + 1) {
            if (v13 == arg8) {
                if (v12 == 0) {
                    break
                };
                v11 = v12;
            };
            let (_, _, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg4, arg9, &mut v0, v11, arg14);
            let v18 = v17;
            let v19 = v16;
            0x2::balance::join<T0>(&mut v19, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            0x2::balance::join<T1>(&mut v18, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            let (v20, v21) = get_total_balance_in_ratio_with_limit<T0, T1>(arg0, arg4, arg5, v19, v18, arg9, arg10, v9, v10, arg13, arg14, arg15);
            let (_, v23, v24, v25) = get_balances_in_ratio<T0, T1>(arg0, v20, v21, arg9, true, arg15);
            let v26 = v24;
            let v27 = v23;
            if (0x2::balance::value<T0>(&v27) > 100 || 0x2::balance::value<T1>(&v26) > 100) {
                let (v28, v29) = if (0x2::balance::value<T0>(&v27) == 0 || v25 == false) {
                    let (v30, v31, v32, v33) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg14, arg4, arg9, &mut v1, v27, v26, 0x2::balance::value<T1>(&v26), false);
                    let _ = v31;
                    let _ = v30;
                    (v33, v32)
                } else {
                    let (v36, v37, v38, v39) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg14, arg4, arg9, &mut v1, v27, v26, 0x2::balance::value<T0>(&v27), true);
                    let _ = v37;
                    let _ = v36;
                    (v39, v38)
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, v29);
                0x2::balance::join<T1>(&mut arg0.free_balance_b, v28);
            } else {
                0x2::balance::join<T0>(&mut arg0.free_balance_a, v27);
                0x2::balance::join<T1>(&mut arg0.free_balance_b, v26);
            };
            v13 = v13 + 1;
        };
        0x2::dynamic_field::add<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position", v0);
        let (v40, v41, v42) = autocompound_internal<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg9, arg11, arg10, arg12, arg13, arg14, arg15);
        let v43 = v41;
        let v44 = v40;
        close_position<T0, T1>(arg9, 0x2::dynamic_field::remove<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"), arg4, arg14);
        0x2::dynamic_field::add<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position", v1);
        if (0x2::balance::value<T0>(&v44) > 100 || 0x2::balance::value<T1>(&v43) > 100) {
            deposit<T0, T1>(arg0, arg4, arg9, v44, v43, v42, arg14);
        } else {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, v44);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, v43);
        };
        let v45 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, b"Position"));
        let (v46, v47) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg9), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9), v45, false);
        let v48 = RebalancePoolEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_a_before   : v3,
            amount_b_before   : v4,
            amount_a_after    : v46,
            amount_b_after    : v47,
            liquidity_before  : v2,
            liquidity_after   : v45,
            lower_tick_before : v5,
            upper_tick_before : v6,
            lower_tick_after  : arg0.lower_tick,
            upper_tick_after  : arg0.upper_tick,
            sqrt_price_before : v8,
            sqrt_price_after  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
            location          : 1,
        };
        0x2::event::emit<RebalancePoolEvent>(v48);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9) >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg9) < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::out_of_range());
    }

    entry fun set_minimum_swap_amount<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0xeea4b39278f417d8320a581b34af2f312c505f89d94a9e74a16c0964cc5ba0d1::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.performance_fee_max_cap, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    fun update_free_rewards<T0, T1, T2>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>(), arg1);
        };
    }

    public(friend) fun user_emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.emergency_balance_a, (((arg1 as u256) * (0x2::balance::value<T0>(&arg0.emergency_balance_a) as u256) / (arg2 as u256)) as u64)), 0x2::balance::split<T1>(&mut arg0.emergency_balance_b, (((arg1 as u256) * (0x2::balance::value<T1>(&arg0.emergency_balance_b) as u256) / (arg2 as u256)) as u64)))
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, b"Position"), arg1, arg4);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

