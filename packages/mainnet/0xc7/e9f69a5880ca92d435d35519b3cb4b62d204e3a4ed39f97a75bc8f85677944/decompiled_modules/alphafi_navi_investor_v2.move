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

    public(friend) fun autocompound<T0>(arg0: &mut Investor<T0>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg4, arg6, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - arg0.tokensDeposited;
        let v2 = 0x2::balance::zero<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg5, v1) > 0) {
            let v3 = withdraw_from_navi<T0>(arg0, arg2, arg3, arg4, arg5, arg6, v1, arg7, arg8);
            0x2::balance::join<T0>(&mut v2, v3);
        };
        let v4 = (0x2::balance::value<T0>(&v2) as u128) * (arg0.performance_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, (v4 as u64)), arg9), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg1));
        let v5 = get_total_invested<T0>(arg0, arg4, arg6, arg2);
        let v6 = AutoCompoundingEvent{
            investor_id     : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount : 0x2::balance::value<T0>(&v2),
            total_amount    : v5,
            fee_collected   : (v4 as u64),
            location        : 20,
        };
        0x2::event::emit<AutoCompoundingEvent>(v6);
        if (0x2::balance::value<T0>(&v2) > 0) {
            deposit<T0>(arg0, arg2, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(v2, arg9), arg7, arg8);
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
    }

    public(friend) fun autocompound_with_three_swaps<T0, T1, T2, T3>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T3>(arg1, arg4, arg5, arg2, arg3, 1, &arg0.navi_acc_cap);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T3>()) == true) {
            0x2::balance::join<T3>(&mut v1, 0x2::balance::withdraw_all<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.free_rewards, 0x1::type_name::get<T3>())));
        };
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::value<T3>(&v1);
        if (v3 >= arg0.minimum_swap_amount) {
            let (v4, v5) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T3, T2>(arg9, arg6, 0x2::coin::from_balance<T3>(v1, arg10), true, v3, arg1, arg10);
            let v6 = v5;
            0x2::coin::destroy_zero<T3>(v4);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
                0x2::coin::join<T2>(&mut v6, 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())), arg10));
            };
            let v7 = 0x2::coin::value<T2>(&v6);
            if (v7 >= arg0.minimum_swap_amount) {
                let (v8, v9) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T1, T2>(arg9, arg7, v6, true, v7, arg1, arg10);
                let v10 = v8;
                0x2::coin::destroy_zero<T2>(v9);
                if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                    0x2::coin::join<T1>(&mut v10, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg10));
                };
                let v11 = 0x2::coin::value<T1>(&v10);
                if (v11 >= arg0.minimum_swap_amount) {
                    let (v12, v13) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T1, T0>(arg9, arg8, v10, true, v11, arg1, arg10);
                    0x2::coin::destroy_zero<T1>(v12);
                    0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v13));
                } else {
                    update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v10));
                };
            } else {
                update_free_rewards<T0, T2>(arg0, 0x2::coin::into_balance<T2>(v6));
            };
        } else {
            update_free_rewards<T0, T3>(arg0, v1);
        };
        update_free_rewards<T0, T0>(arg0, v2);
    }

    public(friend) fun autocompound_with_two_swaps<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T2>(arg1, arg4, arg5, arg2, arg3, 1, &arg0.navi_acc_cap);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(&mut v1, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())));
        };
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::value<T2>(&v1);
        if (v3 >= arg0.minimum_swap_amount) {
            let (v4, v5) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T2, T1>(arg8, arg6, 0x2::coin::from_balance<T2>(v1, arg9), true, v3, arg1, arg9);
            let v6 = v5;
            0x2::coin::destroy_zero<T2>(v4);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg9));
            };
            let v7 = 0x2::coin::value<T1>(&v6);
            if (v7 >= arg0.minimum_swap_amount) {
                let (v8, v9) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T0, T1>(arg8, arg7, v6, true, v7, arg1, arg9);
                0x2::coin::destroy_zero<T1>(v9);
                0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v8));
            } else {
                update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v6));
            };
        } else {
            update_free_rewards<T0, T2>(arg0, v1);
        };
        update_free_rewards<T0, T0>(arg0, v2);
    }

    public(friend) fun autocompound_with_two_swaps_v2<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T2>(arg1, arg4, arg5, arg2, arg3, 1, &arg0.navi_acc_cap);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(&mut v1, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())));
        };
        let v2 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg1, arg4, arg6, arg2, arg3, 1, &arg0.navi_acc_cap));
        let v3 = 0x2::balance::value<T2>(&v1);
        if (v3 >= arg0.minimum_swap_amount) {
            let (v4, v5) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T2, T1>(arg9, arg7, 0x2::coin::from_balance<T2>(v1, arg10), true, v3, arg1, arg10);
            let v6 = v5;
            0x2::coin::destroy_zero<T2>(v4);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg10));
            };
            let v7 = 0x2::coin::value<T1>(&v6);
            if (v7 >= arg0.minimum_swap_amount) {
                let (v8, v9) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T0, T1>(arg9, arg8, v6, true, v7, arg1, arg10);
                0x2::coin::destroy_zero<T1>(v9);
                0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v8));
            } else {
                update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v6));
            };
        } else {
            update_free_rewards<T0, T2>(arg0, v1);
        };
        update_free_rewards<T0, T0>(arg0, v2);
    }

    public(friend) fun collect_reward_with_no_swap<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let (v1, v2, _, _, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg1, arg2, arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap)));
        let v6 = v5;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::zero<T0>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v7, v10) == 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                let v11 = 0x1::vector::empty<0x1::ascii::String>();
                0x1::vector::push_back<0x1::ascii::String>(&mut v11, *0x1::vector::borrow<0x1::ascii::String>(&v8, v10));
                0x2::balance::join<T0>(&mut v9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg1, arg4, arg2, arg5, v11, *0x1::vector::borrow<vector<address>>(&v6, v10), &arg0.navi_acc_cap));
                break
            };
            v10 = v10 + 1;
        };
        update_free_rewards<T0, T0>(arg0, v9);
    }

    public(friend) fun collect_reward_with_three_swaps<T0, T1, T2, T3>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T3>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let (v1, v2, _, _, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg1, arg2, arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap)));
        let v6 = v5;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::zero<T3>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v7, v10) == 0x1::type_name::into_string(0x1::type_name::get<T3>())) {
                let v11 = 0x1::vector::empty<0x1::ascii::String>();
                0x1::vector::push_back<0x1::ascii::String>(&mut v11, *0x1::vector::borrow<0x1::ascii::String>(&v8, v10));
                0x2::balance::join<T3>(&mut v9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T3>(arg1, arg4, arg2, arg5, v11, *0x1::vector::borrow<vector<address>>(&v6, v10), &arg0.navi_acc_cap));
                break
            };
            v10 = v10 + 1;
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T3>()) == true) {
            0x2::balance::join<T3>(&mut v9, 0x2::balance::withdraw_all<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.free_rewards, 0x1::type_name::get<T3>())));
        };
        let v12 = 0x2::balance::zero<T0>();
        let v13 = 0x2::balance::value<T3>(&v9);
        if (v13 >= arg0.minimum_swap_amount) {
            let (v14, v15) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T3, T2>(arg9, arg6, 0x2::coin::from_balance<T3>(v9, arg10), true, v13, arg1, arg10);
            let v16 = v15;
            0x2::coin::destroy_zero<T3>(v14);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
                0x2::coin::join<T2>(&mut v16, 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())), arg10));
            };
            let v17 = 0x2::coin::value<T2>(&v16);
            if (v17 >= arg0.minimum_swap_amount) {
                let (v18, v19) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T1, T2>(arg9, arg7, v16, true, v17, arg1, arg10);
                let v20 = v18;
                0x2::coin::destroy_zero<T2>(v19);
                if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                    0x2::coin::join<T1>(&mut v20, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg10));
                };
                let v21 = 0x2::coin::value<T1>(&v20);
                if (v21 >= arg0.minimum_swap_amount) {
                    let (v22, v23) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T1, T0>(arg9, arg8, v20, true, v21, arg1, arg10);
                    0x2::coin::destroy_zero<T1>(v22);
                    0x2::balance::join<T0>(&mut v12, 0x2::coin::into_balance<T0>(v23));
                } else {
                    update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v20));
                };
            } else {
                update_free_rewards<T0, T2>(arg0, 0x2::coin::into_balance<T2>(v16));
            };
        } else {
            update_free_rewards<T0, T3>(arg0, v9);
        };
        update_free_rewards<T0, T0>(arg0, v12);
    }

    public(friend) fun collect_reward_with_two_swaps<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg3, arg1);
        if (v0 == 0) {
            return
        };
        let (v1, v2, _, _, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg1, arg2, arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap)));
        let v6 = v5;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::zero<T2>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v7, v10) == 0x1::type_name::into_string(0x1::type_name::get<T2>())) {
                let v11 = 0x1::vector::empty<0x1::ascii::String>();
                0x1::vector::push_back<0x1::ascii::String>(&mut v11, *0x1::vector::borrow<0x1::ascii::String>(&v8, v10));
                0x2::balance::join<T2>(&mut v9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg1, arg4, arg2, arg5, v11, *0x1::vector::borrow<vector<address>>(&v6, v10), &arg0.navi_acc_cap));
                break
            };
            v10 = v10 + 1;
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T2>()) == true) {
            0x2::balance::join<T2>(&mut v9, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::get<T2>())));
        };
        let v12 = 0x2::balance::zero<T0>();
        let v13 = 0x2::balance::value<T2>(&v9);
        if (v13 >= arg0.minimum_swap_amount) {
            let (v14, v15) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_a2b<T2, T1>(arg8, arg6, 0x2::coin::from_balance<T2>(v9, arg9), true, v13, arg1, arg9);
            let v16 = v15;
            0x2::coin::destroy_zero<T2>(v14);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T1>()) == true) {
                0x2::coin::join<T1>(&mut v16, 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::get<T1>())), arg9));
            };
            let v17 = 0x2::coin::value<T1>(&v16);
            if (v17 >= arg0.minimum_swap_amount) {
                let (v18, v19) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::converter::swap_b2a<T0, T1>(arg8, arg7, v16, true, v17, arg1, arg9);
                0x2::coin::destroy_zero<T1>(v19);
                0x2::balance::join<T0>(&mut v12, 0x2::coin::into_balance<T0>(v18));
            } else {
                update_free_rewards<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v16));
            };
        } else {
            update_free_rewards<T0, T2>(arg0, v9);
        };
        update_free_rewards<T0, T0>(arg0, v12);
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

    public(friend) fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg7, arg6, &arg0.navi_acc_cap);
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg2, arg4, arg1);
    }

    public(friend) fun get_total_invested<T0>(arg0: &Investor<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8, arg3: &0x2::clock::Clock) : u64 {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg3, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64)
    }

    public(friend) fun has_unclaimed_rewards<T0>(arg0: &Investor<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &0x2::clock::Clock) : bool {
        let (_, _, v2, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg3, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap)));
        let v5 = v2;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u256>(&v5)) {
            if (*0x1::vector::borrow<u256>(&v5, v6) > 0) {
                return true
            };
            v6 = v6 + 1;
        };
        false
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

    public(friend) fun withdraw_from_navi<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) : 0x2::balance::Balance<T0> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg4, arg6), arg8, arg7, &arg0.navi_acc_cap);
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg3, arg5, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

