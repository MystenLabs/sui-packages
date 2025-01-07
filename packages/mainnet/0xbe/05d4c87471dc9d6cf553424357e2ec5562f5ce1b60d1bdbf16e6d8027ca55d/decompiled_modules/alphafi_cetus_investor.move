module 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::alphafi_cetus_investor {
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

    struct RebalanceEvent has copy, drop {
        a: u64,
        b: u64,
    }

    struct AfterRebalanceEvent has copy, drop {
        liquidity: u128,
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
        fee_collected_a: u64,
        fee_collected_b: u64,
        free_balance_a: u64,
        free_balance_b: u64,
        location: u64,
    }

    struct AutoCompoundingNewEvent has copy, drop {
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

    struct LiquidityBeforeDepositEvent has copy, drop {
        liquidity: u128,
    }

    struct FreeBalanceEventNew has copy, drop {
        free_balance_a: u64,
        free_balance_b: u64,
        balance_a: u64,
        balance_b: u64,
        location: u64,
    }

    struct SplitAndSwapEventNew has copy, drop {
        to_split: u256,
        free_balance: u64,
        location: u64,
    }

    fun close_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg0, arg1);
    }

    public(friend) fun autocompound<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg2: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::Distributor, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::assert_current_version(arg1);
        let (v0, v1, v2) = autocompound_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v1;
        let v4 = v0;
        if (0x2::balance::value<T0>(&v4) > 100 || 0x2::balance::value<T1>(&v3) > 100) {
            deposit<T0, T1>(arg0, arg3, arg7, v4, v3, v2, arg8);
        } else {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, v4);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, v3);
        };
    }

    fun autocompound_internal<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, bool) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg8);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<0x2::sui::SUI>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg6));
        if (0x1::option::is_some<u64>(&v1) == true) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x2::sui::SUI>(arg2, arg6, 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"), arg3, true, arg7), arg8));
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>())), arg8));
        };
        let v2 = 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()) == true) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v2, 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())));
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg6));
        if (0x1::option::is_some<u64>(&v3) == true) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg6, 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"), arg3, true, arg7));
        };
        if (0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v2) >= arg0.minimum_swap_amount) {
            let (v4, v5) = 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::converter::swap_a2b<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg2, arg5, 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v2, arg8), true, 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v2), arg7, arg8);
            0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v4);
            0x2::coin::join<0x2::sui::SUI>(&mut v0, v5);
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()) == true) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()), v2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(), v2);
        };
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v7 = 0;
        if (v6 >= arg0.minimum_swap_amount) {
            let (v8, v9) = 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::converter::swap_b2a<T1, 0x2::sui::SUI>(arg2, arg4, v0, true, v6, arg7, arg8);
            let v10 = v8;
            0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
            let v11 = (0x2::coin::value<T1>(&v10) as u128) * (arg0.performance_fee as u128) / 10000;
            v7 = v11;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v10, (v11 as u64), arg8), 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::get_fee_wallet_address(arg1));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::coin::into_balance<T1>(v10));
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            0x2::balance::join<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()), 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>(), 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        };
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg6, 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"), true);
        let v14 = v13;
        let v15 = v12;
        let v16 = (0x2::balance::value<T0>(&v15) as u128) * (arg0.performance_fee as u128) / 10000;
        let v17 = (0x2::balance::value<T1>(&v14) as u128) * (arg0.performance_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v15, (v16 as u64)), arg8), 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v14, (v17 as u64)), arg8), 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T0>(&mut v15, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v14, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg6);
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
        let v20 = if (v18 == 100) {
            v19 * 999749968 / 1000000000
        } else if (v18 == 10000) {
            v19 * 992471662 / 1000000000
        } else {
            v19 * 994987437 / 1000000000
        };
        let v21 = if (v18 == 100) {
            v19 * 1000249968 / 1000000000
        } else if (v18 == 10000) {
            v19 * 1007472083 / 1000000000
        } else {
            v19 * 1004987562 / 1000000000
        };
        let (v22, v23) = get_total_balance_in_ratio_with_limit<T0, T1>(arg0, arg1, arg2, v15, v14, arg6, v20, v21, arg7, arg8);
        let (_, v25, v26, v27) = get_balances_in_ratio<T0, T1>(arg0, v22, v23, arg6, true);
        let v28 = v26;
        let v29 = v25;
        if (0x2::balance::value<T0>(&v29) <= 100 && 0x2::balance::value<T1>(&v28) <= 100) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut v29));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut v28));
        };
        let (v30, v31) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position")), false);
        let v32 = AutoCompoundingNewEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount_a : 0x2::balance::value<T0>(&v29),
            compound_amount_b : 0x2::balance::value<T1>(&v28),
            total_amount_a    : v30,
            total_amount_b    : v31,
            current_liquidity : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position")),
            fee_collected_a   : (v16 as u64),
            fee_collected_b   : ((v7 + v17) as u64),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
        };
        0x2::event::emit<AutoCompoundingNewEvent>(v32);
        (v29, v28, v27)
    }

    public fun collect_and_convert_reward_to_sui<T0, T1, T2>(arg0: &mut Investor<T0, T2>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
    }

    public fun create_investor<T0, T1>(arg0: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::DevCap, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg2: u32, arg3: u32, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::assert_current_version(arg1);
        let v0 = 0x2::object::new(arg6);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v0, b"Position", 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg4, arg2, arg3, arg6));
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

    public(friend) fun deposit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: &0x2::clock::Clock) {
        let v0 = if (0x2::balance::value<T0>(&arg3) == 0 || arg5 == false) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x2::balance::value<T1>(&arg4), false, arg6)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x2::balance::value<T0>(&arg3), true, arg6)
        };
        let v1 = v0;
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::split<T1>(&mut arg4, v3), v1);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::EmergencyCap, arg2: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::assert_current_version(arg2);
        arg0.is_emergency = true;
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position")), arg5);
        0x2::balance::join<T0>(&mut arg0.emergency_balance_a, v0);
        0x2::balance::join<T1>(&mut arg0.emergency_balance_b, v1);
    }

    public(friend) fun get_amounts<T0, T1>(arg0: &Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position")), false)
    }

    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, bool) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        if (0x2::balance::value<T0>(&arg1) == 0 || 0x2::balance::value<T1>(&arg2) == 0) {
            (0, arg1, arg2, !(0x2::balance::value<T0>(&arg1) == 0))
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), v1)) {
            let (v6, _, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T0>(&arg1), true);
            let v9 = 0x2::balance::value<T1>(&arg2);
            if (v8 <= v9) {
                if (arg4 == false) {
                    assert!(((v9 - v8) as u128) * 1000000000 / (v9 as u128) <= 10000000, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::difference_too_high());
                };
                0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
                (v6, arg1, 0x2::balance::split<T1>(&mut arg2, v8), true)
            } else {
                let (v10, v11, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
                let v13 = 0x2::balance::value<T0>(&arg1);
                assert!(v11 <= v13, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::insufficient_balance_to_add_liquidity());
                if (arg4 == false) {
                    assert!(((v13 - v11) as u128) * 1000000000 / (v13 as u128) <= 10000000, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::difference_too_high());
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
                (v10, 0x2::balance::split<T0>(&mut arg1, v11), arg2, false)
            }
        } else {
            let (v14, v15, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
            let v17 = 0x2::balance::value<T0>(&arg1);
            assert!(v15 <= v17, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::insufficient_balance_to_add_liquidity());
            if (arg4 == false) {
                assert!(((v17 - v15) as u128) * 1000000000 / (v17 as u128) <= 10000000, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::difference_too_high());
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
            (v14, 0x2::balance::split<T0>(&mut arg1, v15), arg2, false)
        }
    }

    fun get_total_balance_in_ratio_with_limit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x2::balance::value<T1>(&arg4) == 0) {
                return (arg3, arg4)
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)) && 0x2::balance::value<T0>(&arg3) == 0) {
                return (arg3, arg4)
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg4));
        };
        let (_, v1, v2, _) = get_balances_in_ratio<T0, T1>(arg0, arg3, arg4, arg5, true);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let (v7, v8) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), v6)) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 1000000000000, true);
            let _ = v9;
            (v10, v11)
        } else {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 1000000000000, false);
            let _ = v13;
            (v14, v15)
        };
        let v16 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v17 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v16 > 0) {
            let v18 = v16 / 2;
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, true, true, v18);
            let v20 = (v7 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v19) as u256) + (v18 as u256) * (v8 as u256);
            let v21 = if (v20 > 0) {
                (v16 as u256) * (v8 as u256) * (v18 as u256) / v20
            } else {
                0
            };
            if (v21 >= (arg0.minimum_swap_amount as u256)) {
                let (v22, v23) = 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::converter::swap_a2b_with_fixed_limit<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v21 as u64)), arg9), true, (v21 as u64), arg6, arg8, arg9);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v22, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(v23));
                0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v17 > 0) {
            let v24 = v17 / 2;
            let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, false, true, v24);
            let v26 = (v8 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v25) as u256) + (v24 as u256) * (v7 as u256);
            let v27 = if (v26 > 0) {
                (v17 as u256) * (v7 as u256) * (v24 as u256) / v26
            } else {
                0
            };
            if (v27 >= (arg0.minimum_swap_amount as u256)) {
                let (v28, v29) = 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::converter::swap_b2a_with_fixed_limit<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v27 as u64)), arg9), true, (v27 as u64), arg7, arg8, arg9);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v29, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(v28));
                0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v5, v4)
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"))
    }

    public fun is_emergency<T0, T1>(arg0: &Investor<T0, T1>) : bool {
        arg0.is_emergency
    }

    public fun rebalance<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::RebalanceCap, arg2: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg3: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg8: u32, arg9: u32, arg10: u32, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::assert_current_version(arg2);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg4, arg11, arg8, arg9, arg13);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v2, false);
        let v5 = arg0.lower_tick;
        let v6 = arg0.upper_tick;
        arg0.lower_tick = arg8;
        arg0.upper_tick = arg9;
        let v7 = v2 / (arg10 as u128);
        let v8 = v2 % (arg10 as u128);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg11);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11);
        let v11 = if (v9 == 100) {
            v10 * 999749968 / 1000000000
        } else if (v9 == 10000) {
            v10 * 992471662 / 1000000000
        } else {
            v10 * 994987437 / 1000000000
        };
        let v12 = if (v9 == 100) {
            v10 * 1000249968 / 1000000000
        } else if (v9 == 10000) {
            v10 * 1007472083 / 1000000000
        } else {
            v10 * 1004987562 / 1000000000
        };
        let v13 = 0;
        while (v13 < arg10 + 1) {
            if (v13 == arg10) {
                if (v8 == 0) {
                    break
                };
                v7 = v8;
            };
            let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg4, arg11, &mut v0, v7, arg12);
            let v16 = v15;
            let v17 = v14;
            0x2::balance::join<T0>(&mut v17, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            0x2::balance::join<T1>(&mut v16, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            let (v18, v19) = get_total_balance_in_ratio_with_limit<T0, T1>(arg0, arg3, arg4, v17, v16, arg11, v11, v12, arg12, arg13);
            let (_, v21, v22, v23) = get_balances_in_ratio<T0, T1>(arg0, v18, v19, arg11, true);
            let v24 = v22;
            let v25 = v21;
            if (0x2::balance::value<T0>(&v25) > 100 || 0x2::balance::value<T1>(&v24) > 100) {
                let v26 = if (0x2::balance::value<T0>(&v25) == 0 || v23 == false) {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg11, &mut v1, 0x2::balance::value<T1>(&v24), false, arg12)
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg11, &mut v1, 0x2::balance::value<T0>(&v25), true, arg12)
                };
                let v27 = v26;
                let (v28, v29) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v27);
                0x2::balance::join<T0>(&mut arg0.free_balance_a, v25);
                0x2::balance::join<T1>(&mut arg0.free_balance_b, v24);
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg4, arg11, 0x2::balance::split<T0>(&mut v25, v28), 0x2::balance::split<T1>(&mut v24, v29), v27);
            } else {
                0x2::balance::join<T0>(&mut arg0.free_balance_a, v25);
                0x2::balance::join<T1>(&mut arg0.free_balance_b, v24);
            };
            v13 = v13 + 1;
        };
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v0);
        let (v30, v31, v32) = autocompound_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg11, arg12, arg13);
        let v33 = v31;
        let v34 = v30;
        close_position<T0, T1>(arg11, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), arg4);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v1);
        if (0x2::balance::value<T0>(&v34) > 100 || 0x2::balance::value<T1>(&v33) > 100) {
            deposit<T0, T1>(arg0, arg4, arg11, v34, v33, v32, arg12);
        } else {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, v34);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, v33);
        };
        let v35 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"));
        let (v36, v37) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v35, false);
        let v38 = RebalancePoolEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_a_before   : v3,
            amount_b_before   : v4,
            amount_a_after    : v36,
            amount_b_after    : v37,
            liquidity_before  : v2,
            liquidity_after   : v35,
            lower_tick_before : v5,
            upper_tick_before : v6,
            lower_tick_after  : arg0.lower_tick,
            upper_tick_after  : arg0.upper_tick,
            sqrt_price_before : v10,
            sqrt_price_after  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
            location          : 1,
        };
        0x2::event::emit<RebalancePoolEvent>(v38);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11) >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11) < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)), 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::out_of_range());
    }

    public fun reposition<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::AdminCap, arg2: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg3: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg8: u32, arg9: u32, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
    }

    entry fun set_minimum_swap_amount<T0, T1>(arg0: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::DevCap, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::distributor::AdminCap, arg1: &0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.performance_fee_max_cap, 0xbe05d4c87471dc9d6cf553424357e2ec5562f5ce1b60d1bdbf16e6d8027ca55d::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun user_emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.emergency_balance_a, (((arg1 as u256) * (0x2::balance::value<T0>(&arg0.emergency_balance_a) as u256) / (arg2 as u256)) as u64)), 0x2::balance::split<T1>(&mut arg0.emergency_balance_b, (((arg1 as u256) * (0x2::balance::value<T1>(&arg0.emergency_balance_b) as u256) / (arg2 as u256)) as u64)))
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

