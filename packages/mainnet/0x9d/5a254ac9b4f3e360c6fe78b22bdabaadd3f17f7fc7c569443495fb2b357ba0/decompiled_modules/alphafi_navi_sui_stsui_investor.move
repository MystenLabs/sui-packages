module 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::alphafi_navi_sui_stsui_investor {
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

    struct StsuiSuiPriceChangeEvent has copy, drop {
        stsui_price: u64,
        sui_price: u64,
    }

    struct DebugNewEvent has copy, drop {
        a: u256,
        b: u256,
        location: u64,
    }

    fun borrow(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::flash_stake_start<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, arg10, (((arg1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9) as u128)) as u64), arg11);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg4, arg5, 20, v0, arg7, arg8, &arg0.navi_acc_cap);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::flash_stake_conclude<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, arg10, 0x2::coin::from_balance<0x2::sui::SUI>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<0x2::sui::SUI>(arg2, arg3, arg4, arg6, 0, ((arg1 + ((((arg1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::flash_stake_fee_bps(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::fee_config<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9)) as u128) + 9999) / 10000) as u64)) as u64), arg8, &arg0.navi_acc_cap), arg11), v1, arg11));
        update_free_rewards<0x2::sui::SUI>(arg0, v2);
    }

    public fun admin_repay<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::assert_current_version(arg1);
        assert!((arg3 as u256) <= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg5, arg7, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2.navi_acc_cap), 0, true), 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::error::repay_amount_more_than_debt());
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg10, arg11, arg12, arg15, arg16, arg17, arg18, arg19, arg20);
        repay_to_navi(arg2, arg5, arg6, arg7, arg8, arg9, arg3, arg13, arg14, arg15, arg16, arg20);
        let v0 = get_total_invested(arg2, arg7, arg5);
        assert!(v0 > 0, 999999999);
        arg2.tokensDeposited = v0;
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg5, arg7, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2.navi_acc_cap), 0, true);
        update_debt_in_df(arg2, v1);
        if (v1 == 0) {
            arg2.loops = 0;
        };
        arg2.current_debt_to_supply_ratio = ((v1 * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg15) as u256) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg15) as u256) * 100000000000000000000 / (v0 as u256)) as u256);
        let v2 = DebugNewEvent{
            a        : (arg2.current_debt_to_supply_ratio as u256),
            b        : (v0 as u256),
            location : 50,
        };
        0x2::event::emit<DebugNewEvent>(v2);
    }

    public(friend) fun autocompound<T0>(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg11: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg14: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg4, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - arg0.tokensDeposited;
        let v2 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5, v1) > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, arg4, arg5, 20, v1, arg6, arg7, &arg0.navi_acc_cap));
        };
        let v3 = RewardEvent{
            coin_type : 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            amount    : v1,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v3);
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg7, arg10, arg4, 20, 1, &arg0.navi_acc_cap));
        0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg7, arg10, arg4, 0, 3, &arg0.navi_acc_cap));
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg2, arg7, arg9, arg4, 20, 1, &arg0.navi_acc_cap);
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg2, arg7, arg9, arg4, 0, 3, &arg0.navi_acc_cap));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()) == true) {
            0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v4, 0x2::balance::withdraw_all<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&mut arg0.free_rewards, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>())));
        };
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        let v6 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v4);
        if (v6 >= arg0.minimum_swap_amount) {
            let (v7, v8) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg15, arg14, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v4, arg16), true, v6, arg2, arg16);
            0x2::coin::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v7);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::coin::into_balance<0x2::sui::SUI>(v8));
        } else {
            update_free_rewards<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, v4);
        };
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg2, arg7, arg8, arg4, 20, 1, &arg0.navi_acc_cap);
        0x2::balance::join<T0>(&mut v9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg2, arg7, arg8, arg4, 0, 3, &arg0.navi_acc_cap));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v9, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        let v10 = 0x2::balance::value<T0>(&v9);
        if (v10 >= arg0.minimum_swap_amount) {
            let (v11, v12) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T0, 0x2::sui::SUI>(arg15, arg13, 0x2::coin::from_balance<T0>(v9, arg16), true, v10, arg2, arg16);
            0x2::coin::destroy_zero<T0>(v11);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::coin::into_balance<0x2::sui::SUI>(v12));
        } else {
            update_free_rewards<T0>(arg0, v9);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>())));
        };
        if (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg11, 0x2::balance::value<0x2::sui::SUI>(&v5)) > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg11, arg12, 0x2::coin::from_balance<0x2::sui::SUI>(v5, arg16), arg16)));
        } else {
            update_free_rewards<0x2::sui::SUI>(arg0, v5);
        };
        let v13 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow<vector<u8>, u256>(&arg0.id, b"debt")
        } else {
            0
        };
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg2, arg4, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        let v15 = 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v2);
        let v16 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg11, (v14 as u64) - (v13 as u64));
        let v17 = if (v15 > v16) {
            ((v15 - v16) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, (v17 as u64)), arg16), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        let v18 = get_total_invested(arg0, arg4, arg2);
        let v19 = AutoCompoundingEvent{
            investor_id      : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount  : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v2),
            total_amount     : v18,
            cur_total_debt   : (((v14 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg11) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg11) as u128)) as u64),
            accrued_interest : v16,
            fee_collected    : (v17 as u64),
            location         : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v19);
        if (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v2) > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg4, arg5, 20, 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v2, arg16), arg6, arg7, &arg0.navi_acc_cap);
        } else {
            0x2::balance::destroy_zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v2);
        };
        arg0.tokensDeposited = get_total_invested(arg0, arg4, arg2);
    }

    public fun change_loops_and_autocompound<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::assert_current_version(arg1);
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg10, arg11, arg12, arg15, arg16, arg17, arg18, arg19, arg20);
        arg2.loops = arg3;
        update_supply_and_debt(arg2, arg5, arg6, arg7, arg8, arg9, arg13, arg14, arg15, arg16, arg20);
    }

    public fun change_safe_borrow_and_autocompound<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::assert_current_version(arg1);
        assert!(arg3 <= 9500, 0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::error::high_safe_borrow());
        autocompound<T0>(arg2, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg10, arg11, arg12, arg15, arg16, arg17, arg18, arg19, arg20);
        arg2.safe_borrow_percentage = arg3;
        update_supply_and_debt(arg2, arg5, arg6, arg7, arg8, arg9, arg13, arg14, arg15, arg16, arg20);
    }

    public(friend) fun check_and_set_asset_ltv(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, 20);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"asset_ltv");
        if (v0 != *v1) {
            *v1 = v0;
            update_supply_and_debt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        };
    }

    public(friend) fun check_price_and_fix_health(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg1, arg2, 1000000000, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg3, 20));
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg1, arg2, 1000000000, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg3, 0));
        let v2 = DebugNewEvent{
            a        : (v0 as u256),
            b        : (v1 as u256),
            location : 10,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        if (v0 < v1) {
            let v3 = StsuiSuiPriceChangeEvent{
                stsui_price : (v0 as u64),
                sui_price   : (v1 as u64),
            };
            0x2::event::emit<StsuiSuiPriceChangeEvent>(v3);
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_value(arg1, arg2, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) >= 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_value(arg1, arg2, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) * (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, 20) as u256) * (arg0.safe_borrow_percentage as u256) / 10000000000000000000000000000000) {
                arg0.loops = 0;
                update_supply_and_debt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            };
        };
    }

    public fun create_investor(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::Version, arg2: u64, arg3: u64, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0x2::tx_context::TxContext) {
        0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::assert_current_version(arg1);
        let v0 = Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>{
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
        0x2::dynamic_field::add<vector<u8>, u256>(&mut v0.id, b"asset_ltv", 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg4, 20));
        let v1 = &mut v0;
        update_debt_to_supply_ratio(v1, arg4);
        0x2::transfer::public_share_object<Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v0);
    }

    public(friend) fun deposit(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg3, arg4, 20, arg6, arg7, arg8, &arg0.navi_acc_cap);
        let v0 = (((((0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg6) as u256) * arg0.current_debt_to_supply_ratio / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9) as u128)) as u64);
        borrow(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11);
        let v1 = get_total_invested(arg0, arg3, arg1);
        arg0.tokensDeposited = v1;
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        update_debt_in_df(arg0, v2);
    }

    public(friend) fun deposit_sui(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, 0x2::coin::value<0x2::sui::SUI>(&arg6)) > 0, 9223374558000578559);
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, arg10, arg6, arg11);
        if (0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0) > 0) {
            deposit(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8, arg9, arg10, arg11);
        } else {
            0x2::coin::destroy_zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v0);
        };
    }

    public(friend) fun fix_ratio(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg3, arg1);
        if (v0 == 0 || arg0.current_debt_to_supply_ratio == 0) {
            return
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        let v2 = v1 * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u256) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u256);
        if ((v2 as u256) * 100000000000000000000 < arg0.current_debt_to_supply_ratio * (v0 as u256)) {
            let v3 = (((arg0.current_debt_to_supply_ratio * (v0 as u256) - (v2 as u256) * 100000000000000000000) / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128);
            if ((v3 as u64) > arg0.minimum_swap_amount) {
                borrow(arg0, (v3 as u64), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            };
        } else if ((v2 as u256) * 100000000000000000000 > arg0.current_debt_to_supply_ratio * (v0 as u256)) {
            let v4 = ((((v2 as u256) * 100000000000000000000 - arg0.current_debt_to_supply_ratio * (v0 as u256)) / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128);
            if ((v4 as u64) > arg0.minimum_swap_amount) {
                repay_to_navi(arg0, arg1, arg2, arg3, arg4, arg5, (v4 as u64), arg6, arg7, arg8, arg9, arg10);
            };
        };
        let v5 = get_total_invested(arg0, arg3, arg1);
        arg0.tokensDeposited = v5;
        let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        update_debt_in_df(arg0, v6);
        let v7 = CheckRatio{ratio: (((((v1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128)) as u256) * 100000000000000000000 / (arg0.tokensDeposited as u256)) as u256)};
        0x2::event::emit<CheckRatio>(v7);
    }

    public(friend) fun get_total_invested(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg2, arg1, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64)
    }

    public(friend) fun repay_to_navi(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg6 == 0) {
            return
        };
        let v0 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, 20) as u256) * 9500;
        while (arg6 > 0) {
            let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
            let v2 = get_total_invested(arg0, arg3, arg1);
            let v3 = (v2 as u256) * v0 / 10000000000000000000000000000000 - v1;
            let v4 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, (v3 as u64));
            let v5 = if (v4 <= arg6) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg2, arg3, arg4, 20, (v3 as u64), arg7, arg8, &arg0.navi_acc_cap)
            } else {
                let v6 = ((arg6 as u128) * (v3 as u128) + ((v4 - 1) as u128)) / (v4 as u128);
                let v7 = v6;
                let v8 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, (v6 as u64));
                if (arg6 >= v8) {
                    v7 = v6 + ((arg6 - v8 + 2) as u128);
                };
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg2, arg3, arg4, 20, (v7 as u64), arg7, arg8, &arg0.navi_acc_cap)
            };
            let v9 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v5, arg11), arg10, arg11);
            let v10 = DebugNewEvent{
                a        : (v4 as u256),
                b        : (0x2::coin::value<0x2::sui::SUI>(&v9) as u256),
                location : 235478,
            };
            0x2::event::emit<DebugNewEvent>(v10);
            let v11 = 0x1::u64::min(arg6, 0x2::coin::value<0x2::sui::SUI>(&v9));
            arg6 = arg6 - v11;
            let v12 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<0x2::sui::SUI>(arg1, arg2, arg3, arg5, 0, v9, arg8, &arg0.navi_acc_cap);
            if (0x2::balance::value<0x2::sui::SUI>(&v12) > 0) {
                update_free_rewards<0x2::sui::SUI>(arg0, v12);
                continue
            };
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        };
    }

    entry fun set_minimum_swap_amount(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64) {
        0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64) {
        0x5441ed00fa7b209ad951d31c6e3d4d48ad8666e6d2a5155e4f5e99dd74177288::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.max_cap_performance_fee, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun total_supplied_without_debt(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>) : u64 {
        let v0 = get_total_invested(arg0, arg2, arg1);
        let v1 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg2, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
        let v2 = (v0 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3) as u128);
        let v3 = DebugNewEvent{
            a        : (v2 as u256),
            b        : (v1 as u256),
            location : 71,
        };
        0x2::event::emit<DebugNewEvent>(v3);
        (v2 as u64) - v1
    }

    fun update_debt_in_df(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: u256) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"debt") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u256>(&mut arg0.id, b"debt", arg1);
        };
    }

    fun update_debt_to_supply_ratio(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = (arg0.loops as u8) + 1;
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg1, 20);
        let v2 = 100000000000;
        let v3 = (v1 as u256) * (arg0.safe_borrow_percentage as u256) / 100000000000000000000;
        arg0.current_debt_to_supply_ratio = v3 * 100000000000000000000 * (0x1::u256::pow(v2, v0 - 1) - 0x1::u256::pow(v3, v0 - 1)) / (0x1::u256::pow(v2, v0) - 0x1::u256::pow(v3, v0));
        let v4 = DebugNewEvent{
            a        : arg0.current_debt_to_supply_ratio,
            b        : v3,
            location : 80,
        };
        0x2::event::emit<DebugNewEvent>(v4);
        let v5 = DebugNewEvent{
            a        : (v1 as u256),
            b        : (v2 as u256),
            location : 81,
        };
        0x2::event::emit<DebugNewEvent>(v5);
    }

    fun update_free_rewards<T0>(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>(), arg1);
        };
    }

    fun update_supply_and_debt(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        update_debt_to_supply_ratio(arg0, arg3);
        let v0 = get_total_invested(arg0, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let v1 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
        repay_to_navi(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg6, arg7, arg8, arg9, arg10);
        let v2 = get_total_invested(arg0, arg3, arg1);
        let v3 = 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg2, arg3, arg4, 20, v2, arg6, arg7, &arg0.navi_acc_cap), arg10);
        deposit(arg0, arg1, arg2, arg3, arg4, arg5, v3, arg6, arg7, arg8, arg9, arg10);
    }

    public(friend) fun withdraw_from_navi(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_total_invested(arg0, arg3, arg1);
        let v1 = (arg6 as u256) * (v0 as u256) / (arg7 as u256);
        let v2 = DebugNewEvent{
            a        : (arg6 as u256),
            b        : (arg7 as u256),
            location : 38,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        let v3 = (((arg6 as u256) * 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) / (arg7 as u256)) as u64);
        repay_to_navi(arg0, arg1, arg2, arg3, arg4, arg5, v3, arg8, arg9, arg10, arg11, arg12);
        let v4 = get_total_invested(arg0, arg3, arg1);
        let v5 = (v1 as u64) - v0 - v4;
        let v6 = DebugNewEvent{
            a        : (v1 as u256),
            b        : (v5 as u256),
            location : 40,
        };
        0x2::event::emit<DebugNewEvent>(v6);
        let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg2, arg3, arg4, 20, v5, arg8, arg9, &arg0.navi_acc_cap);
        let v8 = get_total_invested(arg0, arg3, arg1);
        arg0.tokensDeposited = v8;
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        update_debt_in_df(arg0, v9);
        0x2::coin::into_balance<0x2::sui::SUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg10, 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v7, arg12), arg11, arg12))
    }

    // decompiled from Move bytecode v6
}

