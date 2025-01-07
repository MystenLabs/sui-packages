module 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        xTokenSupply: u128,
        tokensInvested: u128,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        paused: bool,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pool_id: 0x2::object::ID,
        xTokenBalance: u128,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct ALPHAFI_CETUS_SUI_POOL has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct AfterTransactionEvent has copy, drop {
        tokensInvested: u128,
        xtokenSupply: u128,
        liquidity: u128,
    }

    struct LiquidityChangeNewNewEvent has copy, drop {
        pool_id: 0x2::object::ID,
        event_type: u8,
        total_amount_a: u64,
        total_amount_b: u64,
        fee_collected_a: u64,
        fee_collected_b: u64,
        amount_a: u64,
        amount_b: u64,
        user_total_x_token_balance: u128,
        x_token_supply: u128,
        tokens_invested: u128,
        sender: address,
    }

    public fun deposit<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &mut 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg3.id);
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::assert_pool<T0, T1>(arg7, &v0);
        if (0x1::option::is_some<Receipt>(&arg2) == true) {
            if (0x1::option::borrow<Receipt>(&arg2).owner != 0x2::tx_context::sender(arg12)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg2), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_onhold_receipts_wallet_address(arg6));
                0x1::option::destroy_none<Receipt>(arg2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg12));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, 0x2::tx_context::sender(arg12));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(arg3.paused == false, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg4) > 0 || 0x2::coin::value<T1>(&arg5) > 0, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::zero_deposit_error());
        update_pool<T0, T1>(arg0, arg3, arg7, arg6, arg8, arg9, arg10, arg11, arg12);
        get_pool_rewards_all<T0, T1>(arg3, arg1, arg6, arg11, arg12);
        if (0x1::option::is_some<Receipt>(&arg2) == true) {
            assert_receipt<T0, T1>(0x1::option::borrow_mut<Receipt>(&mut arg2), arg3);
        };
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        let v2 = 0x2::coin::into_balance<T1>(arg5);
        let v3 = (0x2::balance::value<T0>(&v1) as u128) * (arg3.deposit_fee as u128) / 10000;
        let v4 = (0x2::balance::value<T1>(&v2) as u128) * (arg3.deposit_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, (v3 as u64)), arg12), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, (v4 as u64)), arg12), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg6));
        let (_, v6, v7, v8) = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_balances_in_ratio<T0, T1>(arg7, v1, v2, arg10, false);
        let v9 = v7;
        let v10 = v6;
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::deposit<T0, T1>(arg7, arg8, arg10, v10, v9, v8, arg11);
        arg3.tokensInvested = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_total_liquidity<T0, T1>(arg7);
        let v11 = ((arg3.tokensInvested - arg3.tokensInvested) as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate<T0, T1>(arg3);
        assert!(v11 > 0, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::insufficient_deposit_amount());
        arg3.xTokenSupply = arg3.xTokenSupply + (v11 as u128);
        let v12 = if (0x1::option::is_some<Receipt>(&arg2) == true) {
            let v13 = 0x1::option::extract<Receipt>(&mut arg2);
            let v14 = &mut v13;
            update_user_rewards_all<T0, T1>(v14, arg3);
            v13.xTokenBalance = v13.xTokenBalance + (v11 as u128);
            v13
        } else {
            let v15 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v16 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v17 = 0;
            while (v17 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg3.acc_rewards_per_xtoken)) {
                let (v18, v19) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg3.acc_rewards_per_xtoken, v17);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v15, *v18, *v19);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v16, *v18, 0);
                v17 = v17 + 1;
            };
            Receipt{id: 0x2::object::new(arg12), owner: 0x2::tx_context::sender(arg12), name: 0x1::string::utf8(arg3.name), image_url: 0x1::string::utf8(arg3.image_url), pool_id: 0x2::object::uid_to_inner(&arg3.id), xTokenBalance: (v11 as u128), last_acc_reward_per_xtoken: v15, pending_rewards: v16}
        };
        let v20 = v12;
        0x1::option::destroy_none<Receipt>(arg2);
        let (v21, v22) = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_amounts<T0, T1>(arg7, arg10);
        let v23 = LiquidityChangeNewNewEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg3.id),
            event_type                 : 0,
            total_amount_a             : v21,
            total_amount_b             : v22,
            fee_collected_a            : (v3 as u64),
            fee_collected_b            : (v4 as u64),
            amount_a                   : 0x2::balance::value<T0>(&v10),
            amount_b                   : 0x2::balance::value<T1>(&v9),
            user_total_x_token_balance : v20.xTokenBalance,
            x_token_supply             : arg3.xTokenSupply,
            tokens_invested            : arg3.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<LiquidityChangeNewNewEvent>(v23);
        0x1::option::some<Receipt>(v20)
    }

    public fun user_emergency_withdraw<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>, arg5: &mut Pool<T0, T1>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &mut 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg5.id);
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::assert_pool<T0, T1>(arg7, &v0);
        if (arg2.owner != 0x2::tx_context::sender(arg9)) {
            0x2::transfer::public_transfer<Receipt>(arg2, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_onhold_receipts_wallet_address(arg6));
            0x2::transfer::public_transfer<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(0x1::option::extract<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg9));
            0x1::option::destroy_none<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(arg3);
            return
        };
        assert!(arg5.paused == true, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::pool_paused());
        assert_receipt<T0, T1>(&arg2, arg5);
        get_pool_rewards_all<T0, T1>(arg5, arg1, arg6, arg8, arg9);
        let v1 = arg2.xTokenBalance;
        arg5.xTokenSupply = arg5.xTokenSupply - v1;
        arg2.xTokenBalance = arg2.xTokenBalance - v1;
        let (v2, v3) = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::user_emergency_withdraw<T0, T1>(arg7, v1, arg5.xTokenSupply);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, (((0x2::balance::value<T0>(&v5) as u128) * (arg5.withdrawal_fee as u128) / 10000) as u64)), arg9), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, (((0x2::balance::value<T1>(&v4) as u128) * (arg5.withdrawal_fee as u128) / 10000) as u64)), arg9), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg9), 0x2::tx_context::sender(arg9));
        let v6 = AfterTransactionEvent{
            tokensInvested : arg5.tokensInvested,
            xtokenSupply   : arg5.xTokenSupply,
            liquidity      : 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_total_liquidity<T0, T1>(arg7),
        };
        0x2::event::emit<AfterTransactionEvent>(v6);
        destroy_receipt_and_transfer_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg8, arg9);
    }

    public fun withdraw<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>, arg5: &mut Pool<T0, T1>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &mut 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg8: u128, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg5.id);
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::assert_pool<T0, T1>(arg7, &v0);
        if (arg2.owner != 0x2::tx_context::sender(arg13)) {
            0x2::transfer::public_transfer<Receipt>(arg2, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_onhold_receipts_wallet_address(arg6));
            0x2::transfer::public_transfer<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(0x1::option::extract<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg13));
            0x1::option::destroy_none<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(arg3);
            return 0x1::option::none<Receipt>()
        };
        assert!(arg5.paused == false, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::pool_paused());
        assert_receipt<T0, T1>(&arg2, arg5);
        assert!(arg8 <= arg2.xTokenBalance, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::insufficient_balance_error());
        update_pool<T0, T1>(arg0, arg5, arg7, arg6, arg9, arg10, arg11, arg12, arg13);
        get_pool_rewards_all<T0, T1>(arg5, arg1, arg6, arg12, arg13);
        let v1 = &mut arg2;
        update_user_rewards_all<T0, T1>(v1, arg5);
        arg5.xTokenSupply = arg5.xTokenSupply - arg8;
        arg2.xTokenBalance = arg2.xTokenBalance - arg8;
        let (v2, v3) = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::withdraw<T0, T1>(arg7, (((arg8 as u256) * exchange_rate<T0, T1>(arg5) / (1000000000000000000000000000000000000 as u256)) as u128), arg9, arg11, arg12);
        let v4 = v3;
        let v5 = v2;
        arg5.tokensInvested = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_total_liquidity<T0, T1>(arg7);
        let v6 = (0x2::balance::value<T0>(&v5) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        let v7 = (0x2::balance::value<T1>(&v4) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, (v6 as u64)), arg13), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, (v7 as u64)), arg13), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg13), 0x2::tx_context::sender(arg13));
        let (v8, v9) = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_amounts<T0, T1>(arg7, arg11);
        let v10 = LiquidityChangeNewNewEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg5.id),
            event_type                 : 1,
            total_amount_a             : v8,
            total_amount_b             : v9,
            fee_collected_a            : (v6 as u64),
            fee_collected_b            : (v7 as u64),
            amount_a                   : 0x2::balance::value<T0>(&v5),
            amount_b                   : 0x2::balance::value<T1>(&v4),
            user_total_x_token_balance : arg2.xTokenBalance,
            x_token_supply             : arg5.xTokenSupply,
            tokens_invested            : arg5.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<LiquidityChangeNewNewEvent>(v10);
        if (arg2.xTokenBalance == 0) {
            destroy_receipt_and_transfer_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg12, arg13);
            0x1::option::none<Receipt>()
        } else {
            if (0x1::option::is_some<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(&arg3) == true) {
                0x2::transfer::public_transfer<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(0x1::option::extract<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg13));
            };
            0x1::option::destroy_none<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(arg3);
            0x1::option::some<Receipt>(arg2)
        }
    }

    fun add_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = *v1 + (0x2::balance::value<T2>(&arg1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256);
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T2>(&arg1) as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, arg1);
        };
    }

    fun assert_receipt<T0, T1>(arg0: &Receipt, arg1: &Pool<T0, T1>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::invalid_receipt_error());
    }

    public fun create<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg1);
        let v0 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg4),
            name                   : arg2,
            image_url              : arg3,
            xTokenSupply           : 0,
            tokensInvested         : 0,
            rewards                : 0x2::bag::new(arg4),
            acc_rewards_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            deposit_fee            : 0,
            deposit_fee_max_cap    : 100,
            withdrawal_fee         : 0,
            withdraw_fee_max_cap   : 100,
            paused                 : false,
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
    }

    fun destroy_receipt_and_transfer_rewards<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>, arg4: &mut Pool<T0, T1>, arg5: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.xTokenBalance == 0, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::receipt_not_empty());
        let v0 = &mut arg2;
        let v1 = get_user_rewards_all<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8);
        let Receipt {
            id                         : v2,
            owner                      : _,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : v8,
            pending_rewards            : _,
        } = arg2;
        let v10 = v8;
        0x2::object::delete(v2);
        let v11 = 0;
        while (v11 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v10)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v10);
            v11 = v11 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v10);
        if (0x1::option::is_some<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(&v1) == true) {
            0x2::transfer::public_transfer<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(0x1::option::extract<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(&mut v1), 0x2::tx_context::sender(arg8));
        };
        0x1::option::destroy_none<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>(v1);
    }

    fun exchange_rate<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000000000000000000000000000000 as u256)
        } else {
            (arg0.tokensInvested as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256)
        }
    }

    fun get_pool_rewards_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        get_rewards<T0, T1, 0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(arg0, arg1, arg2, arg3, arg4);
        get_rewards<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4);
    }

    fun get_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T2>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, 0x2::balance::zero<T2>());
            };
            return
        };
        let v1 = Witness{dummy_field: false};
        let v2 = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_rewards__<T2, Witness>(arg2, arg1, 0x2::object::uid_to_inner(&arg0.id), arg3, v1, arg4);
        add_rewards<T0, T1, T2>(arg0, v2);
    }

    fun get_user_rewards<T0, T1, T2>(arg0: &mut Receipt, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        get_rewards<T0, T1, T2>(arg2, arg1, arg3, arg4, arg5);
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg2.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, &v0);
            let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v4 = *v2;
                *v4
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v2);
                0
            };
            let v5 = 0x1::type_name::get<T2>();
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v5);
            *v6 = 0;
            0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg2.rewards, v0), (((((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64) + *v6) as u64))
        } else {
            0x2::balance::zero<T2>()
        }
    }

    public fun get_user_rewards_all<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>, arg4: &mut Pool<T0, T1>, arg5: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt> {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = get_user_rewards<T0, T1, 0x2::sui::SUI>(arg2, arg1, arg4, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg8), 0x2::tx_context::sender(arg8));
        stake_all_alpha_to_alpha_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg5, arg7, arg8)
    }

    fun init(arg0: ALPHAFI_CETUS_SUI_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaFi"));
        let v4 = 0x2::package::claim<ALPHAFI_CETUS_SUI_POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun set_deposit_fee<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::EmergencyCap, arg1: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg2: &mut Pool<T0, T1>, arg3: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg4: bool) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg1);
        assert!(0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::is_emergency<T0, T1>(arg3) == false || arg2.paused == false, 10001);
        arg2.paused = arg4;
    }

    entry fun set_withdrawal_fee<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    fun stake_all_alpha_to_alpha_pool<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>, arg4: &mut Pool<T0, T1>, arg5: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt> {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = get_user_rewards<T0, T1, 0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(arg2, arg1, arg4, arg5, arg7, arg8);
        if (0x2::balance::value<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(&v0) > 0) {
            0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::deposit<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(arg1, arg3, arg6, arg5, 0x2::coin::from_balance<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(v0, arg8), arg7, arg8)
        } else {
            0x2::balance::destroy_zero<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(v0);
            arg3
        }
    }

    public fun update_pool<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg3: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::assert_pool<T0, T1>(arg2, &v0);
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::autocompound<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        arg1.tokensInvested = 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::get_total_liquidity<T0, T1>(arg2);
    }

    fun update_user_rewards<T0, T1, T2>(arg0: &mut Receipt, arg1: &mut Pool<T0, T1>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &v0) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &v0);
                *v3 = *v1;
                *v3
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, v0, *v1);
                0
            };
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, &v0) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v0);
                *v4 = *v4 + (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64);
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, v0, (((*v1 - v2) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64));
            };
        };
    }

    fun update_user_rewards_all<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0, T1>) {
        update_user_rewards<T0, T1, 0x2::sui::SUI>(arg0, arg1);
        update_user_rewards<T0, T1, 0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>(arg0, arg1);
    }

    public fun user_deposit<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &mut 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg12));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0, T1>(arg0: &0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::Version, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<0x3813ca8aa2849b6369106ea749b0bdc5d72a671a267bf55a4be68c6c86fb911f::beta::BETA>, arg5: &mut Pool<T0, T1>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &mut 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::alphafi_cetus_sui_investor::Investor<T0, T1>, arg8: u128, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::version::assert_current_version(arg0);
        let v0 = withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg13));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    // decompiled from Move bytecode v6
}

