module 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::lending {
    struct PoolLending has store {
        config: PoolLendingConfig,
        state: PoolLendingState,
        extra: 0x2::bag::Bag,
    }

    struct PoolLendingConfig has copy, drop, store {
        enable_x: bool,
        enable_y: bool,
        market_id_x: u64,
        market_id_y: u64,
        buffer_bps_x: u64,
        buffer_bps_y: u64,
        max_lend_bps_x: u64,
        max_lend_bps_y: u64,
        rewards_enabled: bool,
        lp_yield_share_bps: u64,
    }

    struct PoolLendingState has store {
        position_cap: 0x1::option::Option<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>,
        protocol_id: 0x1::option::Option<0x2::object::ID>,
        lifetime_yield_x: u128,
        lifetime_yield_y: u128,
        pending_protocol_yield_x: u64,
        pending_protocol_yield_y: u64,
        undistributed_lp_yield_x: u64,
        undistributed_lp_yield_y: u64,
        lp_cut_carry_x: u64,
        lp_cut_carry_y: u64,
        unrealized_lp_yield_x: u64,
        unrealized_lp_yield_y: u64,
        lp_yield_growth_x: 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::Index,
        lp_yield_growth_y: 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::Index,
        last_sync_ts_ms: u64,
        last_deploy_ts_ms: u64,
        deploy_blocked: bool,
        pending_burn_x: u64,
        pending_burn_y: u64,
        extra: 0x2::bag::Bag,
    }

    struct LendingInitializedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        market_id_x: u64,
        market_id_y: u64,
        position_id: 0x2::object::ID,
    }

    struct LendingConfigUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        config: PoolLendingConfig,
    }

    struct LendingSyncEvent has copy, drop {
        pool_id: 0x2::object::ID,
        new_cached_x: u64,
        new_cached_y: u64,
        delta_yield_x: u64,
        delta_yield_y: u64,
        lp_yield_x: u64,
        lp_yield_y: u64,
        protocol_yield_x: u64,
        protocol_yield_y: u64,
        ts_ms: u64,
    }

    struct LendingDeployEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        ts_ms: u64,
    }

    struct LendingRecallEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        surplus: u64,
        ts_ms: u64,
    }

    struct LendingRewardHarvestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount_x_market: u64,
        amount_y_market: u64,
        amount: u64,
        ts_ms: u64,
    }

    struct ProtocolYieldClaimedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        from_slack_x: u64,
        from_slack_y: u64,
        ts_ms: u64,
    }

    struct ExternalRewardClaimedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LendingDeployBlockClearedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LendingLossEvent has copy, drop {
        pool_id: 0x2::object::ID,
        side_x: bool,
        gap: u64,
        from_protocol: u64,
        from_parked: u64,
        lp_loss: u64,
        ts_ms: u64,
    }

    struct LendingResidueWrittenOffEvent has copy, drop {
        pool_id: 0x2::object::ID,
        side_x: bool,
        amount: u64,
        from_protocol: u64,
        from_parked: u64,
        lp_loss: u64,
        ts_ms: u64,
    }

    struct LendingPositionAbandonedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        abandoned_cached_x: u64,
        abandoned_cached_y: u64,
        abandoned_yield_x: u64,
        abandoned_yield_y: u64,
        abandoned_lp_yield_x: u64,
        abandoned_lp_yield_y: u64,
        ts_ms: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : PoolLending {
        let v0 = new_state(arg0);
        PoolLending{
            config : default_config(),
            state  : v0,
            extra  : 0x2::bag::new(arg0),
        }
    }

    public fun abandon_position<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: address) {
        assert_position_drained(arg0, arg2, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, v2) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::abandon_deployed<T0, T1>(arg1);
        let v3 = state_mut(arg0);
        let v4 = v1 > 0;
        let v5 = v2 > 0;
        let (v6, v7) = if (v4) {
            let v7 = v3.undistributed_lp_yield_x;
            let v6 = v3.pending_protocol_yield_x;
            (v6, v7)
        } else {
            (0, 0)
        };
        let (v8, v9) = if (v5) {
            let v9 = v3.undistributed_lp_yield_y;
            let v8 = v3.pending_protocol_yield_y;
            (v8, v9)
        } else {
            (0, 0)
        };
        if (v4) {
            apply_side_loss(v3, arg3, true, v1, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(arg1), v0);
        };
        if (v5) {
            apply_side_loss(v3, arg3, false, v2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(arg1), v0);
        };
        v3.deploy_blocked = true;
        if (0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap)) {
            0x2::transfer::public_transfer<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(0x1::option::extract<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&mut v3.position_cap), arg5);
        };
        if (0x1::option::is_some<0x2::object::ID>(&v3.protocol_id)) {
            0x1::option::extract<0x2::object::ID>(&mut v3.protocol_id);
        };
        let v10 = config_mut(arg0);
        v10.enable_x = false;
        v10.enable_y = false;
        let v11 = LendingConfigUpdatedEvent{
            pool_id : arg3,
            config  : *v10,
        };
        0x2::event::emit<LendingConfigUpdatedEvent>(v11);
        let v12 = LendingPositionAbandonedEvent{
            pool_id              : arg3,
            abandoned_cached_x   : v1,
            abandoned_cached_y   : v2,
            abandoned_yield_x    : v6,
            abandoned_yield_y    : v8,
            abandoned_lp_yield_x : v7,
            abandoned_lp_yield_y : v9,
            ts_ms                : v0,
        };
        0x2::event::emit<LendingPositionAbandonedEvent>(v12);
    }

    fun adjust_deferred(arg0: &mut u64, arg1: &mut u64, arg2: u64, arg3: u64) {
        let v0 = (*arg0 as u128) + (arg2 as u128);
        let v1 = (*arg1 as u128) + (arg3 as u128);
        if (v0 >= v1) {
            *arg0 = ((v0 - v1) as u64);
            *arg1 = 0;
        } else {
            *arg0 = 0;
            *arg1 = ((v1 - v0) as u64);
        };
    }

    fun apply_side_loss(arg0: &mut PoolLendingState, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let (v0, v1, v2) = socialize_side_gap(arg0, arg2, arg3, arg4);
        arg0.deploy_blocked = true;
        let v3 = LendingLossEvent{
            pool_id       : arg1,
            side_x        : arg2,
            gap           : arg3,
            from_protocol : v0,
            from_parked   : v1,
            lp_loss       : v2,
            ts_ms         : arg5,
        };
        0x2::event::emit<LendingLossEvent>(v3);
    }

    fun apply_sync<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(arg1);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(arg1);
        let (v2, v3) = compute_sync_delta(arg7, arg5);
        let (v4, v5) = compute_sync_delta(arg8, arg6);
        let v6 = if (v3 > 64) {
            v3
        } else {
            0
        };
        let v7 = if (v5 > 64) {
            v5
        } else {
            0
        };
        let v8 = if (v6 == 0 && arg7 == 0) {
            v3
        } else {
            0
        };
        let v9 = if (v7 == 0 && arg8 == 0) {
            v5
        } else {
            0
        };
        if (v2 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::credit_deployed_x<T0, T1>(arg1, v2);
        };
        if (v4 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::credit_deployed_y<T0, T1>(arg1, v4);
        };
        if (v6 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_x<T0, T1>(arg1, v6);
        };
        if (v7 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_y<T0, T1>(arg1, v7);
        };
        if (v8 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_x<T0, T1>(arg1, v8);
        };
        if (v9 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_y<T0, T1>(arg1, v9);
        };
        let v10 = state_mut(arg0);
        let (v11, v12) = lp_cut_carrying(v2, arg4, v10.lp_cut_carry_x);
        let (v13, v14) = lp_cut_carrying(v4, arg4, v10.lp_cut_carry_y);
        v10.lp_cut_carry_x = v12;
        v10.lp_cut_carry_y = v14;
        let v15 = v2 - v11;
        let v16 = v4 - v13;
        v10.pending_protocol_yield_x = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v10.pending_protocol_yield_x, v15);
        v10.pending_protocol_yield_y = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v10.pending_protocol_yield_y, v16);
        v10.undistributed_lp_yield_x = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v10.undistributed_lp_yield_x, v11);
        v10.undistributed_lp_yield_y = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v10.undistributed_lp_yield_y, v13);
        v10.lifetime_yield_x = v10.lifetime_yield_x + (v2 as u128);
        v10.lifetime_yield_y = v10.lifetime_yield_y + (v4 as u128);
        v10.last_sync_ts_ms = arg3;
        if (v6 > 0) {
            apply_side_loss(v10, arg2, true, v6, v0, arg3);
        };
        if (v7 > 0) {
            apply_side_loss(v10, arg2, false, v7, v1, arg3);
        };
        if (v8 > 0) {
            write_off_side_residue(v10, arg2, true, v8, v0, arg3);
        };
        if (v9 > 0) {
            write_off_side_residue(v10, arg2, false, v9, v1, arg3);
        };
        let v17 = LendingSyncEvent{
            pool_id          : arg2,
            new_cached_x     : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1),
            new_cached_y     : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1),
            delta_yield_x    : v2,
            delta_yield_y    : v4,
            lp_yield_x       : v11,
            lp_yield_y       : v13,
            protocol_yield_x : v15,
            protocol_yield_y : v16,
            ts_ms            : arg3,
        };
        0x2::event::emit<LendingSyncEvent>(v17);
    }

    public fun assert_enabled_markets_exist(arg0: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &PoolLendingConfig) {
        if (arg1.enable_x) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::assert_market_exists(arg0, arg1.market_id_x);
        };
        if (arg1.enable_y) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::assert_market_exists(arg0, arg1.market_id_y);
        };
    }

    fun assert_position_drained(arg0: &PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) {
        let (v0, v1) = read_position_live(arg0, arg1, arg2);
        assert!(v0 == 0, 617);
        assert!(v1 == 0, 617);
    }

    public fun assert_protocol(arg0: &PoolLending, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol) {
        let v0 = &state(arg0).protocol_id;
        if (0x1::option::is_none<0x2::object::ID>(v0)) {
            return
        };
        assert!(*0x1::option::borrow<0x2::object::ID>(v0) == 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg1), 615);
    }

    public fun auto_deploy_if_excess<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg0, arg2);
        if (!is_deploy_enabled(arg0)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = state(arg0).last_deploy_ts_ms;
        if (v1 != 0 && v0 == v1) {
            return
        };
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<T0, T1>(arg1);
        let v3 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_y<T0, T1>(arg1);
        let (v4, v5, v6, v7) = deploy_side_plan<T0, T1>(arg0, arg1, v2, true);
        let (v8, v9, v10, v11) = deploy_side_plan<T0, T1>(arg0, arg1, v3, false);
        let v12 = config(arg0);
        let v13 = if (v4) {
            compute_deploy_amount(v2, v6, v12.buffer_bps_x, 500, v7)
        } else {
            0
        };
        let v14 = if (v8) {
            compute_deploy_amount(v3, v10, v12.buffer_bps_y, 500, v11)
        } else {
            0
        };
        if (v13 == 0 && v14 == 0) {
            return
        };
        let v15 = LendingDeployEvent{
            pool_id  : arg3,
            amount_x : v13,
            amount_y : v14,
            ts_ms    : v0,
        };
        0x2::event::emit<LendingDeployEvent>(v15);
        if (v13 > 0) {
            deploy_side_x<T0, T1>(arg0, arg1, arg2, arg3, v5, v13, arg4, arg5);
        };
        if (v14 > 0) {
            deploy_side_y<T0, T1>(arg0, arg1, arg2, arg3, v9, v14, arg4, arg5);
        };
        state_mut(arg0).last_deploy_ts_ms = v0;
    }

    fun bank_recall_surplus(arg0: &mut PoolLending, arg1: u64, arg2: u64) {
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        let v0 = lp_yield_share_bps(arg0);
        let v1 = state_mut(arg0);
        if (arg1 > 0) {
            let (v2, v3) = lp_cut_carrying(arg1, v0, v1.lp_cut_carry_x);
            v1.lp_cut_carry_x = v3;
            v1.undistributed_lp_yield_x = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v1.undistributed_lp_yield_x, v2);
            v1.pending_protocol_yield_x = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v1.pending_protocol_yield_x, arg1 - v2);
            v1.lifetime_yield_x = v1.lifetime_yield_x + (arg1 as u128);
        };
        if (arg2 > 0) {
            let (v4, v5) = lp_cut_carrying(arg2, v0, v1.lp_cut_carry_y);
            v1.lp_cut_carry_y = v5;
            v1.undistributed_lp_yield_y = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v1.undistributed_lp_yield_y, v4);
            v1.pending_protocol_yield_y = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(v1.pending_protocol_yield_y, arg2 - v4);
            v1.lifetime_yield_y = v1.lifetime_yield_y + (arg2 as u128);
        };
    }

    public fun build_config(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64) : PoolLendingConfig {
        let v0 = PoolLendingConfig{
            enable_x           : arg0,
            enable_y           : arg1,
            market_id_x        : arg2,
            market_id_y        : arg3,
            buffer_bps_x       : arg4,
            buffer_bps_y       : arg5,
            max_lend_bps_x     : arg6,
            max_lend_bps_y     : arg7,
            rewards_enabled    : arg8,
            lp_yield_share_bps : arg9,
        };
        validate_config(&v0);
        v0
    }

    fun cap_pull_at_live(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0 == 18446744073709551615) {
            return arg0
        };
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(arg0, arg1)
    }

    public fun claim_external_reward<T0>(arg0: &mut PoolLending, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = reward_balance_key<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.extra, v0)) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extra, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        if (v2 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v3 = ExternalRewardClaimedEvent{
            pool_id     : arg1,
            reward_type : 0x1::type_name::with_defining_ids<T0>(),
            amount      : v2,
        };
        0x2::event::emit<ExternalRewardClaimedEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg2)
    }

    public fun claim_protocol_yield<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_protocol(arg0, arg2);
        let (v0, v1, v2, v3) = snapshot_yield_pull<T0, T1>(arg0, arg1);
        let (v4, v5) = claim_yield_side_x<T0, T1>(arg0, arg1, arg2, v0, v2, arg4, arg5);
        let v6 = v4;
        let (v7, v8) = claim_yield_side_y<T0, T1>(arg0, arg1, arg2, v1, v3, arg4, arg5);
        let v9 = v7;
        emit_yield_claimed_event(arg3, 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v9), v5, v8, arg4);
        (v6, v9)
    }

    public fun claim_protocol_yield_x_sui<T0>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_protocol(arg0, arg2);
        let (v0, v1, v2, v3) = snapshot_yield_pull<0x2::sui::SUI, T0>(arg0, arg1);
        let (v4, v5) = claim_yield_side_x_sui<T0>(arg0, arg1, arg2, v0, v2, arg4, arg5, arg6);
        let v6 = v4;
        let (v7, v8) = claim_yield_side_y<0x2::sui::SUI, T0>(arg0, arg1, arg2, v1, v3, arg5, arg6);
        let v9 = v7;
        emit_yield_claimed_event(arg3, 0x2::coin::value<0x2::sui::SUI>(&v6), 0x2::coin::value<T0>(&v9), v5, v8, arg5);
        (v6, v9)
    }

    fun claim_pull_size(arg0: &PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(arg3, arg2);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = read_live_collateral(arg0, arg1, arg4, arg5);
        (cap_pull_at_live(v0, v1), v1)
    }

    fun claim_reward_side<T0>(arg0: &mut PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert_protocol(arg0, arg1);
        let (v0, v1) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::collect_reward<T0>(arg1, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap), arg2, arg3, arg4);
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::settle_reward_promise<T0>(arg1, v1, v0, arg3, arg4);
        deposit_reward<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x2::coin::value<T0>(&v2)
    }

    fun claim_reward_side_sui(arg0: &mut PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert_protocol(arg0, arg1);
        let (v0, v1) = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::collect_reward<0x2::sui::SUI>(arg1, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap), arg2, arg4, arg5);
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::settle_reward_promise_sui(arg1, v1, v0, arg3, arg4, arg5);
        deposit_reward<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x2::coin::value<0x2::sui::SUI>(&v2)
    }

    fun claim_yield_side_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        if (arg3 == 0) {
            return (0x2::coin::zero<T0>(arg6), 0)
        };
        let (v0, _) = claim_pull_size(arg0, arg2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1), arg3, arg4, arg5);
        if (v0 == 0) {
            let v2 = 0x2::coin::zero<T0>(arg6);
            return settle_protocol_claim_recall_x<T0, T1>(arg0, arg1, arg3, v2, arg6)
        };
        let v3 = state_mut(arg0);
        let v4 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::remove_and_fulfill<T0>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap), arg4, v0, arg5, arg6);
        settle_protocol_claim_recall_x<T0, T1>(arg0, arg1, arg3, v4, arg6)
    }

    fun claim_yield_side_x_sui<T0>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        if (arg3 == 0) {
            return (0x2::coin::zero<0x2::sui::SUI>(arg7), 0)
        };
        let (v0, _) = claim_pull_size(arg0, arg2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<0x2::sui::SUI, T0>(arg1), arg3, arg4, arg6);
        if (v0 == 0) {
            let v2 = 0x2::coin::zero<0x2::sui::SUI>(arg7);
            return settle_protocol_claim_recall_x<0x2::sui::SUI, T0>(arg0, arg1, arg3, v2, arg7)
        };
        let v3 = state_mut(arg0);
        let v4 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::remove_and_fulfill_sui(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap), arg4, v0, arg5, arg6, arg7);
        settle_protocol_claim_recall_x<0x2::sui::SUI, T0>(arg0, arg1, arg3, v4, arg7)
    }

    fun claim_yield_side_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        if (arg3 == 0) {
            return (0x2::coin::zero<T1>(arg6), 0)
        };
        let (v0, _) = claim_pull_size(arg0, arg2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1), arg3, arg4, arg5);
        if (v0 == 0) {
            let v2 = 0x2::coin::zero<T1>(arg6);
            return settle_protocol_claim_recall_y<T0, T1>(arg0, arg1, arg3, v2, arg6)
        };
        let v3 = state_mut(arg0);
        let v4 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::remove_and_fulfill<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap), arg4, v0, arg5, arg6);
        settle_protocol_claim_recall_y<T0, T1>(arg0, arg1, arg3, v4, arg6)
    }

    public fun collect_external_reward<T0>(arg0: &mut PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg0, arg1);
        if (!is_configured(arg0)) {
            return
        };
        let (v0, v1, v2, v3, v4, v5) = reward_harvest_plan(arg0);
        if (!v4) {
            return
        };
        let v6 = 0;
        let v7 = 0;
        if (v0 && v5) {
            v6 = claim_reward_side<T0>(arg0, arg1, v2, arg3, arg4);
        };
        if (v1 && v5) {
            v7 = claim_reward_side<T0>(arg0, arg1, v3, arg3, arg4);
        };
        emit_reward_harvest<T0>(arg2, v6, v7, arg3);
    }

    public fun collect_external_reward_sui(arg0: &mut PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg0, arg1);
        if (!is_configured(arg0)) {
            return
        };
        let (v0, v1, v2, v3, v4, v5) = reward_harvest_plan(arg0);
        if (!v4) {
            return
        };
        let v6 = 0;
        let v7 = 0;
        if (v0 && v5) {
            v6 = claim_reward_side_sui(arg0, arg1, v2, arg3, arg4, arg5);
        };
        if (v1 && v5) {
            v7 = claim_reward_side_sui(arg0, arg1, v3, arg3, arg4, arg5);
        };
        emit_reward_harvest<0x2::sui::SUI>(arg2, v6, v7, arg4);
    }

    fun compute_deploy_amount(arg0: u64, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u128();
        let v1 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::checked_add(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor(arg1, (arg2 as u128), v0), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor(arg1, (arg3 as u128), v0));
        if ((arg0 as u128) <= v1) {
            return 0
        };
        let v2 = (arg0 as u128) - v1;
        let v3 = if (v2 > 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64_as_u128()) {
            18446744073709551615
        } else {
            (v2 as u64)
        };
        let v4 = if (v3 < arg4) {
            v3
        } else {
            arg4
        };
        if (v4 < 1000) {
            0
        } else {
            v4
        }
    }

    fun compute_sync_delta(arg0: u64, arg1: u64) : (u64, u64) {
        if (arg0 >= arg1) {
            (arg0 - arg1, 0)
        } else {
            (0, arg1 - arg0)
        }
    }

    fun config(arg0: &PoolLending) : &PoolLendingConfig {
        &arg0.config
    }

    fun config_mut(arg0: &mut PoolLending) : &mut PoolLendingConfig {
        &mut arg0.config
    }

    public fun config_snapshot(arg0: &PoolLending) : PoolLendingConfig {
        *config(arg0)
    }

    public fun consume_pending_burn(arg0: &mut PoolLending, arg1: u64, arg2: u64) {
        let v0 = state_mut(arg0);
        let v1 = &mut v0.unrealized_lp_yield_x;
        let v2 = &mut v0.pending_burn_x;
        adjust_deferred(v1, v2, arg1, 0);
        let v3 = &mut v0.unrealized_lp_yield_y;
        let v4 = &mut v0.pending_burn_y;
        adjust_deferred(v3, v4, arg2, 0);
    }

    public fun consume_unrealized(arg0: &mut PoolLending, arg1: u64, arg2: u64) {
        let v0 = state_mut(arg0);
        let v1 = &mut v0.unrealized_lp_yield_x;
        let v2 = &mut v0.pending_burn_x;
        adjust_deferred(v1, v2, 0, arg1);
        let v3 = &mut v0.unrealized_lp_yield_y;
        let v4 = &mut v0.pending_burn_y;
        adjust_deferred(v3, v4, 0, arg2);
    }

    fun cover_full_drain_dust_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1);
        if (v0 == 0 || v0 > 64) {
            return
        };
        let v1 = state_mut(arg0);
        write_off_side_residue(v1, arg2, true, v0, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(arg1), arg3);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_x<T0, T1>(arg1, v0);
    }

    fun cover_full_drain_dust_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1);
        if (v0 == 0 || v0 > 64) {
            return
        };
        let v1 = state_mut(arg0);
        write_off_side_residue(v1, arg2, false, v0, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(arg1), arg3);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_y<T0, T1>(arg1, v0);
    }

    fun default_config() : PoolLendingConfig {
        PoolLendingConfig{
            enable_x           : false,
            enable_y           : false,
            market_id_x        : 0,
            market_id_y        : 0,
            buffer_bps_x       : 2500,
            buffer_bps_y       : 2500,
            max_lend_bps_x     : 5000,
            max_lend_bps_y     : 5000,
            rewards_enabled    : true,
            lp_yield_share_bps : 8000,
        }
    }

    public fun deploy_blocked(arg0: &PoolLending) : bool {
        if (!is_configured(arg0)) {
            return false
        };
        arg0.state.deploy_blocked
    }

    fun deploy_side_plan<T0, T1>(arg0: &PoolLending, arg1: &0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: u64, arg3: bool) : (bool, u64, u128, u64) {
        let v0 = config(arg0);
        let v1 = state(arg0);
        let (v2, v3, v4, v5) = if (arg3) {
            (v0.enable_x, market_id_x(v0), v0.max_lend_bps_x, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1))
        } else {
            (v0.enable_y, market_id_y(v0), v0.max_lend_bps_y, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1))
        };
        let v6 = (arg2 as u128) + (v5 as u128);
        let v7 = deployed_cap(v6, v4);
        let v8 = if (v5 >= v7) {
            0
        } else {
            v7 - v5
        };
        let v9 = if (v2) {
            if (v3 != 0) {
                0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap)
            } else {
                false
            }
        } else {
            false
        };
        (v9, v3, v6, v8)
    }

    fun deploy_side_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = read_live_collateral(arg0, arg2, arg4, arg6);
        let v1 = state_mut(arg0);
        assert!(0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap), 608);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::add_collateral<T0>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap), arg4, 0x2::coin::from_balance<T0>(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deploy_x<T0, T1>(arg1, arg5), arg7), arg6, arg7);
        let v2 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(arg5, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(read_live_collateral(arg0, arg2, arg4, arg6), v0));
        assert!(v2 <= 64, 621);
        if (v2 > 0) {
            let v3 = state_mut(arg0);
            write_off_side_residue(v3, arg3, true, v2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg6));
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_x<T0, T1>(arg1, v2);
        };
    }

    fun deploy_side_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = read_live_collateral(arg0, arg2, arg4, arg6);
        let v1 = state_mut(arg0);
        assert!(0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap), 608);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::add_collateral<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap), arg4, 0x2::coin::from_balance<T1>(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deploy_y<T0, T1>(arg1, arg5), arg7), arg6, arg7);
        let v2 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(arg5, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(read_live_collateral(arg0, arg2, arg4, arg6), v0));
        assert!(v2 <= 64, 621);
        if (v2 > 0) {
            let v3 = state_mut(arg0);
            write_off_side_residue(v3, arg3, false, v2, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg6));
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_y<T0, T1>(arg1, v2);
        };
    }

    fun deployed_cap(arg0: u128, arg1: u64) : u64 {
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor(arg0, (arg1 as u128), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u128());
        if (v0 > 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64_as_u128()) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun deposit_reward<T0>(arg0: &mut PoolLending, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = reward_balance_key<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.extra, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extra, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.extra, v0), arg1);
    }

    public fun distribute_lp_yield(arg0: &mut PoolLending, arg1: u64, arg2: u64) {
        let v0 = state_mut(arg0);
        let v1 = (arg1 as u128) + (v0.unrealized_lp_yield_x as u128) - (v0.pending_burn_x as u128);
        let v2 = (arg2 as u128) + (v0.unrealized_lp_yield_y as u128) - (v0.pending_burn_y as u128);
        let v3 = v0.undistributed_lp_yield_x;
        let v4 = v0.undistributed_lp_yield_y;
        if (arg1 == 0) {
            v0.pending_protocol_yield_x = v0.pending_protocol_yield_x + v3 + (v1 as u64);
            v0.unrealized_lp_yield_x = 0;
            v0.pending_burn_x = 0;
            v0.undistributed_lp_yield_x = 0;
            v0.lp_cut_carry_x = 0;
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::reset(&mut v0.lp_yield_growth_x);
        } else if (v1 > 0 && v3 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::advance(&mut v0.lp_yield_growth_x, v1, v1 + (v3 as u128));
            if (v0.lp_yield_growth_x != v0.lp_yield_growth_x) {
                let v5 = &mut v0.unrealized_lp_yield_x;
                let v6 = &mut v0.pending_burn_x;
                adjust_deferred(v5, v6, v3, 0);
                v0.undistributed_lp_yield_x = 0;
            };
        };
        if (arg2 == 0) {
            v0.pending_protocol_yield_y = v0.pending_protocol_yield_y + v4 + (v2 as u64);
            v0.unrealized_lp_yield_y = 0;
            v0.pending_burn_y = 0;
            v0.undistributed_lp_yield_y = 0;
            v0.lp_cut_carry_y = 0;
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::reset(&mut v0.lp_yield_growth_y);
        } else if (v2 > 0 && v4 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::advance(&mut v0.lp_yield_growth_y, v2, v2 + (v4 as u128));
            if (v0.lp_yield_growth_y != v0.lp_yield_growth_y) {
                let v7 = &mut v0.unrealized_lp_yield_y;
                let v8 = &mut v0.pending_burn_y;
                adjust_deferred(v7, v8, v4, 0);
                v0.undistributed_lp_yield_y = 0;
            };
        };
    }

    fun emit_reward_harvest<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg1 == 0 && arg2 == 0) {
            return
        };
        let v0 = LendingRewardHarvestEvent{
            pool_id         : arg0,
            reward_type     : 0x1::type_name::with_defining_ids<T0>(),
            amount_x_market : arg1,
            amount_y_market : arg2,
            amount          : arg1 + arg2,
            ts_ms           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LendingRewardHarvestEvent>(v0);
    }

    fun emit_yield_claimed_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = ProtocolYieldClaimedEvent{
            pool_id      : arg0,
            amount_x     : arg1,
            amount_y     : arg2,
            from_slack_x : arg3,
            from_slack_y : arg4,
            ts_ms        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ProtocolYieldClaimedEvent>(v0);
    }

    public fun external_reward_balance<T0>(arg0: &PoolLending) : u64 {
        let v0 = reward_balance_key<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.extra, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.extra, v0))
    }

    fun finalize_protocol_claim_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(arg2, 0x2::coin::value<T0>(&arg3));
        if (v0 > 0) {
            let (v1, _) = lp_entitlement(arg0, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(arg1), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(arg1));
            let v3 = (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<T0, T1>(arg1) as u128);
            let v4 = if (v3 > v1) {
                ((v3 - v1) as u64)
            } else {
                0
            };
            let v5 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v0, v4);
            if (v5 > 0) {
                0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_reserved_yield_x<T0, T1>(arg1, v5), arg4));
            };
        };
        let v6 = state_mut(arg0);
        record_yield_withdrawal_x(v6, 0x2::coin::value<T0>(&arg3));
        arg3
    }

    fun finalize_protocol_claim_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(arg2, 0x2::coin::value<T1>(&arg3));
        if (v0 > 0) {
            let (_, v2) = lp_entitlement(arg0, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_x<T0, T1>(arg1), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::claims_value_y<T0, T1>(arg1));
            let v3 = (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_y<T0, T1>(arg1) as u128);
            let v4 = if (v3 > v2) {
                ((v3 - v2) as u64)
            } else {
                0
            };
            let v5 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v0, v4);
            if (v5 > 0) {
                0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::withdraw_reserved_yield_y<T0, T1>(arg1, v5), arg4));
            };
        };
        let v6 = state_mut(arg0);
        record_yield_withdrawal_y(v6, 0x2::coin::value<T1>(&arg3));
        arg3
    }

    public fun force_recall<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg0, arg2);
        recall_one_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        recall_one_y<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
    }

    public fun force_recall_x_sui<T0>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_protocol(arg0, arg2);
        recall_one_x_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        recall_one_y<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3, arg5, arg7, arg8);
    }

    public fun init_lending(arg0: &mut PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: PoolLendingConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap), 602);
        validate_config(&arg3);
        let v0 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::create_position(arg1, arg4);
        let v1 = state_mut(arg0);
        0x1::option::fill<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&mut v1.position_cap, v0);
        0x1::option::fill<0x2::object::ID>(&mut v1.protocol_id, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg1));
        *config_mut(arg0) = arg3;
        let v2 = LendingInitializedEvent{
            pool_id     : arg2,
            market_id_x : market_id_x(&arg3),
            market_id_y : market_id_y(&arg3),
            position_id : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::position_id(&v0),
        };
        0x2::event::emit<LendingInitializedEvent>(v2);
        let v3 = LendingConfigUpdatedEvent{
            pool_id : arg2,
            config  : arg3,
        };
        0x2::event::emit<LendingConfigUpdatedEvent>(v3);
    }

    fun is_configured(arg0: &PoolLending) : bool {
        arg0.config.enable_x || arg0.config.enable_y
    }

    fun is_deploy_enabled(arg0: &PoolLending) : bool {
        is_configured(arg0) && !arg0.state.deploy_blocked
    }

    public fun is_enabled(arg0: &PoolLending) : bool {
        is_configured(arg0)
    }

    public fun is_initialized(arg0: &PoolLending) : bool {
        0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap)
    }

    fun is_recall_enabled(arg0: &PoolLending) : bool {
        is_configured(arg0)
    }

    public fun is_recall_needed(arg0: &PoolLending, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (!is_recall_enabled(arg0)) {
            return false
        };
        if (arg1 >= arg2) {
            return false
        };
        arg3 > 0
    }

    public fun jit_recall_if_short_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert_protocol(arg0, arg2);
        if (!is_recall_enabled(arg0)) {
            return 0
        };
        recall_core_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun jit_recall_if_short_x_sui<T0>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_protocol(arg0, arg2);
        if (!is_recall_enabled(arg0)) {
            return 0
        };
        recall_core_x_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun jit_recall_if_short_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert_protocol(arg0, arg2);
        if (!is_recall_enabled(arg0)) {
            return 0
        };
        recall_core_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun last_sync_ts_ms(arg0: &PoolLending) : u64 {
        state(arg0).last_sync_ts_ms
    }

    public fun lifetime_yield_x(arg0: &PoolLending) : u128 {
        state(arg0).lifetime_yield_x
    }

    public fun lifetime_yield_y(arg0: &PoolLending) : u128 {
        state(arg0).lifetime_yield_y
    }

    fun lp_cut(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((arg0 as u128), (arg1 as u128), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u128()) as u64)
    }

    fun lp_cut_carrying(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg1 == 0) {
            return (0, arg2)
        };
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u128();
        let v1 = (arg0 as u128) * (arg1 as u128) + (arg2 as u128);
        (((v1 / v0) as u64), ((v1 % v0) as u64))
    }

    public fun lp_entitlement(arg0: &PoolLending, arg1: u64, arg2: u64) : (u128, u128) {
        let v0 = state(arg0);
        ((arg1 as u128) + (v0.unrealized_lp_yield_x as u128) - (v0.pending_burn_x as u128) + (v0.undistributed_lp_yield_x as u128), (arg2 as u128) + (v0.unrealized_lp_yield_y as u128) - (v0.pending_burn_y as u128) + (v0.undistributed_lp_yield_y as u128))
    }

    public fun lp_yield_growth_x(arg0: &PoolLending) : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::Index {
        state(arg0).lp_yield_growth_x
    }

    public fun lp_yield_growth_y(arg0: &PoolLending) : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::Index {
        state(arg0).lp_yield_growth_y
    }

    public fun lp_yield_share_bps(arg0: &PoolLending) : u64 {
        config(arg0).lp_yield_share_bps
    }

    fun market_id_for_side(arg0: &PoolLendingConfig, arg1: bool) : u64 {
        if (arg1) {
            market_id_x(arg0)
        } else {
            market_id_y(arg0)
        }
    }

    fun market_id_x(arg0: &PoolLendingConfig) : u64 {
        arg0.market_id_x
    }

    fun market_id_y(arg0: &PoolLendingConfig) : u64 {
        arg0.market_id_y
    }

    fun new_state(arg0: &mut 0x2::tx_context::TxContext) : PoolLendingState {
        PoolLendingState{
            position_cap             : 0x1::option::none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(),
            protocol_id              : 0x1::option::none<0x2::object::ID>(),
            lifetime_yield_x         : 0,
            lifetime_yield_y         : 0,
            pending_protocol_yield_x : 0,
            pending_protocol_yield_y : 0,
            undistributed_lp_yield_x : 0,
            undistributed_lp_yield_y : 0,
            lp_cut_carry_x           : 0,
            lp_cut_carry_y           : 0,
            unrealized_lp_yield_x    : 0,
            unrealized_lp_yield_y    : 0,
            lp_yield_growth_x        : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::new(),
            lp_yield_growth_y        : 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::new(),
            last_sync_ts_ms          : 0,
            last_deploy_ts_ms        : 0,
            deploy_blocked           : false,
            pending_burn_x           : 0,
            pending_burn_y           : 0,
            extra                    : 0x2::bag::new(arg0),
        }
    }

    public fun pending_burn(arg0: &PoolLending) : (u64, u64) {
        (state(arg0).pending_burn_x, state(arg0).pending_burn_y)
    }

    public fun pending_protocol_yield_x(arg0: &PoolLending) : u64 {
        state(arg0).pending_protocol_yield_x
    }

    public fun pending_protocol_yield_y(arg0: &PoolLending) : u64 {
        state(arg0).pending_protocol_yield_y
    }

    public fun re_enable_deploys(arg0: &mut PoolLending, arg1: 0x2::object::ID) {
        state_mut(arg0).deploy_blocked = false;
        let v0 = LendingDeployBlockClearedEvent{pool_id: arg1};
        0x2::event::emit<LendingDeployBlockClearedEvent>(v0);
    }

    fun read_live_collateral(arg0: &PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert_protocol(arg0, arg1);
        0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::get_collateral_amount(arg1, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap), arg2, arg3)
    }

    fun read_position_live(arg0: &PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : (u64, u64) {
        assert_protocol(arg0, arg1);
        let v0 = state(arg0);
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v0.position_cap)) {
            return (0, 0)
        };
        let v1 = config(arg0);
        let v2 = market_id_x(v1);
        let v3 = market_id_y(v1);
        let v4 = v1.enable_x || v2 != 0;
        let v5 = v1.enable_y || v3 != 0;
        let v6 = 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v0.position_cap);
        let v7 = if (v4) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::get_collateral_amount(arg1, v6, v2, arg2)
        } else {
            0
        };
        let v8 = if (v5) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::get_collateral_amount(arg1, v6, v3, arg2)
        } else {
            0
        };
        (v7, v8)
    }

    fun recall_close_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = settle_recall_x<T0, T1>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1);
        if (v1 > 0 && v1 <= 64) {
            if (read_live_collateral(arg0, arg2, arg5, arg6) == 0) {
                cover_full_drain_dust_x<T0, T1>(arg0, arg1, arg4, 0x2::clock::timestamp_ms(arg6));
            };
        };
        v0
    }

    fun recall_close_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = settle_recall_y<T0, T1>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1);
        if (v1 > 0 && v1 <= 64) {
            if (read_live_collateral(arg0, arg2, arg5, arg6) == 0) {
                cover_full_drain_dust_y<T0, T1>(arg0, arg1, arg4, 0x2::clock::timestamp_ms(arg6));
            };
        };
        v0
    }

    fun recall_core_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = recall_open(arg0, arg2, arg4, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<T0, T1>(arg1), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1), true, arg5);
        if (v1 == 0) {
            if (v0 != 0 && v2 == 0) {
                cover_full_drain_dust_x<T0, T1>(arg0, arg1, arg3, 0x2::clock::timestamp_ms(arg5));
            };
            return 0
        };
        let v3 = state_mut(arg0);
        let v4 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::remove_and_fulfill<T0>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap), v0, v1, arg5, arg6);
        recall_close_x<T0, T1>(arg0, arg1, arg2, v4, arg3, v0, arg5)
    }

    fun recall_core_x_sui<T0>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = recall_open(arg0, arg2, arg4, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<0x2::sui::SUI, T0>(arg1), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<0x2::sui::SUI, T0>(arg1), true, arg6);
        if (v1 == 0) {
            if (v0 != 0 && v2 == 0) {
                cover_full_drain_dust_x<0x2::sui::SUI, T0>(arg0, arg1, arg3, 0x2::clock::timestamp_ms(arg6));
            };
            return 0
        };
        let v3 = state_mut(arg0);
        let v4 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::remove_and_fulfill_sui(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap), v0, v1, arg5, arg6, arg7);
        recall_close_x<0x2::sui::SUI, T0>(arg0, arg1, arg2, v4, arg3, v0, arg6)
    }

    fun recall_core_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = recall_open(arg0, arg2, arg4, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_y<T0, T1>(arg1), 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1), false, arg5);
        if (v1 == 0) {
            if (v0 != 0 && v2 == 0) {
                cover_full_drain_dust_y<T0, T1>(arg0, arg1, arg3, 0x2::clock::timestamp_ms(arg5));
            };
            return 0
        };
        let v3 = state_mut(arg0);
        let v4 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::remove_and_fulfill<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v3.position_cap), v0, v1, arg5, arg6);
        recall_close_y<T0, T1>(arg0, arg1, arg2, v4, arg3, v0, arg5)
    }

    fun recall_one_need(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 18446744073709551615) {
            18446744073709551615
        } else {
            0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(arg0, arg1)
        }
    }

    fun recall_one_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0) {
            return
        };
        let v0 = recall_one_need(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<T0, T1>(arg1), arg4);
        recall_core_x<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
    }

    fun recall_one_x_sui<T0>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0) {
            return
        };
        let v0 = recall_one_need(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_x<0x2::sui::SUI, T0>(arg1), arg4);
        recall_core_x_sui<T0>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7);
    }

    fun recall_one_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0) {
            return
        };
        let v0 = recall_one_need(0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::idle_value_y<T0, T1>(arg1), arg4);
        recall_core_y<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
    }

    fun recall_open(arg0: &PoolLending, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64, u64) {
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        if (arg3 >= arg2) {
            return (0, 0, 0)
        };
        let (v0, v1, v2) = recall_plan(arg0, arg3, arg2, arg4, arg5);
        if (!v0) {
            return (0, 0, 0)
        };
        let v3 = read_live_collateral(arg0, arg1, v1, arg6);
        let v4 = if (v3 == 0) {
            0
        } else if (v2 >= v3) {
            18446744073709551615
        } else {
            v2
        };
        (v1, v4, v3)
    }

    fun recall_plan(arg0: &PoolLending, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (bool, u64, u64) {
        let v0 = config(arg0);
        let v1 = state(arg0);
        let v2 = market_id_for_side(v0, arg4);
        let v3 = arg4 && (v0.enable_x || v0.market_id_x != 0) || v0.enable_y || v0.market_id_y != 0;
        let v4 = if (!v3) {
            true
        } else if (v2 == 0) {
            true
        } else if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap)) {
            true
        } else {
            arg3 == 0
        };
        if (v4) {
            return (false, 0, 0)
        };
        (true, v2, recall_pull_amount(arg0, arg1, arg2, arg3, arg4))
    }

    fun recall_pull_amount(arg0: &PoolLending, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg2 == 18446744073709551615) {
            return arg2
        };
        let v0 = if (arg4) {
            config(arg0).buffer_bps_x
        } else {
            config(arg0).buffer_bps_y
        };
        let v1 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor((arg1 as u128) + (arg3 as u128), (v0 as u128), 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u128());
        let v2 = if (v1 > 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::max_u64_as_u128()) {
            18446744073709551615
        } else {
            (v1 as u64)
        };
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(arg2 - arg1, v2), 64), arg3)
    }

    fun record_yield_withdrawal_x(arg0: &mut PoolLendingState, arg1: u64) {
        arg0.pending_protocol_yield_x = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(arg0.pending_protocol_yield_x, arg1);
    }

    fun record_yield_withdrawal_y(arg0: &mut PoolLendingState, arg1: u64) {
        arg0.pending_protocol_yield_y = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(arg0.pending_protocol_yield_y, arg1);
    }

    fun reward_balance_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    fun reward_harvest_plan(arg0: &PoolLending) : (bool, bool, u64, u64, bool, bool) {
        let v0 = config(arg0);
        (v0.enable_x, v0.enable_y, market_id_x(v0), market_id_y(v0), v0.rewards_enabled, 0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap))
    }

    public fun rounding_tolerance() : u64 {
        64
    }

    fun settle_protocol_claim_recall_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1);
        let v2 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(v0, v1);
        let v3 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(arg2, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(state(arg0).pending_protocol_yield_x, v2 - lp_cut(v2, lp_yield_share_bps(arg0))));
        let v4 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v3, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v0, v1));
        let v5 = 0x2::coin::split<T0>(&mut arg3, v4, arg4);
        if (v4 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_x<T0, T1>(arg1, v4);
        };
        bank_recall_surplus(arg0, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::recall_x<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg3)), 0);
        let v6 = finalize_protocol_claim_x<T0, T1>(arg0, arg1, v3, v5, arg4);
        (v6, 0x2::coin::value<T0>(&v6) - v4)
    }

    fun settle_protocol_claim_recall_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1);
        let v2 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_sub_u64(v0, v1);
        let v3 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(arg2, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::saturating_add_u64(state(arg0).pending_protocol_yield_y, v2 - lp_cut(v2, lp_yield_share_bps(arg0))));
        let v4 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v3, 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v0, v1));
        let v5 = 0x2::coin::split<T1>(&mut arg3, v4, arg4);
        if (v4 > 0) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::reduce_deployed_y<T0, T1>(arg1, v4);
        };
        bank_recall_surplus(arg0, 0, 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::recall_y<T0, T1>(arg1, 0x2::coin::into_balance<T1>(arg3)));
        let v6 = finalize_protocol_claim_y<T0, T1>(arg0, arg1, v3, v5, arg4);
        (v6, 0x2::coin::value<T1>(&v6) - v4)
    }

    fun settle_recall_x<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::object::ID, arg4: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::recall_x<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg2));
        bank_recall_surplus(arg0, v1, 0);
        let v2 = LendingRecallEvent{
            pool_id  : arg3,
            amount_x : v0,
            amount_y : 0,
            surplus  : v1,
            ts_ms    : arg4,
        };
        0x2::event::emit<LendingRecallEvent>(v2);
        v0
    }

    fun settle_recall_y<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: u64) : u64 {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::recall_y<T0, T1>(arg1, 0x2::coin::into_balance<T1>(arg2));
        bank_recall_surplus(arg0, 0, v1);
        let v2 = LendingRecallEvent{
            pool_id  : arg3,
            amount_x : 0,
            amount_y : v0,
            surplus  : v1,
            ts_ms    : arg4,
        };
        0x2::event::emit<LendingRecallEvent>(v2);
        v0
    }

    fun snapshot_yield_pull<T0, T1>(arg0: &PoolLending, arg1: &0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>) : (u64, u64, u64, u64) {
        let v0 = config(arg0);
        let v1 = state(arg0);
        let v2 = 0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap);
        let v3 = !v2 && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1) == 0;
        let v4 = !v2 && 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1) == 0;
        let v5 = if (v0.enable_x && v2) {
            v1.pending_protocol_yield_x
        } else if (v3) {
            v1.pending_protocol_yield_x
        } else {
            0
        };
        let v6 = if (v0.enable_y && v2) {
            v1.pending_protocol_yield_y
        } else if (v4) {
            v1.pending_protocol_yield_y
        } else {
            0
        };
        (v5, v6, market_id_x(v0), market_id_y(v0))
    }

    fun socialize_side_gap(arg0: &mut PoolLendingState, arg1: bool, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = if (arg1) {
            arg0.pending_protocol_yield_x
        } else {
            arg0.pending_protocol_yield_y
        };
        let v1 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v0, arg2);
        if (arg1) {
            arg0.pending_protocol_yield_x = v0 - v1;
        } else {
            arg0.pending_protocol_yield_y = v0 - v1;
        };
        let v2 = arg2 - v1;
        let v3 = if (arg1) {
            arg0.undistributed_lp_yield_x
        } else {
            arg0.undistributed_lp_yield_y
        };
        let v4 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::min_u64(v3, v2);
        if (arg1) {
            arg0.undistributed_lp_yield_x = v3 - v4;
        } else {
            arg0.undistributed_lp_yield_y = v3 - v4;
        };
        let v5 = v2 - v4;
        let v6 = if (arg1) {
            arg0.unrealized_lp_yield_x
        } else {
            arg0.unrealized_lp_yield_y
        };
        let v7 = if (arg1) {
            arg0.pending_burn_x
        } else {
            arg0.pending_burn_y
        };
        let v8 = (arg3 as u128) + (v6 as u128) - (v7 as u128);
        let v9 = if ((v5 as u128) < v8) {
            v5
        } else {
            (v8 as u64)
        };
        if (v9 > 0) {
            if (arg1) {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::advance(&mut arg0.lp_yield_growth_x, v8, v8 - (v9 as u128));
                let v10 = &mut arg0.unrealized_lp_yield_x;
                let v11 = &mut arg0.pending_burn_x;
                adjust_deferred(v10, v11, 0, v9);
            } else {
                0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::yield_index::advance(&mut arg0.lp_yield_growth_y, v8, v8 - (v9 as u128));
                let v12 = &mut arg0.unrealized_lp_yield_y;
                let v13 = &mut arg0.pending_burn_y;
                adjust_deferred(v12, v13, 0, v9);
            };
        };
        (v1, v4, v9)
    }

    fun state(arg0: &PoolLending) : &PoolLendingState {
        &arg0.state
    }

    fun state_mut(arg0: &mut PoolLending) : &mut PoolLendingState {
        &mut arg0.state
    }

    public fun sync<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert_protocol(arg0, arg2);
        if (!is_configured(arg0)) {
            return
        };
        let v0 = config(arg0);
        let v1 = state(arg0);
        let v2 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1);
        let v3 = 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1);
        let v4 = if (v0.enable_x && 0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::get_collateral_amount(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap), market_id_x(v0), arg4)
        } else {
            v2
        };
        let v5 = if (v0.enable_y && 0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v1.position_cap)) {
            0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::alphalend_adapter::get_collateral_amount(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap), market_id_y(v0), arg4)
        } else {
            v3
        };
        apply_sync<T0, T1>(arg0, arg1, arg3, 0x2::clock::timestamp_ms(arg4), v0.lp_yield_share_bps, v2, v3, v4, v5);
    }

    public fun unrealized_lp_yield(arg0: &PoolLending) : (u64, u64) {
        let v0 = state(arg0);
        (v0.unrealized_lp_yield_x, v0.unrealized_lp_yield_y)
    }

    public fun update_config<T0, T1>(arg0: &mut PoolLending, arg1: &mut 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::Custody<T0, T1>, arg2: 0x2::object::ID, arg3: PoolLendingConfig) {
        let v0 = config(arg0);
        let v1 = 0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&state(arg0).position_cap);
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_x<T0, T1>(arg1) > 0 && v0.enable_x) {
            assert!(arg3.enable_x && arg3.market_id_x == v0.market_id_x, 611);
        };
        if (0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody::deployed_y<T0, T1>(arg1) > 0 && v0.enable_y) {
            assert!(arg3.enable_y && arg3.market_id_y == v0.market_id_y, 611);
        };
        if (arg3.enable_x) {
            assert!(v1, 609);
        };
        if (arg3.enable_y) {
            assert!(v1, 609);
        };
        validate_config(&arg3);
        *config_mut(arg0) = arg3;
        let v2 = LendingConfigUpdatedEvent{
            pool_id : arg2,
            config  : arg3,
        };
        0x2::event::emit<LendingConfigUpdatedEvent>(v2);
    }

    fun validate_config(arg0: &PoolLendingConfig) {
        let v0 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::constants::bps_denominator_u64();
        assert!(arg0.buffer_bps_x <= v0, 607);
        assert!(arg0.buffer_bps_y <= v0, 607);
        assert!(arg0.max_lend_bps_x <= v0, 607);
        assert!(arg0.max_lend_bps_y <= v0, 607);
        assert!(arg0.buffer_bps_x + arg0.max_lend_bps_x <= 9500, 607);
        assert!(arg0.buffer_bps_y + arg0.max_lend_bps_y <= 9500, 607);
        assert!(arg0.lp_yield_share_bps >= 5000 && arg0.lp_yield_share_bps <= v0, 607);
        if (arg0.enable_x && arg0.enable_y) {
            assert!(arg0.market_id_x != arg0.market_id_y, 612);
        };
        if (arg0.enable_x) {
            assert!(arg0.market_id_x != 0, 607);
        };
        if (arg0.enable_y) {
            assert!(arg0.market_id_y != 0, 607);
        };
    }

    fun write_off_side_residue(arg0: &mut PoolLendingState, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let (v0, v1, v2) = socialize_side_gap(arg0, arg2, arg3, arg4);
        let v3 = LendingResidueWrittenOffEvent{
            pool_id       : arg1,
            side_x        : arg2,
            amount        : arg3,
            from_protocol : v0,
            from_parked   : v1,
            lp_loss       : v2,
            ts_ms         : arg5,
        };
        0x2::event::emit<LendingResidueWrittenOffEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

