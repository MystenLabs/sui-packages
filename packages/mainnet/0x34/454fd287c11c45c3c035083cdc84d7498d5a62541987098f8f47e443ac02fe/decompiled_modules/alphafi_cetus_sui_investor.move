module 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphafi_cetus_sui_investor {
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

    public(friend) fun autocompound<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        let (v0, v1) = autocompound_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0 || 0x2::balance::value<T1>(&v2) > 0) {
            deposit<T0, T1>(arg0, arg3, arg6, v3, v2, arg7);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
            0x2::balance::destroy_zero<T1>(v2);
        };
    }

    fun autocompound_internal<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position");
        let v1 = 0x2::coin::zero<T1>(arg9);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg5));
        if (0x1::option::is_some<u64>(&v2) == true) {
            0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg5, v0, arg3, true, arg8), arg9));
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
            0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg9));
        };
        let v3 = 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()) == true) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v3, 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>())));
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg5));
        if (0x1::option::is_some<u64>(&v4) == true) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg5, v0, arg3, true, arg8));
        };
        let v5 = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v3);
        if (v5 >= arg0.minimum_swap_amount) {
            let (v6, v7) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>(arg2, arg4, 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v3, arg9), true, v5, arg8, arg9);
            0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v6);
            0x2::coin::join<T1>(&mut v1, v7);
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()) == true) {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>()), v3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut arg0.free_rewards, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1, (((0x2::coin::value<T1>(&v1) as u128) * (arg0.performance_fee as u128) / 10000) as u64), arg9), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::coin::into_balance<T1>(v1));
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg5, v0, true);
        let v10 = v9;
        let v11 = v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, (((0x2::balance::value<T0>(&v11) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v10, (((0x2::balance::value<T1>(&v10) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg9), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T0>(&mut v11, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v10, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        let (v12, v13) = get_total_balance_in_ratio<T0, T1>(arg0, arg1, arg2, v11, v10, arg5, arg8, arg9);
        let v14 = v13;
        let v15 = v12;
        let v16 = FreeBalanceEventNew{
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            balance_a      : 0x2::balance::value<T0>(&v15),
            balance_b      : 0x2::balance::value<T1>(&v14),
            location       : 10,
        };
        0x2::event::emit<FreeBalanceEventNew>(v16);
        0x2::balance::join<T0>(&mut v15, arg6);
        0x2::balance::join<T1>(&mut v14, arg7);
        let (_, v18, v19) = get_balances_in_ratio<T0, T1>(arg0, v15, v14, arg5, true);
        let v20 = v19;
        let v21 = v18;
        let v22 = FreeBalanceEventNew{
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            balance_a      : 0x2::balance::value<T0>(&v21),
            balance_b      : 0x2::balance::value<T1>(&v20),
            location       : 11,
        };
        0x2::event::emit<FreeBalanceEventNew>(v22);
        if (0x2::balance::value<T0>(&v21) <= 100 && 0x2::balance::value<T1>(&v20) <= 100) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut v21));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut v20));
        };
        (v21, v20)
    }

    public fun collect_and_convert_reward_to_sui<T0, T1, T2>(arg0: &mut Investor<T0, T2>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T1>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T2>(arg2));
        if (0x1::option::is_some<u64>(&v1) == true) {
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T2, T1>(arg4, arg2, v0, arg5, true, arg6);
            let v3 = 0x2::balance::value<T1>(&v2);
            let v4 = 0x2::coin::from_balance<T1>(v2, arg7);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                0x2::coin::join<T1>(&mut v4, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg7));
                v3 = 0x2::coin::value<T1>(&v4);
            };
            if (v3 >= arg0.minimum_swap_amount) {
                let (v5, v6) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<T1, 0x2::sui::SUI>(arg4, arg3, v4, true, v3, arg6, arg7);
                0x2::coin::destroy_zero<T1>(v5);
                if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
                    0x2::balance::join<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()), 0x2::coin::into_balance<0x2::sui::SUI>(v6));
                } else {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>(), 0x2::coin::into_balance<0x2::sui::SUI>(v6));
                };
            } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>()), 0x2::coin::into_balance<T1>(v4));
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>(), 0x2::coin::into_balance<T1>(v4));
            };
        };
    }

    public fun create_investor<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: u32, arg3: u32, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
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

    fun create_position<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"Position") == false, 2);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg1, arg0.lower_tick, arg0.upper_tick, arg3));
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = LiquidityBeforeDepositEvent{liquidity: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0)};
        0x2::event::emit<LiquidityBeforeDepositEvent>(v1);
        let v2 = if (0x2::balance::value<T0>(&arg3) == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, v0, 0x2::balance::value<T1>(&arg4), false, arg5)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, v0, 0x2::balance::value<T0>(&arg3), true, arg5)
        };
        let v3 = v2;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        let v6 = FreeBalanceEventNew{
            free_balance_a : v4,
            free_balance_b : v5,
            balance_a      : 0x2::balance::value<T0>(&arg3),
            balance_b      : 0x2::balance::value<T1>(&arg4),
            location       : 20,
        };
        0x2::event::emit<FreeBalanceEventNew>(v6);
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, v4), 0x2::balance::split<T1>(&mut arg4, v5), v3);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        arg0.is_emergency = true;
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position")), arg5);
        0x2::balance::join<T0>(&mut arg0.emergency_balance_a, v0);
        0x2::balance::join<T1>(&mut arg0.emergency_balance_b, v1);
    }

    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        if (0x2::balance::value<T0>(&arg1) == 0 || 0x2::balance::value<T1>(&arg2) == 0) {
            (0, arg1, arg2)
        } else {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T0>(&arg1), true);
            let v8 = FreeBalanceEventNew{
                free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
                free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
                balance_a      : v6,
                balance_b      : v7,
                location       : 30,
            };
            0x2::event::emit<FreeBalanceEventNew>(v8);
            let v9 = 0x2::balance::value<T1>(&arg2);
            if (v7 <= v9) {
                if (arg4 == false) {
                    assert!(((v9 - v7) as u128) * 1000000000 / (v9 as u128) <= 10000000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::difference_too_high());
                };
                0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
                (v5, arg1, 0x2::balance::split<T1>(&mut arg2, v7))
            } else {
                let (v10, v11, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
                let v13 = v11;
                let v14 = 0x2::balance::value<T0>(&arg1);
                assert!(v11 <= v14, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_to_add_liquidity());
                if (arg4 == false) {
                    assert!(((v14 - v11) as u128) * 1000000000 / (v14 as u128) <= 10000000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::difference_too_high());
                };
                if (v11 > 1) {
                    v13 = v11 - 1;
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
                (v10, 0x2::balance::split<T0>(&mut arg1, v13), arg2)
            }
        }
    }

    fun get_total_balance_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg4));
        };
        let (_, v1, v2) = get_balances_in_ratio<T0, T1>(arg0, arg3, arg4, arg5, true);
        let v3 = v2;
        let v4 = v1;
        let v5 = FreeBalanceEventNew{
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            balance_a      : 0x2::balance::value<T0>(&v4),
            balance_b      : 0x2::balance::value<T1>(&v3),
            location       : 40,
        };
        0x2::event::emit<FreeBalanceEventNew>(v5);
        let (_, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 1000000000000, true);
        let v9 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v10 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v9 > 0) {
            let v11 = v9 / 2;
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, true, true, v11);
            let v13 = (v7 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v12) as u256) + (v11 as u256) * (v8 as u256);
            let v14 = if (v13 > 0) {
                (v9 as u256) * (v8 as u256) * (v11 as u256) / v13
            } else {
                0
            };
            let v15 = SplitAndSwapEventNew{
                to_split     : v14,
                free_balance : 0x2::balance::value<T0>(&arg0.free_balance_a),
                location     : 41,
            };
            0x2::event::emit<SplitAndSwapEventNew>(v15);
            if (v14 >= (arg0.minimum_swap_amount as u256)) {
                let (v16, v17) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v14 as u64)), arg7), true, (v14 as u64), arg6, arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v17));
                0x2::balance::join<T0>(&mut v4, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v10 > 0) {
            let v18 = v10 / 2;
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, false, true, v18);
            let v20 = (v8 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v19) as u256) + (v18 as u256) * (v7 as u256);
            let v21 = if (v20 > 0) {
                (v10 as u256) * (v7 as u256) * (v18 as u256) / v20
            } else {
                0
            };
            let v22 = SplitAndSwapEventNew{
                to_split     : v21,
                free_balance : 0x2::balance::value<T1>(&arg0.free_balance_b),
                location     : 42,
            };
            0x2::event::emit<SplitAndSwapEventNew>(v22);
            if (v21 >= (arg0.minimum_swap_amount as u256)) {
                let (v23, v24) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_b2a<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v21 as u64)), arg7), true, (v21 as u64), arg6, arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v24, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T0>(&mut v4, 0x2::coin::into_balance<T0>(v23));
                0x2::balance::join<T1>(&mut v3, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v4, v3)
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"))
    }

    public fun is_emergency<T0, T1>(arg0: &Investor<T0, T1>) : bool {
        arg0.is_emergency
    }

    public fun rebalance<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::RebalanceCap, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg7: u32, arg8: u32, arg9: u32, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg4, arg10, arg7, arg8, arg12);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let v3 = AfterRebalanceEvent{liquidity: v2};
        0x2::event::emit<AfterRebalanceEvent>(v3);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg10), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg10), v2, false);
        let v6 = RebalanceEvent{
            a : 0x2::balance::value<T0>(&arg0.free_balance_a) + v4,
            b : 0x2::balance::value<T1>(&arg0.free_balance_b) + v5,
        };
        0x2::event::emit<RebalanceEvent>(v6);
        let v7 = arg0.lower_tick;
        let v8 = arg0.upper_tick;
        arg0.lower_tick = arg7;
        arg0.upper_tick = arg8;
        let v9 = v2 / (arg9 as u128);
        let v10 = v2 % (arg9 as u128);
        let v11 = 0;
        while (v11 < arg9 + 1) {
            if (v11 == arg9) {
                if (v10 == 0) {
                    break
                };
                v9 = v10;
            };
            let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg4, arg10, &mut v0, v9, arg11);
            let (v14, v15) = get_total_balance_in_ratio<T0, T1>(arg0, arg3, arg4, v12, v13, arg10, arg11, arg12);
            let (_, v17, v18) = get_balances_in_ratio<T0, T1>(arg0, v14, v15, arg10, true);
            let v19 = v18;
            let v20 = v17;
            if (0x2::balance::value<T0>(&v20) > 0 || 0x2::balance::value<T1>(&v19) > 0) {
                let v21 = if (0x2::balance::value<T0>(&v20) == 0) {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg10, &mut v1, 0x2::balance::value<T1>(&v19), false, arg11)
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg10, &mut v1, 0x2::balance::value<T0>(&v20), true, arg11)
                };
                let v22 = v21;
                let (v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v22);
                let v25 = FreeBalanceEventNew{
                    free_balance_a : v23,
                    free_balance_b : v24,
                    balance_a      : 0x2::balance::value<T0>(&v20),
                    balance_b      : 0x2::balance::value<T1>(&v19),
                    location       : 50,
                };
                0x2::event::emit<FreeBalanceEventNew>(v25);
                0x2::balance::join<T0>(&mut arg0.free_balance_a, v20);
                0x2::balance::join<T1>(&mut arg0.free_balance_b, v19);
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg4, arg10, 0x2::balance::split<T0>(&mut v20, v23), 0x2::balance::split<T1>(&mut v19, v24), v22);
            } else {
                0x2::balance::destroy_zero<T0>(v20);
                0x2::balance::destroy_zero<T1>(v19);
            };
            v11 = v11 + 1;
        };
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v0);
        arg0.lower_tick = v7;
        arg0.upper_tick = v8;
        let (v26, v27) = autocompound_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg10, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg11, arg12);
        let v28 = v27;
        let v29 = v26;
        close_position<T0, T1>(arg10, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), arg4);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v1);
        arg0.lower_tick = arg7;
        arg0.upper_tick = arg8;
        if (0x2::balance::value<T0>(&v29) > 0 || 0x2::balance::value<T1>(&v28) > 0) {
            deposit<T0, T1>(arg0, arg4, arg10, v29, v28, arg11);
        } else {
            0x2::balance::destroy_zero<T0>(v29);
            0x2::balance::destroy_zero<T1>(v28);
        };
        let v30 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"));
        let v31 = AfterRebalanceEvent{liquidity: v30};
        0x2::event::emit<AfterRebalanceEvent>(v31);
        let (v32, v33) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg10), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg10), v30, false);
        let v34 = RebalanceEvent{
            a : 0x2::balance::value<T0>(&arg0.free_balance_a) + v32,
            b : 0x2::balance::value<T1>(&arg0.free_balance_b) + v33,
        };
        0x2::event::emit<RebalanceEvent>(v34);
    }

    public fun reposition<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg2: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg3: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg7: u32, arg8: u32, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"));
        let v1 = AfterRebalanceEvent{liquidity: v0};
        0x2::event::emit<AfterRebalanceEvent>(v1);
        let (v2, v3) = withdraw<T0, T1>(arg0, v0, arg4, arg9, arg10);
        let (v4, v5) = autocompound_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg9, v2, v3, arg10, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg4, arg9, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"));
        arg0.lower_tick = arg7;
        arg0.upper_tick = arg8;
        create_position<T0, T1>(arg0, arg9, arg4, arg11);
        let (_, v7, v8) = get_balances_in_ratio<T0, T1>(arg0, v4, v5, arg9, true);
        let v9 = v8;
        let v10 = v7;
        if (0x2::balance::value<T0>(&v10) > 0 || 0x2::balance::value<T1>(&v9) > 0) {
            deposit<T0, T1>(arg0, arg4, arg9, v10, v9, arg10);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
            0x2::balance::destroy_zero<T1>(v9);
        };
        let v11 = AfterRebalanceEvent{liquidity: get_total_liquidity<T0, T1>(arg0)};
        0x2::event::emit<AfterRebalanceEvent>(v11);
    }

    entry fun set_minimum_swap_amount<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.performance_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
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

