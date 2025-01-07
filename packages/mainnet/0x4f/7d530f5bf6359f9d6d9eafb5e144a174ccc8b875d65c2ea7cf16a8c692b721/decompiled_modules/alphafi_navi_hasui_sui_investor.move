module 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::alphafi_navi_hasui_sui_investor {
    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        navi_acc_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        free_rewards: 0x2::bag::Bag,
        tokensDeposited: u64,
        minimum_swap_amount: u64,
        loops: u64,
        current_debt_to_supply_ratio: u256,
        safe_borrow_percentage: u64,
        performance_fee: u64,
        max_cap_performance_fee: u64,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        location: u64,
    }

    struct CheckRatio has copy, drop {
        ratio: u256,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        cur_total_debt: u64,
        accrued_interest: u64,
        fee_collected: u64,
        location: u64,
    }

    struct HasuiSuiPriceChangeEvent has copy, drop {
        hasui_price: u64,
        sui_price: u64,
    }

    struct DebugNewEvent has copy, drop {
        a: u256,
        b: u256,
        location: u64,
    }

    fun borrow(arg0: &Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0x2::tx_context::TxContext) {
        while (arg1 > 0) {
            let v0 = get_total_invested(arg0, arg4, arg2);
            let v1 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg4, 6) as u256) * (arg0.safe_borrow_percentage as u256);
            let v2 = DebugNewEvent{
                a        : (v1 as u256),
                b        : (arg1 as u256),
                location : 20,
            };
            0x2::event::emit<DebugNewEvent>(v2);
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg11, (((v0 as u256) * v1 / 10000000000000000000000000000000) as u64));
            let v4 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg2, arg4, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
            let v5 = DebugNewEvent{
                a        : (v3 as u256),
                b        : (v4 as u256),
                location : 21,
            };
            0x2::event::emit<DebugNewEvent>(v5);
            let v6 = 0x1::u64::min(v3 - v4, arg1);
            arg1 = arg1 - v6;
            if ((v6 as u64) >= arg0.minimum_swap_amount) {
                let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<0x2::sui::SUI>(arg2, arg3, arg4, arg6, 0, (v6 as u64), arg8, &arg0.navi_acc_cap), arg13);
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, arg4, arg5, 6, convert_sui_to_hasui(arg0, arg2, v7, arg9, arg10, arg11, arg12, arg13), arg7, arg8, &arg0.navi_acc_cap);
            };
        };
    }

    public fun admin_repay<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: u256, arg21: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        assert!(arg20 <= 900, 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::admin_repay_slippage_too_high());
        assert!((arg3 as u256) <= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg5, arg7, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2.navi_acc_cap), 0, true), 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::repay_amount_more_than_debt());
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg12, arg13, arg10, arg11, arg14, arg15, arg16, arg17, arg18, arg19, arg21);
        repay_to_navi(arg2, arg5, arg6, arg7, arg8, arg9, arg3, arg12, arg13, arg14, arg18, arg19, arg20, arg21);
        let v0 = get_total_invested(arg2, arg7, arg5);
        arg2.tokensDeposited = v0;
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg5, arg7, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2.navi_acc_cap), 0, true);
        update_debt_in_df(arg2, v1);
        if (v1 == 0) {
            arg2.loops = 0;
        };
        arg2.current_debt_to_supply_ratio = (((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg14, (v1 as u64)) as u256) * 100000000000000000000 / (v0 as u256)) as u256);
        let v2 = DebugNewEvent{
            a        : (arg2.current_debt_to_supply_ratio as u256),
            b        : (v0 as u256),
            location : 50,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        let v3 = DebugNewEvent{
            a        : (v0 as u256),
            b        : (v1 as u256),
            location : 51,
        };
        0x2::event::emit<DebugNewEvent>(v3);
    }

    public(friend) fun autocompound<T0>(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg14: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg4, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - arg0.tokensDeposited;
        let v2 = 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>();
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg5, v1) > 0) {
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, arg3, arg4, arg5, 6, v1, arg6, arg7, &arg0.navi_acc_cap));
        };
        let v3 = RewardEvent{
            coin_type : 0x1::type_name::get<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
            amount    : v1,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v3);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg2, arg7, arg9, arg4, 6, 1, &arg0.navi_acc_cap);
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg2, arg7, arg9, arg4, 0, 3, &arg0.navi_acc_cap));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()) == true) {
            0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v4, 0x2::balance::withdraw_all<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&mut arg0.free_rewards, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>())));
        };
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg2, arg7, arg8, arg4, 6, 1, &arg0.navi_acc_cap);
        0x2::balance::join<T0>(&mut v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg2, arg7, arg8, arg4, 0, 3, &arg0.navi_acc_cap));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        let v6 = 0x2::balance::zero<0x2::sui::SUI>();
        let v7 = 0x2::balance::value<T0>(&v5);
        if (v7 >= arg0.minimum_swap_amount) {
            let (v8, v9) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<T0, 0x2::sui::SUI>(arg15, arg12, 0x2::coin::from_balance<T0>(v5, arg16), true, v7, arg2, arg16);
            0x2::coin::destroy_zero<T0>(v8);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::coin::into_balance<0x2::sui::SUI>(v9));
        } else {
            update_free_rewards<T0>(arg0, v5);
        };
        let v10 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v4);
        if (v10 >= arg0.minimum_swap_amount) {
            let (v11, v12) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg15, arg13, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v4, arg16), true, v10, arg2, arg16);
            0x2::coin::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v11);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::coin::into_balance<0x2::sui::SUI>(v12));
        } else {
            update_free_rewards<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, v4);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>())));
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v6) >= arg0.minimum_swap_amount) {
            let v13 = 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg16);
            let v14 = convert_sui_to_hasui(arg0, arg2, v13, arg14, arg15, arg10, arg11, arg16);
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v2, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v14));
        } else {
            update_free_rewards<0x2::sui::SUI>(arg0, v6);
        };
        let v15 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow<vector<u8>, u256>(&arg0.id, b"debt")
        } else {
            0
        };
        let v16 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2);
        let v17 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg10, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg2, arg4, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64) - (v15 as u64));
        let v18 = if (v16 > v17) {
            ((v16 - v17) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v2, (v18 as u64)), arg16), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
        let v19 = get_total_invested(arg0, arg4, arg2);
        let v20 = AutoCompoundingEvent{
            investor_id      : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount  : 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2),
            total_amount     : v19,
            cur_total_debt   : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg10, (v15 as u64)),
            accrued_interest : v17,
            fee_collected    : (v18 as u64),
            location         : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v20);
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2) > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, arg4, arg5, 6, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v2, arg16), arg6, arg7, &arg0.navi_acc_cap);
        } else {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v2);
        };
        arg0.tokensDeposited = get_total_invested(arg0, arg4, arg2);
    }

    public fun change_loops_and_autocompound<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg12, arg13, arg10, arg11, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        arg2.loops = arg3;
        update_supply_and_debt(arg2, arg5, arg6, arg7, arg8, arg9, arg12, arg13, arg14, arg15, arg18, arg19, arg20);
    }

    public fun change_safe_borrow_and_autocompound<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        assert!(arg3 <= 9500, 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::high_safe_borrow());
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg12, arg13, arg10, arg11, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        arg2.safe_borrow_percentage = arg3;
        update_supply_and_debt(arg2, arg5, arg6, arg7, arg8, arg9, arg12, arg13, arg14, arg15, arg18, arg19, arg20);
    }

    public(friend) fun check_and_set_asset_ltv(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, 6);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"asset_ltv");
        if (v0 != *v1) {
            *v1 = v0;
            update_supply_and_debt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        };
    }

    public(friend) fun check_price_and_fix_health(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg1, arg2, 1000000000, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg3, 6));
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg1, arg2, 1000000000, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg3, 0));
        if (v0 < v1) {
            let v2 = HasuiSuiPriceChangeEvent{
                hasui_price : (v0 as u64),
                sui_price   : (v1 as u64),
            };
            0x2::event::emit<HasuiSuiPriceChangeEvent>(v2);
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_value(arg1, arg2, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) >= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_value(arg1, arg2, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) * (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, 6) as u256) * (arg0.safe_borrow_percentage as u256) / 10000000000000000000000000000000) {
                arg0.loops = 0;
                update_supply_and_debt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
            };
        };
    }

    fun convert_sui_to_hasui(arg0: &Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg5, v0);
        let v2 = if (v0 >= 1000000000) {
            0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg6, arg5, arg2, @0x0, arg7)
        } else {
            assert!(v0 >= arg0.minimum_swap_amount, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_to_add_liquidity());
            let (v3, v4) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_b2a<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(arg4, arg3, arg2, true, v0, arg1, arg7);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
            v3
        };
        let v5 = v2;
        let v6 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v5);
        let v7 = if (v6 < v1) {
            v1 - v6
        } else {
            0
        };
        assert!((v7 as u256) * 1000000000000000000000000000000 / (v1 as u256) < 10000000000000000000000000000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::high_slippage());
        v5
    }

    public fun create_investor(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: u64, arg3: u64, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0x2::tx_context::TxContext) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        let v0 = Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>{
            id                           : 0x2::object::new(arg5),
            navi_acc_cap                 : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg5),
            free_rewards                 : 0x2::bag::new(arg5),
            tokensDeposited              : 0,
            minimum_swap_amount          : 1000,
            loops                        : arg2,
            current_debt_to_supply_ratio : 0,
            safe_borrow_percentage       : arg3,
            performance_fee              : 2000,
            max_cap_performance_fee      : 5000,
        };
        0x2::dynamic_field::add<vector<u8>, u256>(&mut v0.id, b"asset_ltv", 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg4, 6));
        let v1 = &mut v0;
        update_debt_to_supply_ratio(v1, arg4);
        0x2::transfer::public_share_object<Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(v0);
    }

    public(friend) fun deposit(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg3, arg4, 6, arg6, arg7, arg8, &arg0.navi_acc_cap);
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg11, (((0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg6) as u256) * arg0.current_debt_to_supply_ratio / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u64));
        borrow(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = get_total_invested(arg0, arg3, arg1);
        arg0.tokensDeposited = v1;
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        update_debt_in_df(arg0, v2);
    }

    public(friend) fun fix_ratio(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg3, arg1);
        if (v0 == 0 || arg0.current_debt_to_supply_ratio == 0) {
            return
        };
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg8, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64));
        if ((v1 as u256) * 100000000000000000000 < arg0.current_debt_to_supply_ratio * (v0 as u256)) {
            let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg8, (((arg0.current_debt_to_supply_ratio * (v0 as u256) - (v1 as u256) * 100000000000000000000) / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u64));
            if (v2 > arg0.minimum_swap_amount) {
                borrow(arg0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11, arg8, arg9, arg12);
            };
        } else if ((v1 as u256) * 100000000000000000000 > arg0.current_debt_to_supply_ratio * (v0 as u256)) {
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg8, ((((v1 as u256) * 100000000000000000000 - arg0.current_debt_to_supply_ratio * (v0 as u256)) / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u64));
            if (v3 > arg0.minimum_swap_amount) {
                repay_to_navi(arg0, arg1, arg2, arg3, arg4, arg5, (v3 as u64), arg6, arg7, arg8, arg10, arg11, 100, arg12);
            };
        };
        let v4 = get_total_invested(arg0, arg3, arg1);
        arg0.tokensDeposited = v4;
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        update_debt_in_df(arg0, v5);
        let v6 = CheckRatio{ratio: (((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg8, (v5 as u64)) as u256) * 100000000000000000000 / (arg0.tokensDeposited as u256)) as u256)};
        0x2::event::emit<CheckRatio>(v6);
    }

    public(friend) fun get_total_invested(arg0: &Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg2, arg1, 6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64)
    }

    public(friend) fun repay_to_navi(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg6 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(arg11, arg10, true, false, arg6, 4295048016, arg1);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v4) == arg6, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::high_slippage());
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(&v3);
        let v6 = DebugNewEvent{
            a        : (arg6 as u256),
            b        : (v5 as u256),
            location : 60,
        };
        0x2::event::emit<DebugNewEvent>(v6);
        let v7 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg9, v5);
        let v8 = if (v7 > arg6) {
            v7 - arg6
        } else {
            0
        };
        assert!(arg6 >= v5, 0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::error::hasui_price_lesser_than_sui());
        assert!((v8 as u256) * 1000000000000000000000000000000 / (arg6 as u256) < 1000000000000000000000000000000 * arg12 / 10000, 123456);
        let v9 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg13);
        if (0x2::coin::value<0x2::sui::SUI>(&v9) > 0) {
            let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<0x2::sui::SUI>(arg1, arg2, arg3, arg5, 0, v9, arg8, &arg0.navi_acc_cap);
            if (0x2::balance::value<0x2::sui::SUI>(&v10) > 0) {
                update_free_rewards<0x2::sui::SUI>(arg0, v10);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(arg11, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg2, arg3, arg4, 6, (v5 as u64), arg7, arg8, &arg0.navi_acc_cap), 0x2::balance::zero<0x2::sui::SUI>(), v3);
    }

    entry fun set_minimum_swap_amount(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: u64) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::Version, arg2: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: u64) {
        0x1a22b26f139b34c9de9718cf7e53159b2b939ec8f46f4c040776b7a3d580dd28::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.max_cap_performance_fee, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun total_supplied_without_debt(arg0: &Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let v0 = get_total_invested(arg0, arg2, arg1);
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg2, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64));
        let v2 = DebugNewEvent{
            a        : (v1 as u256),
            b        : (v0 as u256),
            location : 71,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        v0 - v1
    }

    fun update_debt_in_df(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: u256) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"debt") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u256>(&mut arg0.id, b"debt", arg1);
        };
    }

    fun update_debt_to_supply_ratio(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = (arg0.loops as u8) + 1;
        let v1 = 100000000000;
        let v2 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg1, 6) as u256) * (arg0.safe_borrow_percentage as u256) / 100000000000000000000;
        arg0.current_debt_to_supply_ratio = v2 * 100000000000000000000 * (0x1::u256::pow(v1, v0 - 1) - 0x1::u256::pow(v2, v0 - 1)) / (0x1::u256::pow(v1, v0) - 0x1::u256::pow(v2, v0));
        let v3 = DebugNewEvent{
            a        : arg0.current_debt_to_supply_ratio,
            b        : v2,
            location : 80,
        };
        0x2::event::emit<DebugNewEvent>(v3);
    }

    fun update_free_rewards<T0>(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>(), arg1);
        };
    }

    fun update_supply_and_debt(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x2::tx_context::TxContext) {
        update_debt_to_supply_ratio(arg0, arg3);
        let v0 = get_total_invested(arg0, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let v1 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
        repay_to_navi(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg6, arg7, arg8, arg10, arg11, 100, arg12);
        let v2 = get_total_invested(arg0, arg3, arg1);
        let v3 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg2, arg3, arg4, 6, v2, arg6, arg7, &arg0.navi_acc_cap), arg12);
        deposit(arg0, arg1, arg2, arg3, arg4, arg5, v3, arg6, arg7, arg10, arg11, arg8, arg9, arg12);
    }

    public(friend) fun withdraw_from_navi(arg0: &mut Investor<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = get_total_invested(arg0, arg3, arg1);
        let v1 = (arg6 as u256) * (v0 as u256) / (arg7 as u256);
        let v2 = (((arg6 as u256) * 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) / (arg7 as u256)) as u64);
        repay_to_navi(arg0, arg1, arg2, arg3, arg4, arg5, v2, arg8, arg9, arg10, arg11, arg12, 100, arg13);
        let v3 = get_total_invested(arg0, arg3, arg1);
        let v4 = (v1 as u64) - v0 - v3;
        let v5 = DebugNewEvent{
            a        : (v1 as u256),
            b        : (v4 as u256),
            location : 40,
        };
        0x2::event::emit<DebugNewEvent>(v5);
        let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg2, arg3, arg4, 6, v4, arg8, arg9, &arg0.navi_acc_cap);
        let v7 = get_total_invested(arg0, arg3, arg1);
        arg0.tokensDeposited = v7;
        let v8 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        update_debt_in_df(arg0, v8);
        v6
    }

    // decompiled from Move bytecode v6
}

