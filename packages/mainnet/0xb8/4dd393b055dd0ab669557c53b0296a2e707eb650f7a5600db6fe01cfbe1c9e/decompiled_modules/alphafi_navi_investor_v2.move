module 0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::alphafi_navi_investor_v2 {
    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        navi_acc_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        free_rewards: 0x2::bag::Bag,
        tokensDeposited: u64,
        minimum_swap_amount: u64,
        performance_fee: u64,
        max_cap_performance_fee: u64,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        fee_collected: u64,
        location: u64,
    }

    public(friend) fun autocompound_with_three_swaps<T0, T1, T2, T3>(arg0: &mut Investor<T0>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T3>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg4, arg6, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T3>(arg2, arg8, arg9, arg4, arg6, 1, &arg0.navi_acc_cap);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T3>()) == true) {
            0x2::balance::join<T3>(&mut v1, 0x2::balance::withdraw_all<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.free_rewards, 0x1::type_name::get<T3>())));
        };
        let v2 = v0 - arg0.tokensDeposited;
        let v3 = 0x2::balance::zero<T0>();
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg5, v2) > 0) {
            let v4 = withdraw_from_navi<T0>(arg0, arg2, arg3, arg4, arg5, arg6, v2, arg7, arg8);
            0x2::balance::join<T0>(&mut v3, v4);
        };
        let v5 = 0x2::balance::value<T3>(&v1);
        if (v5 >= arg0.minimum_swap_amount) {
            let (v6, v7) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T3, T2>(arg13, arg10, 0x2::coin::from_balance<T3>(v1, arg14), true, v5, arg2, arg14);
            let v8 = v7;
            0x2::coin::destroy_zero<T3>(v6);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
                0x2::coin::join<T2>(&mut v8, 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())), arg14));
            };
            let v9 = 0x2::coin::value<T2>(&v8);
            if (v9 >= arg0.minimum_swap_amount) {
                let (v10, v11) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T1, T2>(arg13, arg11, v8, true, v9, arg2, arg14);
                let v12 = v10;
                0x2::coin::destroy_zero<T2>(v11);
                if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                    0x2::coin::join<T1>(&mut v12, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg14));
                };
                let v13 = 0x2::coin::value<T1>(&v12);
                if (v13 >= arg0.minimum_swap_amount) {
                    let (v14, v15) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T1, T0>(arg13, arg12, v12, true, v13, arg2, arg14);
                    0x2::coin::destroy_zero<T1>(v14);
                    0x2::balance::join<T0>(&mut v3, 0x2::coin::into_balance<T0>(v15));
                } else {
                    update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v12));
                };
            } else {
                update_free_rewards<T0, T2>(arg0, 0x2::coin::into_balance<T2>(v8));
            };
        } else {
            update_free_rewards<T0, T3>(arg0, v1);
        };
        let v16 = (0x2::balance::value<T0>(&v3) as u128) * (arg0.performance_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, (v16 as u64)), arg14), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        let v17 = get_total_invested<T0>(arg0, arg4, arg6, arg2);
        let v18 = AutoCompoundingEvent{
            investor_id     : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount : 0x2::balance::value<T0>(&v3),
            total_amount    : v17,
            fee_collected   : (v16 as u64),
            location        : 30,
        };
        0x2::event::emit<AutoCompoundingEvent>(v18);
        if (0x2::balance::value<T0>(&v3) > 0) {
            deposit<T0>(arg0, arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(v3, arg14), arg7, arg8);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public(friend) fun autocompound_with_two_swaps<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg4, arg6, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T2>(arg2, arg8, arg9, arg4, arg6, 1, &arg0.navi_acc_cap);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(&mut v1, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())));
        };
        let v2 = v0 - arg0.tokensDeposited;
        let v3 = 0x2::balance::zero<T0>();
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg5, v2) > 0) {
            let v4 = withdraw_from_navi<T0>(arg0, arg2, arg3, arg4, arg5, arg6, v2, arg7, arg8);
            0x2::balance::join<T0>(&mut v3, v4);
        };
        let v5 = 0x2::balance::value<T2>(&v1);
        if (v5 >= arg0.minimum_swap_amount) {
            let (v6, v7) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T2, T1>(arg12, arg10, 0x2::coin::from_balance<T2>(v1, arg13), true, v5, arg2, arg13);
            let v8 = v7;
            0x2::coin::destroy_zero<T2>(v6);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                0x2::coin::join<T1>(&mut v8, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg13));
            };
            let v9 = 0x2::coin::value<T1>(&v8);
            if (v9 >= arg0.minimum_swap_amount) {
                let (v10, v11) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T0, T1>(arg12, arg11, v8, true, v9, arg2, arg13);
                0x2::coin::destroy_zero<T1>(v11);
                0x2::balance::join<T0>(&mut v3, 0x2::coin::into_balance<T0>(v10));
            } else {
                update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v8));
            };
        } else {
            update_free_rewards<T0, T2>(arg0, v1);
        };
        let v12 = (0x2::balance::value<T0>(&v3) as u128) * (arg0.performance_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, (v12 as u64)), arg13), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        let v13 = get_total_invested<T0>(arg0, arg4, arg6, arg2);
        let v14 = AutoCompoundingEvent{
            investor_id     : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount : 0x2::balance::value<T0>(&v3),
            total_amount    : v13,
            fee_collected   : (v12 as u64),
            location        : 20,
        };
        0x2::event::emit<AutoCompoundingEvent>(v14);
        if (0x2::balance::value<T0>(&v3) > 0) {
            deposit<T0>(arg0, arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(v3, arg13), arg7, arg8);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public fun create_investor<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::version::assert_current_version(arg1);
        let v0 = Investor<T0>{
            id                      : 0x2::object::new(arg2),
            navi_acc_cap            : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2),
            free_rewards            : 0x2::bag::new(arg2),
            tokensDeposited         : 0,
            minimum_swap_amount     : 100000,
            performance_fee         : 2000,
            max_cap_performance_fee : 5000,
        };
        0x2::transfer::public_share_object<Investor<T0>>(v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg0.navi_acc_cap);
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg2, arg4, arg1);
    }

    public(friend) fun get_total_invested<T0>(arg0: &Investor<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8, arg3: &0x2::clock::Clock) : u64 {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg3, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64)
    }

    entry fun set_minimum_swap_amount<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::version::Version, arg2: &mut Investor<T0>, arg3: u64) {
        0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::version::Version, arg2: &mut Investor<T0>, arg3: u64) {
        0x5d7e334882bd265ef509b842eb7319d38326f832a04ea179f1432617c96aeb06::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.max_cap_performance_fee, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    fun update_free_rewards<T0, T1>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>(), arg1);
        };
    }

    public(friend) fun withdraw_from_navi<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) : 0x2::balance::Balance<T0> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg4, arg6), arg7, arg8, &arg0.navi_acc_cap);
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg3, arg5, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

