module 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_pool {
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

    struct ALPHAFI_BLUEFIN_TYPE_1_POOL has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct UserRewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct AfterTransactionEvent has copy, drop {
        tokensInvested: u128,
        xtokenSupply: u128,
        liquidity: u128,
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

    public fun collect_and_swap_trade_fee<T0, T1, T2>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg5: &0x2::clock::Clock) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::collect_and_swap_trade_fee<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        abort 0
    }

    public fun user_emergency_withdraw<T0, T1, T2>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: Receipt, arg2: &mut Pool<T0, T1>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        if (arg1.owner != 0x2::tx_context::sender(arg5)) {
            0x2::transfer::public_transfer<Receipt>(arg1, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg3));
            return
        };
        assert!(arg2.paused == true, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert_receipt<T0, T1>(&arg1, arg2);
        let v0 = arg1.xTokenBalance;
        let (v1, v2) = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::user_emergency_withdraw<T0, T1>(arg4, v0, arg2.xTokenSupply);
        let v3 = v2;
        let v4 = v1;
        arg2.xTokenSupply = arg2.xTokenSupply - v0;
        arg1.xTokenBalance = arg1.xTokenBalance - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, (((0x2::balance::value<T0>(&v4) as u128) * (arg2.withdrawal_fee as u128) / 10000) as u64)), arg5), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, (((0x2::balance::value<T1>(&v3) as u128) * (arg2.withdrawal_fee as u128) / 10000) as u64)), arg5), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg5), 0x2::tx_context::sender(arg5));
        let v5 = AfterTransactionEvent{
            tokensInvested : arg2.tokensInvested,
            xtokenSupply   : arg2.xTokenSupply,
            liquidity      : 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_total_liquidity<T0, T1>(arg4),
        };
        0x2::event::emit<AfterTransactionEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(destroy_receipt_and_transfer_rewards<T0, T1, T2>(arg1, arg2, arg5), arg5), 0x2::tx_context::sender(arg5));
    }

    public fun withdraw<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: Receipt, arg2: &mut Pool<T0, T1>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg5: u128, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        abort 0
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
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::invalid_receipt_error());
    }

    public fun create<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg1);
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

    public fun deposit_v2<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg13: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            if (0x1::option::borrow<Receipt>(&arg1).owner != 0x2::tx_context::sender(arg16)) {
                0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut arg1), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg5));
                0x1::option::destroy_none<Receipt>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg16));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg16));
                return 0x1::option::none<Receipt>()
            };
        };
        assert!(arg2.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg3) > 0 || 0x2::coin::value<T1>(&arg4) > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::zero_deposit_error());
        update_pool_v2<T0, T1, T2, T3>(arg0, arg2, arg6, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        if (0x1::option::is_some<Receipt>(&arg1) == true) {
            assert_receipt<T0, T1>(0x1::option::borrow_mut<Receipt>(&mut arg1), arg2);
        };
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = (0x2::balance::value<T0>(&v0) as u128) * (arg2.deposit_fee as u128) / 10000;
        let v3 = (0x2::balance::value<T1>(&v1) as u128) * (arg2.deposit_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, (v2 as u64)), arg16), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v1, (v3 as u64)), arg16), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg5));
        let (_, v5, v6, v7) = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_balances_in_ratio<T0, T1>(arg6, v0, v1, arg9, false, arg16);
        let v8 = v6;
        let v9 = v5;
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::deposit<T0, T1>(arg6, arg7, arg9, v9, v8, v7, arg15);
        arg2.tokensInvested = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_total_liquidity<T0, T1>(arg6);
        let v10 = ((arg2.tokensInvested - arg2.tokensInvested) as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate<T0, T1>(arg2);
        assert!(v10 > 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_deposit_amount());
        arg2.xTokenSupply = arg2.xTokenSupply + (v10 as u128);
        let v11 = if (0x1::option::is_some<Receipt>(&arg1) == true) {
            let v12 = 0x1::option::extract<Receipt>(&mut arg1);
            let v13 = &mut v12;
            update_user_rewards<T0, T1, T2>(v13, arg2);
            v12.xTokenBalance = v12.xTokenBalance + (v10 as u128);
            v12
        } else {
            let v14 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v15 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v16 = 0;
            while (v16 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg2.acc_rewards_per_xtoken)) {
                let (v17, v18) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg2.acc_rewards_per_xtoken, v16);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v14, *v17, *v18);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v15, *v17, 0);
                v16 = v16 + 1;
            };
            Receipt{id: 0x2::object::new(arg16), owner: 0x2::tx_context::sender(arg16), name: 0x1::string::utf8(arg2.name), image_url: 0x1::string::utf8(arg2.image_url), pool_id: 0x2::object::uid_to_inner(&arg2.id), xTokenBalance: (v10 as u128), last_acc_reward_per_xtoken: v14, pending_rewards: v15}
        };
        let v19 = v11;
        0x1::option::destroy_none<Receipt>(arg1);
        let (v20, v21) = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_amounts<T0, T1>(arg6, arg9);
        let v22 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg2.id),
            event_type                 : 0,
            total_amount_a             : v20,
            total_amount_b             : v21,
            fee_collected_a            : (v2 as u64),
            fee_collected_b            : (v3 as u64),
            amount_a                   : 0x2::balance::value<T0>(&v9),
            amount_b                   : 0x2::balance::value<T1>(&v8),
            user_total_x_token_balance : v19.xTokenBalance,
            x_token_supply             : arg2.xTokenSupply,
            tokens_invested            : arg2.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg16),
        };
        0x2::event::emit<LiquidityChangeEvent>(v22);
        0x1::option::some<Receipt>(v19)
    }

    fun destroy_receipt_and_transfer_rewards<T0, T1, T2>(arg0: Receipt, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(arg0.xTokenBalance == 0, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::receipt_not_empty());
        let v0 = &mut arg0;
        let Receipt {
            id                         : v1,
            owner                      : _,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : _,
            pending_rewards            : _,
        } = arg0;
        0x2::object::delete(v1);
        get_user_rewards_internal<T0, T1, T2>(v0, arg1, arg2)
    }

    fun distribute_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T2>();
        if (arg0.xTokenSupply == 0) {
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, 0x2::balance::zero<T2>());
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(arg2, arg3), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
            return
        };
        add_rewards<T0, T1, T2>(arg0, arg2);
    }

    fun exchange_rate<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000000000000000000000000000000 as u256)
        } else {
            (arg0.tokensInvested as u256) * (1000000000000000000000000000000000000 as u256) / (arg0.xTokenSupply as u256)
        }
    }

    public fun get_user_rewards<T0, T1, T2, T3>(arg0: &mut Receipt, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        abort 0
    }

    fun get_user_rewards_internal<T0, T1, T2>(arg0: &mut Receipt, arg1: &mut Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
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
            let v7 = (((*v2 - v3) * (arg0.xTokenBalance as u256) / (1000000000000000000000000000000000000 as u256)) as u64) + *v6;
            *v6 = 0;
            let v8 = UserRewardEvent{
                coin_type : 0x1::type_name::get<T2>(),
                amount    : v7,
                sender    : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<UserRewardEvent>(v8);
            0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.rewards, v0), (v7 as u64))
        } else {
            0x2::balance::zero<T2>()
        }
    }

    public fun get_user_rewards_v2<T0, T1, T2, T3>(arg0: &mut Receipt, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: &mut Pool<T0, T1>, arg3: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg11: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        update_pool_v2<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        get_user_rewards_internal<T0, T1, T2>(arg0, arg2, arg14)
    }

    fun init(arg0: ALPHAFI_BLUEFIN_TYPE_1_POOL, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<ALPHAFI_BLUEFIN_TYPE_1_POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun set_deposit_fee<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_investor_id<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: &mut Pool<T0, T1>, arg3: 0x2::object::ID) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, b"investor_id")) {
            0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(&mut arg2.id, b"investor_id");
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(&mut arg2.id, b"investor_id", arg3);
    }

    entry fun set_pause<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: &mut Pool<T0, T1>, arg3: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg4: bool) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg1);
        assert!(0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::is_emergency<T0, T1>(arg3) == false || arg2.paused == false, 10001);
        arg2.paused = arg4;
    }

    entry fun set_withdrawal_fee<T0, T1>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg2: &mut Pool<T0, T1>, arg3: u64) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    public fun update_pool<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: &mut Pool<T0, T1>, arg2: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg3: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_pool_v2<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: &mut Pool<T0, T1>, arg2: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg3: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg10: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"investor_id"), 54321);
        assert!(*0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg1.id, b"investor_id") == 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::investor_id<T0, T1>(arg2), 333);
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::free_balance_settle<T0, T1>(arg2, arg4, arg5, arg6, arg8, true, arg12, arg13);
        let v0 = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::autocompound<T0, T1, T2, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12, arg13);
        distribute_rewards<T0, T1, T2>(arg1, arg3, v0, arg13);
        arg1.tokensInvested = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_total_liquidity<T0, T1>(arg2);
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

    public fun user_deposit<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun user_deposit_v2<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: 0x1::option::Option<Receipt>, arg2: &mut Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg6: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg13: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        let v0 = deposit_v2<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg16));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun user_withdraw<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: Receipt, arg2: &mut Pool<T0, T1>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg5: u128, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun user_withdraw_v2<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: Receipt, arg2: &mut Pool<T0, T1>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg5: u128, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg12: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        let v0 = withdraw_v2<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        if (0x1::option::is_some<Receipt>(&v0) == true) {
            0x2::transfer::public_transfer<Receipt>(0x1::option::extract<Receipt>(&mut v0), 0x2::tx_context::sender(arg15));
        };
        0x1::option::destroy_none<Receipt>(v0);
    }

    public fun withdraw_v2<T0, T1, T2, T3>(arg0: &0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::Version, arg1: Receipt, arg2: &mut Pool<T0, T1>, arg3: &mut 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg4: &mut 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::Investor<T0, T1>, arg5: u128, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg12: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<Receipt> {
        0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::version::assert_current_version(arg0);
        if (arg1.owner != 0x2::tx_context::sender(arg15)) {
            0x2::transfer::public_transfer<Receipt>(arg1, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_onhold_receipts_wallet_address(arg3));
            return 0x1::option::none<Receipt>()
        };
        assert!(arg2.paused == false, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::pool_paused());
        assert_receipt<T0, T1>(&arg1, arg2);
        assert!(arg5 <= arg1.xTokenBalance, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_error());
        update_pool_v2<T0, T1, T2, T3>(arg0, arg2, arg4, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v0 = &mut arg1;
        update_user_rewards<T0, T1, T2>(v0, arg2);
        arg2.xTokenSupply = arg2.xTokenSupply - arg5;
        arg1.xTokenBalance = arg1.xTokenBalance - arg5;
        let (v1, v2) = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::withdraw<T0, T1>(arg4, (((arg5 as u256) * exchange_rate<T0, T1>(arg2) / (1000000000000000000000000000000000000 as u256)) as u128), arg6, arg8, arg14);
        let v3 = v2;
        let v4 = v1;
        arg2.tokensInvested = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_total_liquidity<T0, T1>(arg4);
        let v5 = (0x2::balance::value<T0>(&v4) as u128) * (arg2.withdrawal_fee as u128) / 10000;
        let v6 = (0x2::balance::value<T1>(&v3) as u128) * (arg2.withdrawal_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, (v5 as u64)), arg15), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, (v6 as u64)), arg15), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg15), 0x2::tx_context::sender(arg15));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg15), 0x2::tx_context::sender(arg15));
        let (v7, v8) = 0x754afbce8c72c8e491e3b9d536aa9d9766fdbc68650224ce01072189b235eee3::alphafi_bluefin_type_1_investor::get_amounts<T0, T1>(arg4, arg8);
        let v9 = LiquidityChangeEvent{
            pool_id                    : 0x2::object::uid_to_inner(&arg2.id),
            event_type                 : 1,
            total_amount_a             : v7,
            total_amount_b             : v8,
            fee_collected_a            : (v5 as u64),
            fee_collected_b            : (v6 as u64),
            amount_a                   : 0x2::balance::value<T0>(&v4),
            amount_b                   : 0x2::balance::value<T1>(&v3),
            user_total_x_token_balance : arg1.xTokenBalance,
            x_token_supply             : arg2.xTokenSupply,
            tokens_invested            : arg2.tokensInvested,
            sender                     : 0x2::tx_context::sender(arg15),
        };
        0x2::event::emit<LiquidityChangeEvent>(v9);
        if (arg1.xTokenBalance == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(destroy_receipt_and_transfer_rewards<T0, T1, T2>(arg1, arg2, arg15), arg15), 0x2::tx_context::sender(arg15));
            0x1::option::none<Receipt>()
        } else {
            0x1::option::some<Receipt>(arg1)
        }
    }

    // decompiled from Move bytecode v6
}

