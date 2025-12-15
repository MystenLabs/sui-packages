module 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        xTokenSupply: u128,
        tokensInvested: u128,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>,
        fee_balance_a: 0x2::balance::Balance<T0>,
        fee_balance_b: 0x2::balance::Balance<T1>,
        fee_address: address,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        autocompounding_on: bool,
        is_deposit_paused: bool,
        is_withdraw_paused: bool,
        investor: 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::Investor<T0, T1>,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pool_id: 0x2::object::ID,
        xTokenBalance: u128,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct ALPHAFI_LYF_POOL has drop {
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

    struct UserRewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_balance_a: u64,
        total_balance_b: u64,
        xtokenSupply: u128,
        fee_collected_a: u64,
        fee_collected_b: u64,
    }

    struct LiquidityChangeEvent has copy, drop {
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

    public fun deposit<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg2) == true) {
            if (0x1::option::borrow<Receipt>(&arg2).owner != 0x2::tx_context::sender(arg12)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg2), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg6));
                0x1::option::destroy_none<Receipt>(arg2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg12));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, 0x2::tx_context::sender(arg12));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(arg3.is_deposit_paused == false && 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::is_emergency<T0, T1>(&arg3.investor) == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg4) > 0 || 0x2::coin::value<T1>(&arg5) > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::zero_deposit_error());
        update_pool<T0, T1>(arg0, arg3, arg7, arg8, arg9, arg10, arg11, arg12);
        get_pool_rewards_all<T0, T1>(arg3, arg1, arg6, arg11, arg12);
        if (0x1::option::is_some<Receipt>(&arg2) == true) {
            assert_receipt<T0, T1>(0x1::option::borrow_mut<Receipt>(&mut arg2), arg3);
        };
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let v2 = (0x2::balance::value<T0>(&v0) as u128) * (arg3.deposit_fee as u128) / 10000;
        let v3 = (0x2::balance::value<T1>(&v1) as u128) * (arg3.deposit_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg3.fee_balance_a, 0x2::balance::split<T0>(&mut v0, (v2 as u64)));
        0x2::balance::join<T1>(&mut arg3.fee_balance_b, 0x2::balance::split<T1>(&mut v1, (v3 as u64)));
        let (_, v5, v6, v7) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_balances_in_ratio<T0, T1>(&mut arg3.investor, v0, v1, arg9, false, arg12);
        let v8 = v6;
        let v9 = v5;
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::deposit<T0, T1>(&mut arg3.investor, arg7, arg8, arg9, v9, v8, v7, arg10, arg11, arg12);
        arg3.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg3.investor, arg7, arg9, arg11, arg12);
        let v10 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg3.tokensInvested - arg3.tokensInvested), exchange_rate<T0, T1>(arg3)));
        assert!(v10 > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_deposit_amount());
        arg3.xTokenSupply = arg3.xTokenSupply + v10;
        let v11 = if (0x1::option::is_some<Receipt>(&arg2) == true) {
            let v12 = 0x1::option::extract<Receipt>(&mut arg2);
            let v13 = &mut v12;
            update_user_rewards<T0, T1>(v13, arg3);
            v12.xTokenBalance = v12.xTokenBalance + v10;
            v12
        } else {
            let v14 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>();
            let v15 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v16 = 0;
            while (v16 < 0x2::vec_map::length<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg3.acc_rewards_per_xtoken)) {
                let (v17, v18) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg3.acc_rewards_per_xtoken, v16);
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut v14, *v17, *v18);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v15, *v17, 0);
                v16 = v16 + 1;
            };
            Receipt{id: 0x2::object::new(arg12), owner: 0x2::tx_context::sender(arg12), name: 0x1::string::utf8(arg3.name), image_url: 0x1::string::utf8(arg3.image_url), pool_id: 0x2::object::uid_to_inner(&arg3.id), xTokenBalance: v10, last_acc_reward_per_xtoken: v14, pending_rewards: v15}
        };
        let v19 = v11;
        0x1::option::destroy_none<Receipt>(arg2);
        let (v20, v21) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_amounts_outer<T0, T1>(&arg3.investor, arg7, arg9, arg11, arg12);
        let v22 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg3.id),
            event_type                 : 0,
            total_amount_a             : v20,
            total_amount_b             : v21,
            fee_collected_a            : (v2 as u64),
            fee_collected_b            : (v3 as u64),
            amount_a                   : 0x2::balance::value<T0>(&v9),
            amount_b                   : 0x2::balance::value<T1>(&v8),
            user_total_x_token_balance : v19.xTokenBalance,
            x_token_supply             : arg3.xTokenSupply,
            tokens_invested            : arg3.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<LiquidityChangeEvent>(v22);
        0x1::option::some<Receipt>(v19)
    }

    public fun admin_change_leverage<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        let (v0, v1) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::admin_change_leverage<T0, T1>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg2.autocompounding_on, arg8, arg9);
        0x2::balance::join<T0>(&mut arg2.fee_balance_a, v0);
        0x2::balance::join<T1>(&mut arg2.fee_balance_b, v1);
        arg2.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg2.investor, arg4, arg6, arg8, arg9);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1, T2, T3>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &mut Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: bool, arg7: bool, arg8: bool, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::collect_reward_and_swap_bluefin<T0, T1, T2, T3>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun emergency_withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg2: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg2);
        arg0.autocompounding_on = false;
        update_pool<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, arg7, arg8);
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::emergency_withdraw<T0, T1>(&mut arg0.investor, arg3, arg4, arg5, arg7, arg8);
    }

    public fun rebalance_bluefin<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::RebalanceCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: u32, arg6: u32, arg7: u32, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        let (v0, v1) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::rebalance_bluefin<T0, T1>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::balance::join<T0>(&mut arg2.fee_balance_a, v0);
        0x2::balance::join<T1>(&mut arg2.fee_balance_b, v1);
        arg2.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg2.investor, arg3, arg8, arg10, arg11);
    }

    public fun rebalance_cetus_a2b<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::RebalanceCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: u32, arg7: u32, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        let (v0, v1) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::rebalance_cetus_a2b<T0, T1>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::balance::join<T0>(&mut arg2.fee_balance_a, v0);
        0x2::balance::join<T1>(&mut arg2.fee_balance_b, v1);
        arg2.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg2.investor, arg3, arg8, arg11, arg12);
    }

    public fun rebalance_cetus_b2a<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::RebalanceCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: u32, arg7: u32, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        let (v0, v1) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::rebalance_cetus_b2a<T0, T1>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::balance::join<T0>(&mut arg2.fee_balance_a, v0);
        0x2::balance::join<T1>(&mut arg2.fee_balance_b, v1);
        arg2.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg2.investor, arg3, arg8, arg11, arg12);
    }

    public fun rebalance_debts<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64, arg4: bool, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        let (v0, v1) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::rebalance_debts<T0, T1>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8, arg2.autocompounding_on, arg9, arg10);
        0x2::balance::join<T0>(&mut arg2.fee_balance_a, v0);
        0x2::balance::join<T1>(&mut arg2.fee_balance_b, v1);
        arg2.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg2.investor, arg5, arg7, arg9, arg10);
    }

    entry fun set_minimum_swap_amount<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::set_minimum_swap_amount<T0, T1>(&mut arg2.investor, arg3);
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::set_performance_fee<T0, T1>(&mut arg2.investor, arg3);
    }

    entry fun set_safe_borrow_percentage<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::set_safe_borrow_percentage<T0, T1>(&mut arg2.investor, arg3);
    }

    public fun user_emergency_withdraw<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<T0, T1>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        if (arg2.owner != 0x2::tx_context::sender(arg8)) {
            0x2::transfer::public_transfer<Receipt>(arg2, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg6));
            if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&arg3)) {
                0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg8));
            };
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            return (0x2::coin::zero<T0>(arg8), 0x2::coin::zero<T1>(arg8))
        };
        assert!(0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::is_emergency<T0, T1>(&arg5.investor) && arg5.is_withdraw_paused, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert_receipt<T0, T1>(&arg2, arg5);
        get_pool_rewards_all<T0, T1>(arg5, arg1, arg6, arg7, arg8);
        let v0 = arg2.xTokenBalance;
        let (v1, v2) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::user_emergency_withdraw<T0, T1>(&mut arg5.investor, v0, arg5.xTokenSupply);
        let v3 = v2;
        let v4 = v1;
        arg5.xTokenSupply = arg5.xTokenSupply - v0;
        arg2.xTokenBalance = arg2.xTokenBalance - v0;
        let v5 = (0x2::balance::value<T0>(&v4) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        let v6 = (0x2::balance::value<T1>(&v3) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg5.fee_balance_a, 0x2::balance::split<T0>(&mut v4, (v5 as u64)));
        0x2::balance::join<T1>(&mut arg5.fee_balance_b, 0x2::balance::split<T1>(&mut v3, (v6 as u64)));
        let (v7, v8) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_emergency_balances<T0, T1>(&arg5.investor);
        let v9 = EmergencyWithdrawEvent{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg5),
            total_balance_a : v7,
            total_balance_b : v8,
            xtokenSupply    : arg5.xTokenSupply,
            fee_collected_a : (v5 as u64),
            fee_collected_b : (v6 as u64),
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v9);
        destroy_receipt_and_transfer_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg7, arg8);
        (0x2::coin::from_balance<T0>(v4, arg8), 0x2::coin::from_balance<T1>(v3, arg8))
    }

    public fun withdraw<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<T0, T1>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: u128, arg8: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<Receipt>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        if (arg2.owner != 0x2::tx_context::sender(arg13)) {
            0x2::transfer::public_transfer<Receipt>(arg2, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg6));
            if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&arg3)) {
                0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg13));
            };
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            return (0x1::option::none<Receipt>(), 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        assert!(arg5.is_withdraw_paused == false && 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::is_emergency<T0, T1>(&arg5.investor) == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert_receipt<T0, T1>(&arg2, arg5);
        assert!(arg7 <= arg2.xTokenBalance, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        update_pool<T0, T1>(arg0, arg5, arg8, arg9, arg10, arg11, arg12, arg13);
        get_pool_rewards_all<T0, T1>(arg5, arg1, arg6, arg12, arg13);
        let v0 = &mut arg2;
        update_user_rewards<T0, T1>(v0, arg5);
        let (v1, v2) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::withdraw<T0, T1>(&mut arg5.investor, arg7, arg5.xTokenSupply, arg8, arg9, arg10, arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        arg5.xTokenSupply = arg5.xTokenSupply - arg7;
        arg2.xTokenBalance = arg2.xTokenBalance - arg7;
        arg5.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg5.investor, arg8, arg10, arg12, arg13);
        let v5 = (0x2::balance::value<T0>(&v4) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        let v6 = (0x2::balance::value<T1>(&v3) as u128) * (arg5.withdrawal_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg5.fee_balance_a, 0x2::balance::split<T0>(&mut v4, (v5 as u64)));
        0x2::balance::join<T1>(&mut arg5.fee_balance_b, 0x2::balance::split<T1>(&mut v3, (v6 as u64)));
        let (v7, v8) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_amounts_outer<T0, T1>(&arg5.investor, arg8, arg10, arg12, arg13);
        let v9 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg5.id),
            event_type                 : 1,
            total_amount_a             : v7,
            total_amount_b             : v8,
            fee_collected_a            : (v5 as u64),
            fee_collected_b            : (v6 as u64),
            amount_a                   : 0x2::balance::value<T0>(&v4),
            amount_b                   : 0x2::balance::value<T1>(&v3),
            user_total_x_token_balance : arg2.xTokenBalance,
            x_token_supply             : arg5.xTokenSupply,
            tokens_invested            : arg5.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<LiquidityChangeEvent>(v9);
        if (arg2.xTokenBalance == 0) {
            destroy_receipt_and_transfer_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg4, arg6, arg12, arg13);
            (0x1::option::none<Receipt>(), v4, v3)
        } else {
            if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&arg3) == true) {
                0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut arg3), 0x2::tx_context::sender(arg13));
            };
            0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(arg3);
            (0x1::option::some<Receipt>(arg2), v4, v3)
        }
    }

    fun add_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(*v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T2>(&arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg0.xTokenSupply)));
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T2>(&arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg0.xTokenSupply)));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, arg1);
        };
    }

    fun assert_receipt<T0, T1>(arg0: &Receipt, arg1: &Pool<T0, T1>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::invalid_receipt_error());
    }

    entry fun collect_fee<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fee_balance_a), arg2), arg1.fee_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.fee_balance_b), arg2), arg1.fee_address);
    }

    public fun create_pool<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: u32, arg5: u32, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        let v0 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg15),
            name                   : arg2,
            image_url              : arg3,
            xTokenSupply           : 0,
            tokensInvested         : 0,
            rewards                : 0x2::bag::new(arg15),
            acc_rewards_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(),
            fee_balance_a          : 0x2::balance::zero<T0>(),
            fee_balance_b          : 0x2::balance::zero<T1>(),
            fee_address            : arg13,
            deposit_fee            : 0,
            deposit_fee_max_cap    : 100,
            withdrawal_fee         : 0,
            withdraw_fee_max_cap   : 100,
            autocompounding_on     : true,
            is_deposit_paused      : false,
            is_withdraw_paused     : false,
            investor               : 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::create_investor<T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15),
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
    }

    fun destroy_receipt_and_transfer_rewards<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<T0, T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.xTokenBalance == 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::receipt_not_empty());
        let v0 = &mut arg2;
        let v1 = get_user_rewards_all<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8);
        let Receipt {
            id                         : v2,
            owner                      : _,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : _,
            pending_rewards            : _,
        } = arg2;
        0x2::object::delete(v2);
        if (0x1::option::is_some<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&v1) == true) {
            0x2::transfer::public_transfer<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(0x1::option::extract<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(&mut v1), 0x2::tx_context::sender(arg8));
        };
        0x1::option::destroy_none<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>(v1);
    }

    fun exchange_rate<T0, T1>(arg0: &Pool<T0, T1>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg0.xTokenSupply))
        }
    }

    fun get_pool_rewards_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        get_rewards<T0, T1, 0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg0, arg1, arg2, arg3, arg4);
    }

    fun get_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0));
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, 0x2::balance::zero<T2>());
            };
            return
        };
        let v1 = Witness{dummy_field: false};
        let v2 = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_rewards_<T2, Witness>(arg2, arg1, 0x2::object::uid_to_inner(&arg0.id), arg3, v1, arg4);
        let v3 = RewardEvent{
            coin_type : 0x1::type_name::with_defining_ids<T2>(),
            amount    : 0x2::balance::value<T2>(&v2),
            sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardEvent>(v3);
        add_rewards<T0, T1, T2>(arg0, v2);
    }

    fun get_user_rewards<T0, T1, T2>(arg0: &mut Receipt, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        get_rewards<T0, T1, T2>(arg2, arg1, arg3, arg4, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        update_pending_rewards<T0, T1>(arg0, arg2, v0);
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &v0);
        let v2 = *v1;
        *v1 = 0;
        let v3 = UserRewardEvent{
            coin_type : 0x1::type_name::with_defining_ids<T2>(),
            amount    : v2,
            sender    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UserRewardEvent>(v3);
        0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg2.rewards, v0), (v2 as u64))
    }

    public fun get_user_rewards_all<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<T0, T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt> {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        stake_all_alpha_to_alpha_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg5, arg7, arg8)
    }

    fun init(arg0: ALPHAFI_LYF_POOL, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<ALPHAFI_LYF_POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun set_autocompounding_on<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: bool) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        assert!(!0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::is_emergency<T0, T1>(&arg2.investor), 1003);
        assert!(arg2.autocompounding_on != arg3, 1001);
        arg2.autocompounding_on = arg3;
    }

    entry fun set_deposit_fee<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: bool, arg4: bool) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        assert!(!0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::is_emergency<T0, T1>(&arg2.investor) || arg4, 1000);
        if (arg3) {
            assert!(arg2.is_withdraw_paused != arg4, 1001);
            arg2.is_withdraw_paused = arg4;
            if (arg4) {
                arg2.is_deposit_paused = arg4;
            };
        } else {
            assert!(arg2.is_deposit_paused != arg4, 1001);
            assert!(arg2.is_withdraw_paused == false, 1002);
            arg2.is_deposit_paused = arg4;
        };
    }

    entry fun set_withdrawal_fee<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    fun stake_all_alpha_to_alpha_pool<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: &mut Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut Pool<T0, T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt> {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        let v0 = get_user_rewards<T0, T1, 0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg2, arg1, arg4, arg5, arg7, arg8);
        if (0x2::balance::value<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(&v0) > 0) {
            0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::deposit<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(arg1, arg3, arg6, arg5, 0x2::coin::from_balance<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(v0, arg8), arg7, arg8)
        } else {
            0x2::balance::destroy_zero<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>(v0);
            arg3
        }
    }

    fun update_pending_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0, T1>, arg2: 0x1::type_name::TypeName) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, arg2) == true) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg1.acc_rewards_per_xtoken, &arg2);
            let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg0.last_acc_reward_per_xtoken, &arg2) == true) {
                let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.last_acc_reward_per_xtoken, &arg2);
                *v2 = *v0;
                *v2
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.last_acc_reward_per_xtoken, arg2, *v0);
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
            };
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, &arg2) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &arg2);
                *v3 = *v3 + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(*v0, v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg0.xTokenBalance)));
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, arg2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(*v0, v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg0.xTokenBalance))));
            };
        };
    }

    public fun update_pool<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &mut Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        let (v0, v1) = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::autocompound<T0, T1>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg1.autocompounding_on, arg6, arg7);
        0x2::balance::join<T0>(&mut arg1.fee_balance_a, v0);
        0x2::balance::join<T1>(&mut arg1.fee_balance_b, v1);
        arg1.tokensInvested = 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor::get_total_liquidity<T0, T1>(&arg1.investor, arg2, arg4, arg6, arg7);
    }

    fun update_user_rewards<T0, T1>(arg0: &mut Receipt, arg1: &mut Pool<T0, T1>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg1.acc_rewards_per_xtoken)) {
            let (v1, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg1.acc_rewards_per_xtoken, v0);
            update_pending_rewards<T0, T1>(arg0, arg1, *v1);
            v0 = v0 + 1;
        };
    }

    public fun user_deposit<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: 0x1::option::Option<Receipt>, arg3: &mut Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg12));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0, T1>(arg0: &0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::Version, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::version::Version, arg2: Receipt, arg3: 0x1::option::Option<0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Receipt>, arg4: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::alphapool::Pool<0xfe3afec26c59e874f3c1d60b8203cb3852d2bb2aa415df9548b8d688e6683f93::alpha::ALPHA>, arg5: &mut Pool<T0, T1>, arg6: u128, arg7: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg8: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::version::assert_current_version(arg0);
        let (v0, v1, v2) = withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg6, arg8, arg9, arg10, arg11, arg12, arg13);
        let v3 = v0;
        if (0x1::option::is_some<Receipt>(&v3) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v3), 0x2::tx_context::sender(arg13));
        };
        0x1::option::destroy_none<Receipt>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg13), 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg13), 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

