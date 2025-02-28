module 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pool {
    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        index: u64,
        pools: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        is_pause: bool,
        clmm_vault: 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::ClmmVault,
        lp_token_treasury: 0x2::coin::TreasuryCap<T0>,
        buffer_assets: 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::BalanceBag,
        protocol_fees: 0x2::bag::Bag,
        hard_cap: u128,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        status: Status,
    }

    struct Status has store {
        last_aum: u128,
        last_calculate_aum_tx: vector<u8>,
        last_deposit_tx: vector<u8>,
        last_withdraw_tx: vector<u8>,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        lower_offset: u32,
        upper_offset: u32,
        rebalance_threshold: u32,
        lp_token_treasury: 0x2::object::ID,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        hard_cap: u128,
    }

    struct InitEvent has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct PauseEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct UnpauseEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct UpdateHardCapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_hard_cap: u128,
        new_hard_cap: u128,
    }

    struct WithdrawBufferRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        before_aum: u128,
        user_tvl: u128,
        before_supply: u64,
        lp_amount: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct FlashLoanEvent has copy, drop {
        pool_id: 0x2::object::ID,
        loan_type: 0x1::type_name::TypeName,
        repay_type: 0x1::type_name::TypeName,
        loan_amount: u64,
        repay_amount: u64,
        base_to_quote_price: u64,
        base_price: u64,
        quote_price: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        pool_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct FeeClaimedEvent has copy, drop {
        amount_a: u64,
        amount_b: u64,
        pool_id: 0x2::object::ID,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct RewardClaimedEvent has copy, drop {
        amount: u64,
        reward_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
        lp_supply: u64,
    }

    struct RebalanceEvent has copy, drop {
        pool_id: 0x2::object::ID,
        data: 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::MigrateLiquidity,
    }

    struct UpdateLiquidityOffsetEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_lower_offset: u32,
        old_upper_offset: u32,
        new_lower_offset: u32,
        new_upper_offset: u32,
    }

    struct UpdateRebalanceThresholdEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_rebalance_threshold: u32,
        new_rebalance_threshold: u32,
    }

    struct FlashLoanCert {
        pool_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct WithdrawCert {
        pool_id: 0x2::object::ID,
        rewards_amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public fun collect_fee<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::pool_id(&arg0.clmm_vault), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::clmm_pool_not_match());
        let (v0, v1) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::collect_fee<T0, T1>(&arg0.clmm_vault, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        merge_protocol_asset<T2, T0>(arg0, arg1, v4);
        let v5 = &mut v2;
        merge_protocol_asset<T2, T1>(arg0, arg1, v5);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T0>(&mut arg0.buffer_assets, v3);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T1>(&mut arg0.buffer_assets, v2);
        let v6 = FeeClaimedEvent{
            amount_a : 0x2::balance::value<T0>(&v3),
            amount_b : 0x2::balance::value<T1>(&v2),
            pool_id  : 0x2::object::id<Pool<T2>>(arg0),
        };
        0x2::event::emit<FeeClaimedEvent>(v6);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::pool_id(&arg0.clmm_vault), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::clmm_pool_not_match());
        let v0 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::collect_reward<T0, T1, T3>(&arg0.clmm_vault, arg2, arg3, arg4, arg5);
        let v1 = &mut v0;
        merge_protocol_asset<T2, T3>(arg0, arg1, v1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T3>(&mut arg0.buffer_assets, v0);
        let v2 = RewardClaimedEvent{
            amount      : 0x2::balance::value<T3>(&v0),
            reward_type : 0x1::type_name::get<T3>(),
            pool_id     : 0x2::object::id<Pool<T2>>(arg0),
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::PythOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_rebalance_role(arg1, 0x2::tx_context::sender(arg6));
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::pool_id(&arg0.clmm_vault), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::clmm_pool_not_match());
        let (v0, v1, v2) = check_need_rebalance<T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_sqrt_price_from_oracle<T0, T1>(arg2, arg5), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::rebalance_threshold(&arg0.clmm_vault));
        assert!(v0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_not_need_rebalance());
        rebalance_internal<T0, T1, T2>(arg0, arg3, arg4, v1, v2, arg5, arg6);
    }

    public fun update_liquidity_offset<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::PythOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg8));
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        let (v0, v1, _) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::get_liquidity_range(&arg0.clmm_vault);
        assert!(arg5 != v0 || arg6 != v1, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::liquidity_range_not_change());
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::update_liquidity_offset(&mut arg0.clmm_vault, arg5, arg6);
        let (v3, v4, v5) = check_need_rebalance<T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_sqrt_price_from_oracle<T0, T1>(arg2, arg7), 1);
        if (v3) {
            rebalance_internal<T0, T1, T2>(arg0, arg3, arg4, v4, v5, arg7, arg8);
        };
        let v6 = UpdateLiquidityOffsetEvent{
            pool_id          : 0x2::object::id<Pool<T2>>(arg0),
            old_lower_offset : v0,
            old_upper_offset : v1,
            new_lower_offset : arg5,
            new_upper_offset : arg6,
        };
        0x2::event::emit<UpdateLiquidityOffsetEvent>(v6);
    }

    public fun update_rebalance_threshold<T0>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        let (_, _, v2) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::get_liquidity_range(&arg0.clmm_vault);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::update_rebalance_threshold(&mut arg0.clmm_vault, arg2);
        let v3 = UpdateRebalanceThresholdEvent{
            pool_id                 : 0x2::object::id<Pool<T0>>(arg0),
            old_rebalance_threshold : v2,
            new_rebalance_threshold : arg2,
        };
        0x2::event::emit<UpdateRebalanceThresholdEvent>(v3);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        let v0 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::withdraw_all<T0>(&mut arg0.buffer_assets);
        let v1 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::withdraw_all<T1>(&mut arg0.buffer_assets);
        let (v2, v3, v4) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::increase_liquidity<T0, T1>(&mut arg0.clmm_vault, arg2, arg3, &mut v0, &mut v1, arg4);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T0>(&mut arg0.buffer_assets, v0);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T1>(&mut arg0.buffer_assets, v1);
        let v5 = AddLiquidityEvent{
            pool_id            : 0x2::object::id<Pool<T2>>(arg0),
            amount_a           : v2,
            amount_b           : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
            lp_supply          : total_token_amount<T2>(arg0),
        };
        0x2::event::emit<AddLiquidityEvent>(v5);
    }

    public fun calculate_aum<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::PythOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::pool_id(&arg0.clmm_vault), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::clmm_pool_not_match());
        let v0 = *0x2::tx_context::digest(arg6);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::borrow_position(&arg0.clmm_vault));
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_fee<T0, T1>(arg3, arg4, v1);
        assert!(v2 == 0 && v3 == 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::fee_claim_err());
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_rewards<T0, T1>(arg3, arg4, v1, arg5);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v4)) {
            let v6 = 0;
            assert!(0x1::vector::borrow<u64>(&v4, v5) == &v6, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::mining_claim_err());
            v5 = v5 + 1;
        };
        let (v7, v8) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::liquidity_value<T0, T1>(&arg0.clmm_vault, arg4);
        let v9 = 0;
        let v10 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>();
        let v11 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v12 = *0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::balances(&arg0.buffer_assets);
        while (v9 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v12)) {
            let (v13, v14) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v12, v9);
            let v15 = *v13;
            let v16 = *v14;
            let v17 = v16;
            if (0x1::type_name::get<T0>() == v15) {
                v17 = v16 + v7;
            } else if (0x1::type_name::get<T1>() == v15) {
                v17 = v16 + v8;
            };
            if (!0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::contain_oracle_info(arg2, v15) || v17 == 0) {
                v9 = v9 + 1;
                continue
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(&mut v10, v15, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_price_by_type(arg2, v15, arg5));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v11, v15, v17);
            v9 = v9 + 1;
        };
        arg0.status.last_aum = calculate_tvl_base_on_quote(&v11, &v10, arg0.quote_type);
        assert!(v0 != arg0.status.last_calculate_aum_tx, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::operation_not_allowed());
        arg0.status.last_calculate_aum_tx = v0;
    }

    fun calculate_tvl_base_on_quote(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>, arg2: 0x1::option::Option<0x1::type_name::TypeName>) : u128 {
        assert!(0x2::vec_map::size<0x1::type_name::TypeName, u64>(arg0) == 0x2::vec_map::size<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(arg1), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::assets_and_prices_size_not_match());
        if (0x2::vec_map::size<0x1::type_name::TypeName, u64>(arg0) == 0) {
            return 0
        };
        let v0 = if (0x1::option::is_none<0x1::type_name::TypeName>(&arg2)) {
            0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::new_price(1 * 0x1::u64::pow(10, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::oracle_price_multiplier_decimal()), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::oracle_price_multiplier_decimal())
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(arg1, 0x1::option::borrow<0x1::type_name::TypeName>(&arg2))
        };
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(arg0)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(arg0, v3);
            assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(arg1, v4), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::price_err());
            let (_, v7) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::calculate_prices(&v1, 0x2::vec_map::get<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(arg1, v4));
            v2 = v2 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v7 as u128), (*v5 as u128), (0x1::u64::pow(10, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::oracle_price_multiplier_decimal()) as u128));
            v3 = v3 + 1;
        };
        v2
    }

    fun check_need_rebalance<T0>(arg0: &Pool<T0>, arg1: u32, arg2: u128, arg3: u32) : (bool, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let (v0, v1, _) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::get_liquidity_range(&arg0.clmm_vault);
        let (v3, v4) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::next_position_range(v0, v1, arg1, arg2);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::borrow_position(&arg0.clmm_vault));
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v4, v5) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v3, v6)) {
            return (true, v3, v4)
        };
        let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, v5)) >= arg3 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v4, v6)) >= arg3;
        (v7, v3, v4)
    }

    public fun claim_protocol_fee<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_protocol_fee_claim_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = take_protocol_asset<T0, T1>(arg0);
        let v1 = ClaimProtocolFeeEvent{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            amount    : 0x2::balance::value<T1>(&v0),
            type_name : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
        0x2::coin::from_balance<T1>(v0, arg2)
    }

    public fun create_pool<T0, T1, T2>(arg0: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg1: &mut PoolRegistry, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u32, arg8: u8, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg0);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg10));
        assert!(0x2::coin::total_supply<T2>(&arg2) == 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::treasury_cap_illegal());
        let v0 = if (arg8 == 0) {
            true
        } else if (arg8 == 1) {
            true
        } else {
            arg8 == 2
        };
        assert!(v0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::quote_type_error());
        let v1 = if (arg8 == 0) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>())
        } else if (arg8 == 1) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>())
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        };
        let v2 = Pool<T2>{
            id                : 0x2::object::new(arg10),
            is_pause          : false,
            clmm_vault        : 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::new<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg10),
            lp_token_treasury : arg2,
            buffer_assets     : 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::new_balance_bag(arg10),
            protocol_fees     : 0x2::bag::new(arg10),
            hard_cap          : arg9,
            quote_type        : v1,
            status            : new_status(),
        };
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T0>(&mut v2.buffer_assets, 0x2::balance::zero<T0>());
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T1>(&mut v2.buffer_assets, 0x2::balance::zero<T1>());
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.pools, 0x2::object::id<Pool<T2>>(&v2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        let v3 = CreateEvent{
            id                  : 0x2::object::id<Pool<T2>>(&v2),
            clmm_pool           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            lower_offset        : arg5,
            upper_offset        : arg6,
            rebalance_threshold : arg7,
            lp_token_treasury   : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg2),
            quote_type          : v1,
            hard_cap            : arg9,
        };
        0x2::event::emit<CreateEvent>(v3);
        0x2::transfer::share_object<Pool<T2>>(v2);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::PythOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::coin::value<T1>(&arg6);
        assert!(v0 > 0 || v1 > 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::token_amount_is_zero());
        let v2 = *0x2::tx_context::digest(arg8);
        assert!(v2 == arg0.status.last_calculate_aum_tx, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::aum_done_err());
        assert!(v2 != arg0.status.last_deposit_tx, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::operation_not_allowed());
        assert!(v2 != arg0.status.last_withdraw_tx, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::operation_not_allowed());
        arg0.status.last_deposit_tx = v2;
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, 0x1::type_name::get<T0>(), v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, 0x1::type_name::get<T1>(), v1);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(&mut v4, 0x1::type_name::get<T0>(), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_price<T0>(arg2, arg7));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::Price>(&mut v4, 0x1::type_name::get<T1>(), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_price<T1>(arg2, arg7));
        let v5 = calculate_tvl_base_on_quote(&v3, &v4, arg0.quote_type);
        let v6 = total_token_amount<T2>(arg0);
        if (arg0.hard_cap != 0) {
            assert!(arg0.status.last_aum + v5 <= arg0.hard_cap, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::hard_cap_reached());
        };
        let v7 = get_lp_amount_by_tvl(v6, v5, arg0.status.last_aum);
        assert!(v7 > 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::token_amount_is_zero());
        assert!(v7 < 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::uint64_max() - 1 - (v6 as u128), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::token_amount_overflow());
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T0>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T0>(arg5));
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(arg6));
        let v8 = DepositEvent{
            pool_id       : 0x2::object::id<Pool<T2>>(arg0),
            before_aum    : arg0.status.last_aum,
            user_tvl      : v5,
            before_supply : v6,
            lp_amount     : (v7 as u64),
            amount_a      : v0,
            amount_b      : v1,
        };
        0x2::event::emit<DepositEvent>(v8);
        arg0.status.last_aum = arg0.status.last_aum + v5;
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::send_coin<T2>(0x2::coin::mint<T2>(&mut arg0.lp_token_treasury, (v7 as u64), arg8), 0x2::tx_context::sender(arg8));
        add_liquidity<T0, T1, T2>(arg0, arg1, arg3, arg4, arg7);
    }

    public fun destory_withdraw_cert<T0>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: WithdrawCert) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        let WithdrawCert {
            pool_id         : v0,
            rewards_amounts : v1,
        } = arg2;
        let v2 = v1;
        assert!(v0 == 0x2::object::id<Pool<T0>>(arg0), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::withdraw_cert_pool_id_not_match());
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&v2), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::remove_assets_not_empty());
    }

    public fun flash_loan<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::PythOracle, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanCert) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(arg3 > 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::token_amount_is_zero());
        let v0 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_price<T0>(arg2, arg4);
        let v1 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::get_price<T1>(arg2, arg4);
        let (v2, _) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::calculate_prices(&v0, &v1);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v2, arg3, 0x1::u64::pow(10, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::oracle_price_multiplier_decimal())), 10000 - (0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::get_swap_slippage<T0>(arg1) + 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::get_swap_slippage<T1>(arg1)) / 2, 10000);
        let v5 = 0x1::type_name::get<T1>();
        let (v6, v7) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::coin_types(&arg0.clmm_vault);
        assert!(v5 == v6 || v5 == v7, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::incorrect_repay());
        let v8 = FlashLoanCert{
            pool_id      : 0x2::object::id<Pool<T2>>(arg0),
            repay_type   : v5,
            repay_amount : v4,
        };
        let v9 = FlashLoanEvent{
            pool_id             : 0x2::object::id<Pool<T2>>(arg0),
            loan_type           : 0x1::type_name::get<T0>(),
            repay_type          : v5,
            loan_amount         : arg3,
            repay_amount        : v4,
            base_to_quote_price : v2,
            base_price          : 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::price_value(&v0),
            quote_price         : 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::pyth_oracle::price_value(&v1),
        };
        0x2::event::emit<FlashLoanEvent>(v9);
        (0x2::coin::from_balance<T0>(0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::split<T0>(&mut arg0.buffer_assets, arg3), arg5), v8)
    }

    fun get_lp_amount_by_tvl(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg0 as u128), arg1, arg2)
    }

    fun get_user_share_by_lp_amount(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg1 as u128), arg2, (arg0 as u128))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg0),
            index : 0,
            pools : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        let v1 = InitEvent{registry_id: 0x2::object::id<PoolRegistry>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun merge_protocol_asset<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &mut 0x2::balance::Balance<T1>) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::add_balance_to_bag<T1>(&mut arg0.protocol_fees, 0x2::balance::split<T1>(arg2, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::calculate_fee_amount(arg1, 0x2::balance::value<T1>(arg2))));
    }

    fun new_status() : Status {
        Status{
            last_aum              : 0,
            last_calculate_aum_tx : 0x1::vector::empty<u8>(),
            last_deposit_tx       : 0x1::vector::empty<u8>(),
            last_withdraw_tx      : 0x1::vector::empty<u8>(),
        }
    }

    public fun pause<T0>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = true;
        let v0 = PauseEvent{pool_id: 0x2::object::id<Pool<T0>>(arg0)};
        0x2::event::emit<PauseEvent>(v0);
    }

    fun rebalance_internal<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::rebalance<T0, T1>(&mut arg0.clmm_vault, arg1, arg2, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::withdraw_all<T0>(&mut arg0.buffer_assets), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::withdraw_all<T1>(&mut arg0.buffer_assets), arg3, arg4, arg5, arg6);
        let v3 = RebalanceEvent{
            pool_id : 0x2::object::id<Pool<T2>>(arg0),
            data    : v2,
        };
        0x2::event::emit<RebalanceEvent>(v3);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T0>(&mut arg0.buffer_assets, v0);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T1>(&mut arg0.buffer_assets, v1);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: FlashLoanCert, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_operation_role(arg1, 0x2::tx_context::sender(arg4));
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        let FlashLoanCert {
            pool_id      : v0,
            repay_type   : v1,
            repay_amount : v2,
        } = arg2;
        assert!(0x1::type_name::get<T1>() == v1, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::incorrect_repay());
        assert!(0x2::coin::value<T1>(&arg3) >= v2, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::incorrect_repay());
        assert!(0x2::object::id<Pool<T0>>(arg0) == v0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::incorrect_repay());
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::join<T1>(&mut arg0.buffer_assets, 0x2::coin::into_balance<T1>(arg3));
        let v3 = RepayFlashLoanEvent{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            repay_type   : v1,
            repay_amount : 0x2::coin::value<T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v3);
    }

    fun take_protocol_asset<T0, T1>(arg0: &mut Pool<T0>) : 0x2::balance::Balance<T1> {
        let (v0, _) = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::utils::remove_balance_from_bag<T1>(&mut arg0.protocol_fees, 0, true);
        v0
    }

    public fun total_token_amount<T0>(arg0: &Pool<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_token_treasury)
    }

    public fun unpause<T0>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = false;
        let v0 = UnpauseEvent{pool_id: 0x2::object::id<Pool<T0>>(arg0)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_hard_cap<T0>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        arg0.hard_cap = arg2;
        let v0 = UpdateHardCapEvent{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            old_hard_cap : arg0.hard_cap,
            new_hard_cap : arg2,
        };
        0x2::event::emit<UpdateHardCapEvent>(v0);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Pool<T2>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, WithdrawCert) {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::pool_id(&arg0.clmm_vault), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::clmm_pool_not_match());
        let v0 = 0x2::coin::value<T2>(&arg4);
        assert!(v0 > 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::token_amount_is_zero());
        let v1 = *0x2::tx_context::digest(arg6);
        assert!(v1 != arg0.status.last_deposit_tx, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::operation_not_allowed());
        assert!(v1 != arg0.status.last_withdraw_tx, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::operation_not_allowed());
        arg0.status.last_withdraw_tx = v1;
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::borrow_position(&arg0.clmm_vault));
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_fee<T0, T1>(arg2, arg3, v2);
        assert!(v3 == 0 && v4 == 0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::fee_claim_err());
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_rewards<T0, T1>(arg2, arg3, v2, arg5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let v7 = 0;
            assert!(0x1::vector::borrow<u64>(&v5, v6) == &v7, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::mining_claim_err());
            v6 = v6 + 1;
        };
        let v8 = total_token_amount<T2>(arg0);
        let v9 = *0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::balances(&arg0.buffer_assets);
        let v10 = 0x1::type_name::get<T0>();
        let (_, v12) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v9, &v10);
        let v13 = 0x1::type_name::get<T1>();
        let (_, v15) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v9, &v13);
        let v16 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::split<T0>(&mut arg0.buffer_assets, (get_user_share_by_lp_amount(v8, v0, (v12 as u128)) as u64));
        let v17 = 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::split<T1>(&mut arg0.buffer_assets, (get_user_share_by_lp_amount(v8, v0, (v15 as u128)) as u64));
        let v18 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v19 = 0;
        while (v19 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v9)) {
            let (v20, v21) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v9, v19);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v18, *v20, (get_user_share_by_lp_amount(v8, v0, (*v21 as u128)) as u64));
            v19 = v19 + 1;
        };
        let v22 = WithdrawCert{
            pool_id         : 0x2::object::id<Pool<T2>>(arg0),
            rewards_amounts : v18,
        };
        let v23 = get_user_share_by_lp_amount(v8, v0, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::get_position_liquidity(&arg0.clmm_vault));
        let (v24, v25) = if (v23 > 0) {
            0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::clmm_vault::decrease_liquidity<T0, T1>(&mut arg0.clmm_vault, arg2, arg3, v23, arg5)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x2::balance::join<T0>(&mut v16, v24);
        0x2::balance::join<T1>(&mut v17, v25);
        let v26 = WithdrawEvent{
            pool_id   : 0x2::object::id<Pool<T2>>(arg0),
            lp_amount : v0,
            liquidity : v23,
            amount_a  : 0x2::balance::value<T0>(&v16),
            amount_b  : 0x2::balance::value<T1>(&v17),
        };
        0x2::event::emit<WithdrawEvent>(v26);
        0x2::coin::burn<T2>(&mut arg0.lp_token_treasury, arg4);
        (0x2::coin::from_balance<T0>(v16, arg6), 0x2::coin::from_balance<T1>(v17, arg6), v22)
    }

    public fun withdraw_buffer_reward<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::GlobalConfig, arg2: &mut WithdrawCert, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::config::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::pool_is_pause());
        assert!(arg2.pool_id == 0x2::object::id<Pool<T0>>(arg0), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::withdraw_cert_pool_id_not_match());
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg2.rewards_amounts, &v0), 0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::error::withdraw_cert_not_match());
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg2.rewards_amounts, &v0);
        let v3 = WithdrawBufferRewardEvent{
            pool_id    : 0x2::object::id<Pool<T0>>(arg0),
            asset_type : v0,
            amount     : v2,
        };
        0x2::event::emit<WithdrawBufferRewardEvent>(v3);
        0x2::coin::from_balance<T1>(0xa8f53daca95428bf9f07c30629ce4ca4d993de2f85030fb0668a19c2de644743::balance_bag::split<T1>(&mut arg0.buffer_assets, v2), arg3)
    }

    // decompiled from Move bytecode v6
}

