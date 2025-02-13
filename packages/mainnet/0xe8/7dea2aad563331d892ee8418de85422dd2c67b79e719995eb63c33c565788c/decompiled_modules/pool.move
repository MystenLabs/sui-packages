module 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pool {
    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        index: u64,
        pools: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        aum: u128,
        is_pause: bool,
        clmm_vault: 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::ClmmVault,
        lp_token_treasury: 0x2::coin::TreasuryCap<T0>,
        buffer_assets: 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::BalanceBag,
        protocol_fees: 0x2::bag::Bag,
        hard_cap: u128,
        rebalance_slippage: u64,
        quote_type: 0x1::option::Option<0x1::type_name::TypeName>,
        status: Status,
    }

    struct Status has store {
        latest_claim_fee_tx: vector<u8>,
        latest_claim_rewards_tx: 0x2::vec_map::VecMap<u8, vector<u8>>,
        latest_calculate_aum_tx: vector<u8>,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
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

    struct UpdateRebalanceSlippageEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_slippage: u64,
        new_slippage: u64,
    }

    struct WithdrawBufferRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct UpdatePriceEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        last_update_time: u64,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        before_aum: u128,
        user_tvl: u128,
        before_supply: u64,
        lp_amount: u64,
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
        data: 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::MigrateLiquidity,
    }

    struct UpdateLiquidityRangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_min_tick: u32,
        old_max_tick: u32,
        old_lower_offset: u32,
        old_upper_offset: u32,
        old_rebalance_threshold: u32,
        new_min_tick: u32,
        new_max_tick: u32,
        new_lower_offset: u32,
        new_upper_offset: u32,
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

    public fun collect_fee<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::pool_id(&arg1.clmm_vault), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::clmm_pool_not_match());
        let (v0, v1) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::collect_fee<T0, T1>(&arg1.clmm_vault, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        merge_protocol_asset<T0, T2>(arg0, arg1, v4);
        let v5 = &mut v2;
        merge_protocol_asset<T1, T2>(arg0, arg1, v5);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T0>(&mut arg1.buffer_assets, v3);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T1>(&mut arg1.buffer_assets, v2);
        let v6 = FeeClaimedEvent{
            amount_a : 0x2::balance::value<T0>(&v3),
            amount_b : 0x2::balance::value<T1>(&v2),
            pool_id  : 0x2::object::id<Pool<T2>>(arg1),
        };
        0x2::event::emit<FeeClaimedEvent>(v6);
        arg1.status.latest_claim_fee_tx = *0x2::tx_context::digest(arg4);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::pool_id(&arg1.clmm_vault), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::clmm_pool_not_match());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg3));
        let v1 = 0x1::option::extract<u64>(&mut v0);
        let v2 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::collect_reward<T0, T1, T2>(&arg1.clmm_vault, arg2, arg3, arg4, arg5);
        let v3 = &mut v2;
        merge_protocol_asset<T2, T3>(arg0, arg1, v3);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T2>(&mut arg1.buffer_assets, v2);
        let v4 = RewardClaimedEvent{
            amount      : 0x2::balance::value<T2>(&v2),
            reward_type : 0x1::type_name::get<T2>(),
            pool_id     : 0x2::object::id<Pool<T3>>(arg1),
        };
        0x2::event::emit<RewardClaimedEvent>(v4);
        let v5 = (v1 as u8);
        if (!0x2::vec_map::contains<u8, vector<u8>>(&arg1.status.latest_claim_rewards_tx, &v5)) {
            0x2::vec_map::insert<u8, vector<u8>>(&mut arg1.status.latest_claim_rewards_tx, (v1 as u8), *0x2::tx_context::digest(arg6));
        } else {
            let v6 = (v1 as u8);
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut arg1.status.latest_claim_rewards_tx, &v6) = *0x2::tx_context::digest(arg6);
        };
    }

    public fun rebalance<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::PythOracle, arg2: &mut Pool<T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_rebalance_role(arg0, 0x2::tx_context::sender(arg6));
        assert!(!arg2.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::pool_id(&arg2.clmm_vault), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::clmm_pool_not_match());
        let v0 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price<T0>(arg1, arg5);
        let v1 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price<T1>(arg1, arg5);
        let (v2, _) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::calculate_prices(&v0, &v1);
        let v4 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::utils::price_to_sqrt_price(v2, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::price_coin_decimal(&v0), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::price_coin_decimal(&v1));
        assert!(check_need_rebalance<T2>(arg2, v4), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_not_need_rebalance());
        let (v5, v6, v7) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::rebalance<T0, T1>(&mut arg2.clmm_vault, arg3, arg4, v4, arg5, arg6);
        let v8 = RebalanceEvent{
            pool_id : 0x2::object::id<Pool<T2>>(arg2),
            data    : v7,
        };
        0x2::event::emit<RebalanceEvent>(v8);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T0>(&mut arg2.buffer_assets, v5);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T1>(&mut arg2.buffer_assets, v6);
    }

    public fun update_liquidity_range<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T0>, arg2: u32, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        let (v0, v1, v2, v3, v4) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::get_liquidity_range(&arg1.clmm_vault);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::update_liquidity_range(&mut arg1.clmm_vault, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), arg4, arg5, arg6);
        let v5 = UpdateLiquidityRangeEvent{
            pool_id                 : 0x2::object::id<Pool<T0>>(arg1),
            old_min_tick            : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0),
            old_max_tick            : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1),
            old_lower_offset        : v2,
            old_upper_offset        : v3,
            old_rebalance_threshold : v4,
            new_min_tick            : arg2,
            new_max_tick            : arg3,
            new_lower_offset        : arg4,
            new_upper_offset        : arg5,
            new_rebalance_threshold : arg6,
        };
        0x2::event::emit<UpdateLiquidityRangeEvent>(v5);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        let v0 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::withdraw_all<T0>(&mut arg1.buffer_assets);
        let v1 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::withdraw_all<T1>(&mut arg1.buffer_assets);
        let (v2, v3, v4) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::increase_liquidity<T0, T1>(&mut arg1.clmm_vault, arg2, arg3, &mut v0, &mut v1, arg4);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T0>(&mut arg1.buffer_assets, v0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T1>(&mut arg1.buffer_assets, v1);
        let v5 = AddLiquidityEvent{
            pool_id            : 0x2::object::id<Pool<T2>>(arg1),
            amount_a           : v2,
            amount_b           : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
            lp_supply          : total_token_amount<T2>(arg1),
        };
        0x2::event::emit<AddLiquidityEvent>(v5);
    }

    public fun calculate_aum<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::PythOracle, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut Pool<T2>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg3.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::pool_id(&arg3.clmm_vault), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::clmm_pool_not_match());
        let v0 = 0x2::tx_context::digest(arg5);
        let v1 = arg3.status.latest_claim_fee_tx;
        assert!(v0 == &v1, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::fee_claim_err());
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg2));
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v2)) {
            let v4 = (v3 as u8);
            assert!(v0 == 0x2::vec_map::get<u8, vector<u8>>(&arg3.status.latest_claim_rewards_tx, &v4), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::mining_claim_err());
            v3 = v3 + 1;
        };
        let (v5, v6) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::liquidity_value<T0, T1>(&arg3.clmm_vault, arg2);
        let v7 = 0;
        let v8 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>();
        let v9 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v10 = *0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::balances(&arg3.buffer_assets);
        while (v7 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v10)) {
            let (v11, v12) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v10, v7);
            let v13 = *v11;
            let v14 = *v12;
            let v15 = v14;
            if (!0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::contain_oracle_info(arg1, v13)) {
                v7 = v7 + 1;
                continue
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>(&mut v8, v13, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price_by_type(arg1, v13, arg4));
            if (0x1::type_name::get<T0>() == v13) {
                v15 = v14 + v5;
            } else if (0x1::type_name::get<T1>() == v13) {
                v15 = v14 + v6;
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v9, v13, v15);
            v7 = v7 + 1;
        };
        arg3.aum = calculate_tvl_base_on_quote(&v9, &v8, arg3.quote_type);
        arg3.status.latest_calculate_aum_tx = *v0;
    }

    fun calculate_tvl_base_on_quote(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>, arg2: 0x1::option::Option<0x1::type_name::TypeName>) : u128 {
        let v0 = if (0x1::option::is_none<0x1::type_name::TypeName>(&arg2)) {
            0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::new_price(1 * 0x1::u64::pow(10, 10), 10)
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>(arg1, 0x1::option::borrow<0x1::type_name::TypeName>(&arg2))
        };
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(arg0)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(arg0, v3);
            assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>(arg1, v4), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::price_err());
            let v6 = 0x2::vec_map::get<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>(arg1, v4);
            let (v7, _) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::calculate_prices(&v1, v6);
            v2 = v2 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v7 as u128), (*v5 as u128), (0x1::u64::pow(10, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::price_coin_decimal(v6)) as u128));
            v3 = v3 + 1;
        };
        v2
    }

    fun check_need_rebalance<T0>(arg0: &Pool<T0>, arg1: u128) : bool {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg1);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::borrow_position(&arg0.clmm_vault));
        let v3 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::rebalance_threshold(&arg0.clmm_vault);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) <= v3 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v2)) <= v3
    }

    public fun claim_protocol_fee<T0, T1>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = take_protocol_asset<T0, T1>(arg1);
        let v1 = ClaimProtocolFeeEvent{
            pool_id   : 0x2::object::id<Pool<T1>>(arg1),
            amount    : 0x2::balance::value<T0>(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun create_pool<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut PoolRegistry, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: u8, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg12));
        assert!(0x2::coin::total_supply<T2>(&arg2) == 0, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::treasury_cap_illegal());
        let v0 = if (arg10 == 0) {
            true
        } else if (arg10 == 1) {
            true
        } else {
            arg10 == 2
        };
        assert!(v0, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::quote_type_error());
        let v1 = if (arg10 == 0) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>())
        } else if (arg10 == 1) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>())
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        };
        let v2 = Pool<T2>{
            id                 : 0x2::object::new(arg12),
            aum                : 0,
            is_pause           : false,
            clmm_vault         : 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::new<T0, T1>(arg3, arg4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6), arg7, arg8, arg9, arg12),
            lp_token_treasury  : arg2,
            buffer_assets      : 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::new_balance_bag(arg12),
            protocol_fees      : 0x2::bag::new(arg12),
            hard_cap           : arg11,
            rebalance_slippage : 1000,
            quote_type         : v1,
            status             : new_status(),
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.pools, 0x2::object::id<Pool<T2>>(&v2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        let v3 = CreateEvent{
            id                  : 0x2::object::id<Pool<T2>>(&v2),
            clmm_pool           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            tick_lower          : arg5,
            tick_upper          : arg6,
            lower_offset        : arg7,
            upper_offset        : arg8,
            rebalance_threshold : arg9,
            lp_token_treasury   : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg2),
            quote_type          : v1,
            hard_cap            : arg11,
        };
        0x2::event::emit<CreateEvent>(v3);
        0x2::transfer::share_object<Pool<T2>>(v2);
    }

    public fun deposit<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::PythOracle, arg2: &mut Pool<T2>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg2.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        let v0 = arg2.status.latest_calculate_aum_tx;
        assert!(0x2::tx_context::digest(arg8) == &v0, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::aum_done_err());
        arg2.status.latest_calculate_aum_tx = 0x1::vector::empty<u8>();
        arg2.status.latest_claim_rewards_tx = 0x2::vec_map::empty<u8, vector<u8>>();
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1, 0x1::type_name::get<T0>(), arg5);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v1, 0x1::type_name::get<T1>(), arg6);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>(&mut v2, 0x1::type_name::get<T0>(), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price<T0>(arg1, arg7));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::Price>(&mut v2, 0x1::type_name::get<T1>(), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price<T1>(arg1, arg7));
        let v3 = calculate_tvl_base_on_quote(&v1, &v2, arg2.quote_type);
        let v4 = total_token_amount<T2>(arg2);
        if (arg2.hard_cap != 0) {
            assert!(arg2.aum + v3 <= arg2.hard_cap, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::hard_cap_reached());
        };
        let v5 = get_lp_amount_by_tvl(v4, v3, arg2.aum);
        assert!(v5 > 0, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::token_amount_is_zero());
        assert!(v5 < ((18446744073709551616 - 1) as u128) - (v4 as u128), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::token_amount_overflow());
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T0>(&mut arg2.buffer_assets, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, arg5, arg8)));
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T1>(&mut arg2.buffer_assets, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg4, arg6, arg8)));
        arg2.aum = arg2.aum + v3;
        let v6 = DepositEvent{
            pool_id       : 0x2::object::id<Pool<T2>>(arg2),
            before_aum    : arg2.aum,
            user_tvl      : v3,
            before_supply : v4,
            lp_amount     : (v5 as u64),
        };
        0x2::event::emit<DepositEvent>(v6);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::utils::send_coin<T2>(0x2::coin::mint<T2>(&mut arg2.lp_token_treasury, (v5 as u64), arg8), 0x2::tx_context::sender(arg8));
    }

    public fun destory_withdraw_cert<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &Pool<T0>, arg2: WithdrawCert) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        let WithdrawCert {
            pool_id         : v0,
            rewards_amounts : v1,
        } = arg2;
        let v2 = v1;
        assert!(v0 == 0x2::object::id<Pool<T0>>(arg1), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::withdraw_cert_pool_id_not_match());
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&v2), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::remove_assets_not_empty());
    }

    public fun flash_loan<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::PythOracle, arg2: &mut Pool<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanCert) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_operation_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(!arg2.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        let v0 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price<T0>(arg1, arg4);
        let v1 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::get_price<T1>(arg1, arg4);
        let (v2, _) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::calculate_prices(&v0, &v1);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v2, arg3, 0x1::u64::pow(10, 10)), 10000 - (0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::get_swap_slippage<T0>(arg0) + 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::get_swap_slippage<T1>(arg0)) / 2, 10000);
        let v5 = 0x1::type_name::get<T1>();
        let v6 = FlashLoanCert{
            pool_id      : 0x2::object::id<Pool<T2>>(arg2),
            repay_type   : v5,
            repay_amount : v4,
        };
        let v7 = FlashLoanEvent{
            pool_id             : 0x2::object::id<Pool<T2>>(arg2),
            loan_type           : 0x1::type_name::get<T0>(),
            repay_type          : v5,
            loan_amount         : arg3,
            repay_amount        : v4,
            base_to_quote_price : v2,
            base_price          : 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::price_value(&v0),
            quote_price         : 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::price_value(&v1),
        };
        0x2::event::emit<FlashLoanEvent>(v7);
        (0x2::coin::from_balance<T0>(0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::split<T0>(&mut arg2.buffer_assets, arg3), arg5), v6)
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

    fun merge_protocol_asset<T0, T1>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T1>, arg2: &mut 0x2::balance::Balance<T0>) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::utils::add_balance_to_bag<T0>(&mut arg1.protocol_fees, 0x2::balance::split<T0>(arg2, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::calculate_fee_amount(arg0, 0x2::balance::value<T0>(arg2))));
    }

    fun new_status() : Status {
        Status{
            latest_claim_fee_tx     : 0x1::vector::empty<u8>(),
            latest_claim_rewards_tx : 0x2::vec_map::empty<u8, vector<u8>>(),
            latest_calculate_aum_tx : 0x1::vector::empty<u8>(),
        }
    }

    public fun pause<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = true;
        let v0 = PauseEvent{pool_id: 0x2::object::id<Pool<T0>>(arg1)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T1>, arg2: FlashLoanCert, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_operation_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        let FlashLoanCert {
            pool_id      : v0,
            repay_type   : v1,
            repay_amount : v2,
        } = arg2;
        assert!(0x1::type_name::get<T0>() == v1, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::incorrect_repay());
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::incorrect_repay());
        assert!(0x2::object::id<Pool<T1>>(arg1) == v0, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::incorrect_repay());
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::join<T0>(&mut arg1.buffer_assets, 0x2::coin::into_balance<T0>(arg3));
        let v3 = RepayFlashLoanEvent{
            pool_id      : 0x2::object::id<Pool<T1>>(arg1),
            repay_type   : v1,
            repay_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v3);
    }

    fun take_protocol_asset<T0, T1>(arg0: &mut Pool<T1>) : 0x2::balance::Balance<T0> {
        let (v0, _) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::utils::remove_balance_from_bag<T0>(&mut arg0.protocol_fees, 0, true);
        v0
    }

    public fun total_token_amount<T0>(arg0: &Pool<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_token_treasury)
    }

    public fun unpause<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = false;
        let v0 = UnpauseEvent{pool_id: 0x2::object::id<Pool<T0>>(arg1)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_hard_cap<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        arg1.hard_cap = arg2;
        let v0 = UpdateHardCapEvent{
            pool_id      : 0x2::object::id<Pool<T0>>(arg1),
            old_hard_cap : arg1.hard_cap,
            new_hard_cap : arg2,
        };
        0x2::event::emit<UpdateHardCapEvent>(v0);
    }

    public fun update_price<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::PythOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        let v0 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::update_price_from_type<T0>(arg1, arg4, arg5);
        let v1 = UpdatePriceEvent{
            coin_type        : 0x1::type_name::get<T0>(),
            price            : 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::price_value(&v0),
            last_update_time : 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::last_update_time(&v0),
        };
        0x2::event::emit<UpdatePriceEvent>(v1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, arg3, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::pyth_oracle::split_fee(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg2)), arg6), arg5)
    }

    public fun update_rebalance_slippage<T0>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        let v0 = UpdateRebalanceSlippageEvent{
            pool_id      : 0x2::object::id<Pool<T0>>(arg1),
            old_slippage : arg1.rebalance_slippage,
            new_slippage : arg2,
        };
        0x2::event::emit<UpdateRebalanceSlippageEvent>(v0);
        arg1.rebalance_slippage = arg2;
    }

    public fun withdraw<T0, T1, T2>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, WithdrawCert) {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::pool_id(&arg1.clmm_vault), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::clmm_pool_not_match());
        let v0 = 0x2::tx_context::digest(arg7);
        let v1 = arg1.status.latest_claim_fee_tx;
        assert!(v0 == &v1, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::fee_claim_err());
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg3));
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v2)) {
            let v4 = (v3 as u8);
            assert!(v0 == 0x2::vec_map::get<u8, vector<u8>>(&arg1.status.latest_claim_rewards_tx, &v4), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::mining_claim_err());
            v3 = v3 + 1;
        };
        assert!(arg5 <= 0x2::coin::value<T2>(arg4), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::token_amount_not_enough());
        0x2::coin::burn<T2>(&mut arg1.lp_token_treasury, 0x2::coin::split<T2>(arg4, arg5, arg7));
        let v5 = total_token_amount<T2>(arg1);
        let v6 = *0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::balances(&arg1.buffer_assets);
        let v7 = 0x1::type_name::get<T0>();
        let (_, v9) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v6, &v7);
        let v10 = 0x1::type_name::get<T1>();
        let (_, v12) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v6, &v10);
        let v13 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::split<T0>(&mut arg1.buffer_assets, (get_user_share_by_lp_amount(v5, arg5, (v9 as u128)) as u64));
        let v14 = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::split<T1>(&mut arg1.buffer_assets, (get_user_share_by_lp_amount(v5, arg5, (v12 as u128)) as u64));
        let v15 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v16 = 0;
        while (v16 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v2)) {
            let (v17, v18) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v6, v16);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v15, *v17, (get_user_share_by_lp_amount(v5, arg5, (*v18 as u128)) as u64));
            v16 = v16 + 1;
        };
        let v19 = WithdrawCert{
            pool_id         : 0x2::object::id<Pool<T2>>(arg1),
            rewards_amounts : v15,
        };
        let v20 = get_user_share_by_lp_amount(v5, arg5, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::get_position_liquidity(&arg1.clmm_vault));
        let (v21, v22) = 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::clmm_vault::decrease_liquidity<T0, T1>(&mut arg1.clmm_vault, arg2, arg3, v20, arg6);
        0x2::balance::join<T0>(&mut v13, v21);
        0x2::balance::join<T1>(&mut v14, v22);
        let v23 = WithdrawEvent{
            pool_id   : 0x2::object::id<Pool<T2>>(arg1),
            lp_amount : arg5,
            liquidity : v20,
            amount_a  : 0x2::balance::value<T0>(&v13),
            amount_b  : 0x2::balance::value<T1>(&v14),
        };
        0x2::event::emit<WithdrawEvent>(v23);
        (0x2::coin::from_balance<T0>(v13, arg7), 0x2::coin::from_balance<T1>(v14, arg7), v19)
    }

    public fun withdraw_buffer_reward<T0, T1>(arg0: &0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::GlobalConfig, arg1: &mut Pool<T1>, arg2: &mut WithdrawCert) : 0x2::balance::Balance<T0> {
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::config::checked_package_version(arg0);
        assert!(!arg1.is_pause, 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::pool_is_pause());
        assert!(arg2.pool_id == 0x2::object::id<Pool<T1>>(arg1), 0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::error::withdraw_cert_pool_id_not_match());
        let v0 = 0x1::type_name::get<T0>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg2.rewards_amounts, &v0);
        let v3 = WithdrawBufferRewardEvent{
            pool_id    : 0x2::object::id<Pool<T1>>(arg1),
            asset_type : v0,
            amount     : v2,
        };
        0x2::event::emit<WithdrawBufferRewardEvent>(v3);
        0xe87dea2aad563331d892ee8418de85422dd2c67b79e719995eb63c33c565788c::balance_bag::split<T0>(&mut arg1.buffer_assets, v2)
    }

    // decompiled from Move bytecode v6
}

