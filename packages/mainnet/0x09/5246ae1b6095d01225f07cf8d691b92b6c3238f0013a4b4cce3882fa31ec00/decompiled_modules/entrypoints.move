module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        state: 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::VaultState,
        oracle: 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::OracleState,
        treasury: 0x2::balance::Balance<T0>,
        cetus_balance: 0x2::balance::Balance<T0>,
        yield_balance: 0x2::balance::Balance<T0>,
        hedge_margin_balance: 0x2::balance::Balance<T0>,
        cetus_pool_id: address,
        cetus_deployed_usdc: u64,
        cetus_last_rebalance_ts_ms: u64,
        yield_receipt_id: address,
        yield_deployed_usdc: u64,
        yield_last_rebalance_ts_ms: u64,
        live_yield_address_slots: vector<address>,
        live_yield_metric_slots: vector<u64>,
        pilot_address_slots: vector<address>,
        pilot_metric_slots: vector<u64>,
        hedge_position_id: address,
        hedge_notional_usdc: u64,
        hedge_margin_usdc: u64,
        hedge_last_rebalance_ts_ms: u64,
        live_cetus_enabled: bool,
        live_cetus_position_present: bool,
        live_cetus_last_position_id: address,
        live_cetus_last_principal_a: u64,
        live_cetus_last_principal_b: u64,
        live_cetus_last_snapshot_ts_ms: u64,
        live_cetus_last_action_code: u64,
        last_rebalance_used_flash: bool,
        sdye_treasury: 0x2::coin::TreasuryCap<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>,
    }

    struct DepositEvent has copy, drop, store {
        sender: address,
        assets_in: u64,
        shares_out: u64,
    }

    struct WithdrawRequestedEvent has copy, drop, store {
        sender: address,
        request_id: u64,
        shares: u64,
        queued: bool,
        instant_assets_out: u64,
    }

    struct ClaimedEvent has copy, drop, store {
        sender: address,
        request_id: u64,
        assets_out: u64,
    }

    struct CycleEvent has copy, drop, store {
        spot_price: u64,
        moved_usdc: u64,
        bounty_usdc: u64,
        regime_code: u64,
        only_unwind: bool,
        safe_cycles_since_storm: u64,
        total_assets: u64,
        treasury_usdc: u64,
        deployed_usdc: u64,
        ready_usdc: u64,
        pending_usdc: u64,
        used_flash: bool,
    }

    struct PilotControlsUpdatedEvent has copy, drop, store {
        operator: address,
        deposits_paused: bool,
        allowlist_enabled: bool,
        max_total_assets: u64,
        cycle_paused: bool,
        allowlist_len: u64,
    }

    struct StrategyPlannedEvent has copy, drop, store {
        lp_action: u64,
        lp_reason: u64,
        yield_action: u64,
        yield_reason: u64,
        hedge_action: u64,
        hedge_reason: u64,
        target_lp_usdc: u64,
        target_yield_usdc: u64,
        target_hedge_usdc: u64,
        current_lp_usdc: u64,
        current_yield_usdc: u64,
        current_hedge_usdc: u64,
        reserve_target_usdc: u64,
        queue_pressure_bps: u64,
        queued_need_usdc: u64,
        oracle_snapshot_count: u64,
        oracle_volatility_bps: u64,
        oracle_confidence_bps: u64,
        oracle_effective_volatility_bps: u64,
        only_unwind: bool,
        live_cetus_position_present: bool,
        live_cetus_position_id: address,
        live_cetus_last_action_code: u64,
        live_cetus_amount_a: u64,
        live_cetus_amount_b: u64,
        live_yield_position_present: bool,
        live_hedge_position_present: bool,
    }

    struct StrategyPlan has copy, drop, store {
        lp_action: u64,
        lp_reason: u64,
        yield_action: u64,
        yield_reason: u64,
        hedge_action: u64,
        hedge_reason: u64,
        target_lp_usdc: u64,
        target_yield_usdc: u64,
        target_hedge_usdc: u64,
        current_lp_usdc: u64,
        current_yield_usdc: u64,
        current_hedge_usdc: u64,
        reserve_target_usdc: u64,
        queue_pressure_bps: u64,
        queued_need_usdc: u64,
        oracle_snapshot_count: u64,
        oracle_volatility_bps: u64,
        oracle_confidence_bps: u64,
        oracle_effective_volatility_bps: u64,
        only_unwind: bool,
        live_cetus_position_present: bool,
        live_cetus_position_id: address,
        live_cetus_last_action_code: u64,
        live_cetus_amount_a: u64,
        live_cetus_amount_b: u64,
        live_yield_position_present: bool,
        live_hedge_position_present: bool,
    }

    struct CetusPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun cetus_pool_id<T0>(arg0: &Vault<T0>) : address {
        arg0.cetus_pool_id
    }

    fun assert_deposit_allowed_internal<T0>(arg0: &Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(!pilot_deposits_paused<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_deposits_paused());
        let v0 = 0x2::tx_context::sender(arg2);
        if (pilot_allowlist_enabled<T0>(arg0)) {
            assert!(v0 == pilot_operator<T0>(arg0) || pilot_allowlist_contains_internal<T0>(arg0, v0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_not_allowlisted());
        };
        let v1 = pilot_max_total_assets<T0>(arg0);
        if (v1 > 0) {
            assert!(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_assets(&arg0.state), arg1) <= v1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_tvl_cap_exceeded());
        };
    }

    public fun assert_operator_if_configured<T0>(arg0: &Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_operator_if_configured_internal<T0>(arg0, arg1);
    }

    fun assert_operator_if_configured_internal<T0>(arg0: &Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = pilot_operator<T0>(arg0);
        if (v0 != @0x0) {
            assert!(0x2::tx_context::sender(arg1) == v0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_not_operator());
        };
    }

    fun assert_vault_synced<T0>(arg0: &Vault<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg0.treasury);
        let v1 = 0x2::balance::value<T0>(&arg0.cetus_balance);
        let v2 = 0x2::balance::value<T0>(&arg0.yield_balance);
        let v3 = 0x2::balance::value<T0>(&arg0.hedge_margin_balance);
        assert!(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::treasury_usdc(&arg0.state) == v0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        assert!(arg0.cetus_deployed_usdc == v1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        assert!(arg0.yield_deployed_usdc == v2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        assert!(arg0.hedge_margin_usdc == v3, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        assert!(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_assets(&arg0.state) == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(v0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(v1, v2), v3)), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
    }

    fun bool_to_u64(arg0: bool) : u64 {
        if (arg0) {
            1
        } else {
            0
        }
    }

    public fun bootstrap<T0>(arg0: 0x2::coin::TreasuryCap<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::new(arg1, arg2, arg3);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        let v4 = Vault<T0>{
            id                             : 0x2::object::new(arg3),
            state                          : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::new_state(),
            oracle                         : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::new(),
            treasury                       : 0x2::balance::zero<T0>(),
            cetus_balance                  : 0x2::balance::zero<T0>(),
            yield_balance                  : 0x2::balance::zero<T0>(),
            hedge_margin_balance           : 0x2::balance::zero<T0>(),
            cetus_pool_id                  : @0x0,
            cetus_deployed_usdc            : 0,
            cetus_last_rebalance_ts_ms     : 0,
            yield_receipt_id               : @0x0,
            yield_deployed_usdc            : 0,
            yield_last_rebalance_ts_ms     : 0,
            live_yield_address_slots       : vector[@0x0, @0x0],
            live_yield_metric_slots        : v2,
            pilot_address_slots            : vector[@0x0],
            pilot_metric_slots             : vector[0, 0, 0, 0],
            hedge_position_id              : @0x0,
            hedge_notional_usdc            : 0,
            hedge_margin_usdc              : 0,
            hedge_last_rebalance_ts_ms     : 0,
            live_cetus_enabled             : false,
            live_cetus_position_present    : false,
            live_cetus_last_position_id    : @0x0,
            live_cetus_last_principal_a    : 0,
            live_cetus_last_principal_b    : 0,
            live_cetus_last_snapshot_ts_ms : 0,
            live_cetus_last_action_code    : 0,
            last_rebalance_used_flash      : false,
            sdye_treasury                  : arg0,
        };
        0x2::transfer::share_object<Vault<T0>>(v4);
        0x2::transfer::public_share_object<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue>(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::new_queue(arg3));
        0x2::transfer::public_share_object<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config>(v0);
        0x2::transfer::public_transfer<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun bootstrap_pilot<T0>(arg0: 0x2::coin::TreasuryCap<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::new(arg1, arg2, arg7);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, arg3);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, arg6);
        0x1::vector::push_back<u64>(v6, arg5);
        0x1::vector::push_back<u64>(v6, arg4);
        0x1::vector::push_back<u64>(v6, 0);
        let v7 = Vault<T0>{
            id                             : 0x2::object::new(arg7),
            state                          : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::new_state(),
            oracle                         : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::new(),
            treasury                       : 0x2::balance::zero<T0>(),
            cetus_balance                  : 0x2::balance::zero<T0>(),
            yield_balance                  : 0x2::balance::zero<T0>(),
            hedge_margin_balance           : 0x2::balance::zero<T0>(),
            cetus_pool_id                  : @0x0,
            cetus_deployed_usdc            : 0,
            cetus_last_rebalance_ts_ms     : 0,
            yield_receipt_id               : @0x0,
            yield_deployed_usdc            : 0,
            yield_last_rebalance_ts_ms     : 0,
            live_yield_address_slots       : vector[@0x0, @0x0],
            live_yield_metric_slots        : v2,
            pilot_address_slots            : v4,
            pilot_metric_slots             : v5,
            hedge_position_id              : @0x0,
            hedge_notional_usdc            : 0,
            hedge_margin_usdc              : 0,
            hedge_last_rebalance_ts_ms     : 0,
            live_cetus_enabled             : false,
            live_cetus_position_present    : false,
            live_cetus_last_position_id    : @0x0,
            live_cetus_last_principal_a    : 0,
            live_cetus_last_principal_b    : 0,
            live_cetus_last_snapshot_ts_ms : 0,
            live_cetus_last_action_code    : 0,
            last_rebalance_used_flash      : false,
            sdye_treasury                  : arg0,
        };
        0x2::transfer::share_object<Vault<T0>>(v7);
        0x2::transfer::public_share_object<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue>(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::new_queue(arg7));
        0x2::transfer::public_share_object<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config>(v0);
        0x2::transfer::public_transfer<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap>(v1, 0x2::tx_context::sender(arg7));
    }

    public(friend) fun borrow_stored_cetus_position<T0>(arg0: &Vault<T0>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!(has_stored_cetus_position<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_missing_object());
        0x2::dynamic_object_field::borrow<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, cetus_position_key())
    }

    public(friend) fun borrow_stored_cetus_position_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!(has_stored_cetus_position<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_missing_object());
        0x2::dynamic_object_field::borrow_mut<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, cetus_position_key())
    }

    fun build_strategy_plan<T0>(arg0: &Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : StrategyPlan {
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_assets(&arg0.state);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_ready_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1));
        let v2 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_pending_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1));
        let v3 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::current_regime(&arg0.oracle);
        let (_, _, v6) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::get_allocation(&v3);
        let (v7, v8, v9) = target_strategy_mix<T0>(arg0, arg1, arg2);
        let v10 = 0x2::balance::value<T0>(&arg0.cetus_balance);
        let v11 = 0x2::balance::value<T0>(&arg0.yield_balance);
        let v12 = 0x2::balance::value<T0>(&arg0.hedge_margin_balance);
        let v13 = is_only_unwind_mode<T0>(arg0);
        let v14 = has_stored_cetus_position<T0>(arg0);
        let v15 = live_yield_position_present<T0>(arg0);
        let v16 = hedge_position_present<T0>(arg0);
        let v17 = if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::should_close_live_position(v14, v13, treasury_usdc<T0>(arg0), v1, v2)) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close()
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_strategy_action(v10, v7, v14)
        };
        let v18 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::strategy_leg_action(v11, v8, v15);
        let v19 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::strategy_leg_action(v12, v9, v16);
        let v20 = if (v14) {
            stored_cetus_position_id<T0>(arg0)
        } else {
            @0x0
        };
        StrategyPlan{
            lp_action                       : v17,
            lp_reason                       : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_strategy_reason(v14, v13, treasury_usdc<T0>(arg0), v1, v2, v10, v7),
            yield_action                    : v18,
            yield_reason                    : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::strategy_leg_reason(v18),
            hedge_action                    : v19,
            hedge_reason                    : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::strategy_leg_reason(v19),
            target_lp_usdc                  : v7,
            target_yield_usdc               : v8,
            target_hedge_usdc               : v9,
            current_lp_usdc                 : v10,
            current_yield_usdc              : v11,
            current_hedge_usdc              : v12,
            reserve_target_usdc             : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::reserve_target_usdc(v6, v0, v1, v2),
            queue_pressure_bps              : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::queue_pressure_score_bps(v0, v1, v2),
            queued_need_usdc                : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(v1, v2),
            oracle_snapshot_count           : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::snapshot_count(&arg0.oracle),
            oracle_volatility_bps           : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::current_volatility_bps(&arg0.oracle),
            oracle_confidence_bps           : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::current_confidence_bps(&arg0.oracle),
            oracle_effective_volatility_bps : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::current_effective_volatility_bps(&arg0.oracle),
            only_unwind                     : v13,
            live_cetus_position_present     : v14,
            live_cetus_position_id          : v20,
            live_cetus_last_action_code     : arg0.live_cetus_last_action_code,
            live_cetus_amount_a             : arg0.live_cetus_last_principal_a,
            live_cetus_amount_b             : arg0.live_cetus_last_principal_b,
            live_yield_position_present     : v15,
            live_hedge_position_present     : v16,
        }
    }

    public fun cetus_deployed_usdc<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cetus_deployed_usdc
    }

    public fun cetus_last_rebalance_ts_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cetus_last_rebalance_ts_ms
    }

    fun cetus_position_key() : CetusPositionKey {
        CetusPositionKey{dummy_field: false}
    }

    public fun claim<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::claim(&mut arg0.state, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state_mut(arg1), arg2, v0);
        assert!(0x2::coin::burn<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>(&mut arg0.sdye_treasury, 0x2::coin::from_balance<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::take_locked_shares(arg1, arg2), arg4)) > 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        assert_vault_synced<T0>(arg0);
        let v2 = ClaimedEvent{
            sender     : v0,
            request_id : arg2,
            assets_out : v1,
        };
        0x2::event::emit<ClaimedEvent>(v2);
        0x2::coin::take<T0>(&mut arg0.treasury, v1, arg4)
    }

    public fun claim_entry<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun cycle<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        cycle_with_confidence<T0>(arg0, arg1, arg2, arg3, 0, arg4, arg5)
    }

    public fun cycle_entry<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = cycle<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v2), 0x2::tx_context::sender(arg5));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
        };
    }

    public fun cycle_with_confidence<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        assert_operator_if_configured_internal<T0>(arg0, arg6);
        assert!(!pilot_cycle_paused<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_cycle_paused());
        assert_vault_synced<T0>(arg0);
        unwind_to_cover_liquidity<T0>(arg0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_ready_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1)), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_pending_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1))));
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let (v1, v2) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::cycle_with_confidence(&mut arg0.state, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state_mut(arg1), &mut arg0.oracle, arg3, arg4, v0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::min_cycle_interval_ms(arg2), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::min_snapshot_interval_ms(arg2));
        let v3 = if (v2 > 0) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v2, arg6))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v4 = build_strategy_plan<T0>(arg0, arg1, arg2);
        emit_strategy_plan_event(&v4);
        rebalance_strategy_accounting<T0>(arg0, arg1, arg2, v0);
        assert_vault_synced<T0>(arg0);
        let v5 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::current_regime(&arg0.oracle);
        let v6 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::risk_mode(&arg0.state);
        let v7 = CycleEvent{
            spot_price              : arg3,
            moved_usdc              : v1,
            bounty_usdc             : v2,
            regime_code             : regime_code(&v5),
            only_unwind             : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::is_only_unwind(&v6),
            safe_cycles_since_storm : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::safe_cycles_since_storm(&arg0.state),
            total_assets            : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_assets(&arg0.state),
            treasury_usdc           : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::treasury_usdc(&arg0.state),
            deployed_usdc           : total_deployed_internal<T0>(arg0),
            ready_usdc              : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_ready_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1)),
            pending_usdc            : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_pending_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1)),
            used_flash              : arg0.last_rebalance_used_flash,
        };
        0x2::event::emit<CycleEvent>(v7);
        (v1, v3)
    }

    public fun cycle_with_confidence_entry<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = cycle_with_confidence<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v2), 0x2::tx_context::sender(arg6));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
        };
    }

    public fun deployed_balance<T0>(arg0: &Vault<T0>) : u64 {
        total_deployed_internal<T0>(arg0)
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_deposit_allowed_internal<T0>(arg0, v0, arg3);
        0x2::coin::put<T0>(&mut arg0.treasury, arg1);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::deposit(&mut arg0.state, v0);
        assert_vault_synced<T0>(arg0);
        let v2 = DepositEvent{
            sender     : 0x2::tx_context::sender(arg3),
            assets_in  : v0,
            shares_out : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::mint_shares(&mut arg0.sdye_treasury, v1, arg3)
    }

    public fun deposit_entry<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun emit_pilot_controls_updated_internal<T0>(arg0: &Vault<T0>) {
        let v0 = PilotControlsUpdatedEvent{
            operator          : pilot_operator<T0>(arg0),
            deposits_paused   : pilot_deposits_paused<T0>(arg0),
            allowlist_enabled : pilot_allowlist_enabled<T0>(arg0),
            max_total_assets  : pilot_max_total_assets<T0>(arg0),
            cycle_paused      : pilot_cycle_paused<T0>(arg0),
            allowlist_len     : pilot_allowlist_len_internal<T0>(arg0),
        };
        0x2::event::emit<PilotControlsUpdatedEvent>(v0);
    }

    fun emit_strategy_plan_event(arg0: &StrategyPlan) {
        let v0 = StrategyPlannedEvent{
            lp_action                       : arg0.lp_action,
            lp_reason                       : arg0.lp_reason,
            yield_action                    : arg0.yield_action,
            yield_reason                    : arg0.yield_reason,
            hedge_action                    : arg0.hedge_action,
            hedge_reason                    : arg0.hedge_reason,
            target_lp_usdc                  : arg0.target_lp_usdc,
            target_yield_usdc               : arg0.target_yield_usdc,
            target_hedge_usdc               : arg0.target_hedge_usdc,
            current_lp_usdc                 : arg0.current_lp_usdc,
            current_yield_usdc              : arg0.current_yield_usdc,
            current_hedge_usdc              : arg0.current_hedge_usdc,
            reserve_target_usdc             : arg0.reserve_target_usdc,
            queue_pressure_bps              : arg0.queue_pressure_bps,
            queued_need_usdc                : arg0.queued_need_usdc,
            oracle_snapshot_count           : arg0.oracle_snapshot_count,
            oracle_volatility_bps           : arg0.oracle_volatility_bps,
            oracle_confidence_bps           : arg0.oracle_confidence_bps,
            oracle_effective_volatility_bps : arg0.oracle_effective_volatility_bps,
            only_unwind                     : arg0.only_unwind,
            live_cetus_position_present     : arg0.live_cetus_position_present,
            live_cetus_position_id          : arg0.live_cetus_position_id,
            live_cetus_last_action_code     : arg0.live_cetus_last_action_code,
            live_cetus_amount_a             : arg0.live_cetus_amount_a,
            live_cetus_amount_b             : arg0.live_cetus_amount_b,
            live_yield_position_present     : arg0.live_yield_position_present,
            live_hedge_position_present     : arg0.live_hedge_position_present,
        };
        0x2::event::emit<StrategyPlannedEvent>(v0);
    }

    public fun has_cetus_position<T0>(arg0: &Vault<T0>) : bool {
        arg0.cetus_deployed_usdc > 0
    }

    public fun has_stored_cetus_position<T0>(arg0: &Vault<T0>) : bool {
        0x2::dynamic_object_field::exists_<CetusPositionKey>(&arg0.id, cetus_position_key())
    }

    public fun hedge_margin_usdc<T0>(arg0: &Vault<T0>) : u64 {
        arg0.hedge_margin_usdc
    }

    public fun hedge_notional_usdc<T0>(arg0: &Vault<T0>) : u64 {
        arg0.hedge_notional_usdc
    }

    public fun hedge_position_id<T0>(arg0: &Vault<T0>) : address {
        arg0.hedge_position_id
    }

    fun hedge_position_present<T0>(arg0: &Vault<T0>) : bool {
        arg0.hedge_position_id != @0x0 || 0x2::balance::value<T0>(&arg0.hedge_margin_balance) > 0
    }

    public fun is_only_unwind_mode<T0>(arg0: &Vault<T0>) : bool {
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::risk_mode(&arg0.state);
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::is_only_unwind(&v0)
    }

    public fun last_rebalance_used_flash<T0>(arg0: &Vault<T0>) : bool {
        arg0.last_rebalance_used_flash
    }

    public fun live_cetus_action_add() : u64 {
        4
    }

    public fun live_cetus_action_close() : u64 {
        3
    }

    public fun live_cetus_action_hold() : u64 {
        2
    }

    public fun live_cetus_action_open() : u64 {
        1
    }

    public fun live_cetus_action_remove() : u64 {
        5
    }

    public fun live_cetus_enabled<T0>(arg0: &Vault<T0>) : bool {
        arg0.live_cetus_enabled
    }

    public fun live_cetus_last_action_code<T0>(arg0: &Vault<T0>) : u64 {
        arg0.live_cetus_last_action_code
    }

    public fun live_cetus_last_position_id<T0>(arg0: &Vault<T0>) : address {
        arg0.live_cetus_last_position_id
    }

    public fun live_cetus_last_principal_a<T0>(arg0: &Vault<T0>) : u64 {
        arg0.live_cetus_last_principal_a
    }

    public fun live_cetus_last_principal_b<T0>(arg0: &Vault<T0>) : u64 {
        arg0.live_cetus_last_principal_b
    }

    public fun live_cetus_last_snapshot_ts_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.live_cetus_last_snapshot_ts_ms
    }

    public fun live_cetus_position_present<T0>(arg0: &Vault<T0>) : bool {
        arg0.live_cetus_position_present
    }

    fun live_yield_address_slot<T0>(arg0: &Vault<T0>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.live_yield_address_slots, arg1)
    }

    public fun live_yield_enabled<T0>(arg0: &Vault<T0>) : bool {
        u64_to_bool(live_yield_metric_slot<T0>(arg0, 0))
    }

    public fun live_yield_last_action_code<T0>(arg0: &Vault<T0>) : u64 {
        live_yield_metric_slot<T0>(arg0, 5)
    }

    public fun live_yield_last_market_id<T0>(arg0: &Vault<T0>) : address {
        live_yield_address_slot<T0>(arg0, 0)
    }

    public fun live_yield_last_principal<T0>(arg0: &Vault<T0>) : u64 {
        live_yield_metric_slot<T0>(arg0, 2)
    }

    public fun live_yield_last_receipt_id<T0>(arg0: &Vault<T0>) : address {
        live_yield_address_slot<T0>(arg0, 1)
    }

    public fun live_yield_last_snapshot_ts_ms<T0>(arg0: &Vault<T0>) : u64 {
        live_yield_metric_slot<T0>(arg0, 4)
    }

    public fun live_yield_last_value<T0>(arg0: &Vault<T0>) : u64 {
        live_yield_metric_slot<T0>(arg0, 3)
    }

    fun live_yield_metric_slot<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.live_yield_metric_slots, arg1)
    }

    public fun live_yield_position_present<T0>(arg0: &Vault<T0>) : bool {
        u64_to_bool(live_yield_metric_slot<T0>(arg0, 1))
    }

    fun move_balance_to_treasury<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        if (arg2 > 0) {
            0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(arg0, arg2));
        };
    }

    fun move_treasury_to_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        if (arg2 > 0) {
            0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(arg0, arg2));
        };
    }

    public fun pilot_add_allowlist_address_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: address) {
        if (arg2 == @0x0) {
            return
        };
        if (pilot_allowlist_contains_internal<T0>(arg0, arg2)) {
            return
        };
        0x1::vector::push_back<address>(&mut arg0.pilot_address_slots, arg2);
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    fun pilot_address_slot<T0>(arg0: &Vault<T0>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.pilot_address_slots, arg1)
    }

    fun pilot_allowlist_contains_internal<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        let v0 = 0x1::vector::length<address>(&arg0.pilot_address_slots);
        if (v0 <= 1) {
            return false
        };
        let v1 = 1;
        while (v1 < v0) {
            if (*0x1::vector::borrow<address>(&arg0.pilot_address_slots, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun pilot_allowlist_enabled<T0>(arg0: &Vault<T0>) : bool {
        u64_to_bool(pilot_metric_slot<T0>(arg0, 1))
    }

    public fun pilot_allowlist_len<T0>(arg0: &Vault<T0>) : u64 {
        pilot_allowlist_len_internal<T0>(arg0)
    }

    fun pilot_allowlist_len_internal<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x1::vector::length<address>(&arg0.pilot_address_slots);
        if (v0 > 1) {
            v0 - 1
        } else {
            0
        }
    }

    public fun pilot_clear_allowlist_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap) {
        while (0x1::vector::length<address>(&arg0.pilot_address_slots) > 1) {
            0x1::vector::pop_back<address>(&mut arg0.pilot_address_slots);
        };
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    public fun pilot_cycle_paused<T0>(arg0: &Vault<T0>) : bool {
        u64_to_bool(pilot_metric_slot<T0>(arg0, 3))
    }

    public fun pilot_deposits_paused<T0>(arg0: &Vault<T0>) : bool {
        u64_to_bool(pilot_metric_slot<T0>(arg0, 0))
    }

    public fun pilot_max_total_assets<T0>(arg0: &Vault<T0>) : u64 {
        pilot_metric_slot<T0>(arg0, 2)
    }

    fun pilot_metric_slot<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.pilot_metric_slots, arg1)
    }

    public fun pilot_operator<T0>(arg0: &Vault<T0>) : address {
        pilot_address_slot<T0>(arg0, 0)
    }

    public fun pilot_remove_allowlist_address_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: address) {
        let v0 = 0x1::vector::length<address>(&arg0.pilot_address_slots);
        if (v0 <= 1) {
            return
        };
        let v1 = 1;
        while (v1 < v0) {
            if (*0x1::vector::borrow<address>(&arg0.pilot_address_slots, v1) == arg2) {
                0x1::vector::remove<address>(&mut arg0.pilot_address_slots, v1);
                emit_pilot_controls_updated_internal<T0>(arg0);
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun pilot_set_allowlist_enabled_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: bool) {
        set_pilot_metric_slot<T0>(arg0, 1, bool_to_u64(arg2));
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    public fun pilot_set_cycle_paused_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: bool) {
        set_pilot_metric_slot<T0>(arg0, 3, bool_to_u64(arg2));
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    public fun pilot_set_deposits_paused_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: bool) {
        set_pilot_metric_slot<T0>(arg0, 0, bool_to_u64(arg2));
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    public fun pilot_set_max_total_assets_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: u64) {
        set_pilot_metric_slot<T0>(arg0, 2, arg2);
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    public fun pilot_set_operator_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg2: address) {
        set_pilot_address_slot<T0>(arg0, 0, arg2);
        emit_pilot_controls_updated_internal<T0>(arg0);
    }

    fun rebalance_strategy_accounting<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: u64) {
        let v0 = if (!0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg2)) {
            if (!0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg2)) {
                !0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge::is_available(arg2)
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.last_rebalance_used_flash = false;
            sync_strategy_metadata<T0>(arg0, arg2, arg3);
            return
        };
        let v1 = build_strategy_plan<T0>(arg0, arg1, arg2);
        let v2 = if (v1.current_lp_usdc > v1.target_lp_usdc) {
            v1.current_lp_usdc - v1.target_lp_usdc
        } else {
            v1.target_lp_usdc - v1.current_lp_usdc
        };
        let v3 = if (v1.current_yield_usdc > v1.target_yield_usdc) {
            v1.current_yield_usdc - v1.target_yield_usdc
        } else {
            v1.target_yield_usdc - v1.current_yield_usdc
        };
        let v4 = if (v1.current_hedge_usdc > v1.target_hedge_usdc) {
            v1.current_hedge_usdc - v1.target_hedge_usdc
        } else {
            v1.target_hedge_usdc - v1.current_hedge_usdc
        };
        let v5 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(v2, v3), v4);
        arg0.last_rebalance_used_flash = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::rebalancer::rebalance_flash(arg2, v5);
        if (!arg0.last_rebalance_used_flash) {
        };
        if (v1.current_hedge_usdc > v1.target_hedge_usdc) {
            let v6 = &mut arg0.hedge_margin_balance;
            let v7 = &mut arg0.treasury;
            move_balance_to_treasury<T0>(v6, v7, v1.current_hedge_usdc - v1.target_hedge_usdc);
        };
        if (v1.current_yield_usdc > v1.target_yield_usdc) {
            let v8 = &mut arg0.yield_balance;
            let v9 = &mut arg0.treasury;
            move_balance_to_treasury<T0>(v8, v9, v1.current_yield_usdc - v1.target_yield_usdc);
        };
        if (!v1.live_cetus_position_present && v1.current_lp_usdc > v1.target_lp_usdc) {
            let v10 = &mut arg0.cetus_balance;
            let v11 = &mut arg0.treasury;
            move_balance_to_treasury<T0>(v10, v11, v1.current_lp_usdc - v1.target_lp_usdc);
        };
        let v12 = 0x2::balance::value<T0>(&arg0.cetus_balance);
        let v13 = 0x2::balance::value<T0>(&arg0.yield_balance);
        let v14 = 0x2::balance::value<T0>(&arg0.hedge_margin_balance);
        if (!v1.live_cetus_position_present && v12 < v1.target_lp_usdc) {
            let v15 = &mut arg0.treasury;
            let v16 = &mut arg0.cetus_balance;
            move_treasury_to_balance<T0>(v15, v16, v1.target_lp_usdc - v12);
        };
        if (v13 < v1.target_yield_usdc) {
            let v17 = &mut arg0.treasury;
            let v18 = &mut arg0.yield_balance;
            move_treasury_to_balance<T0>(v17, v18, v1.target_yield_usdc - v13);
        };
        if (v14 < v1.target_hedge_usdc) {
            let v19 = &mut arg0.treasury;
            let v20 = &mut arg0.hedge_margin_balance;
            move_treasury_to_balance<T0>(v19, v20, v1.target_hedge_usdc - v14);
        };
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::set_treasury_usdc_for_testing(&mut arg0.state, 0x2::balance::value<T0>(&arg0.treasury));
        if (v1.live_cetus_position_present && v1.lp_action == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_hold()) {
            record_cetus_live_hold<T0>(arg0, arg2, arg3);
        };
        sync_strategy_metadata<T0>(arg0, arg2, arg3);
    }

    public(friend) fun record_cetus_live_add<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        sync_cetus_live_presence<T0>(arg0, arg1);
        arg0.live_cetus_enabled = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg1);
        arg0.live_cetus_position_present = true;
        arg0.live_cetus_last_position_id = arg2;
        arg0.live_cetus_last_principal_a = arg3;
        arg0.live_cetus_last_principal_b = arg4;
        arg0.live_cetus_last_snapshot_ts_ms = arg5;
        arg0.live_cetus_last_action_code = 4;
    }

    public(friend) fun record_cetus_live_close<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64) {
        sync_cetus_live_presence<T0>(arg0, arg1);
        arg0.live_cetus_enabled = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg1);
        arg0.live_cetus_position_present = false;
        arg0.live_cetus_last_position_id = arg2;
        arg0.live_cetus_last_principal_a = 0;
        arg0.live_cetus_last_principal_b = 0;
        arg0.live_cetus_last_snapshot_ts_ms = arg3;
        arg0.live_cetus_last_action_code = 3;
    }

    public(friend) fun record_cetus_live_hold<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: u64) {
        sync_cetus_live_presence<T0>(arg0, arg1);
        if (arg0.live_cetus_position_present) {
            arg0.live_cetus_last_snapshot_ts_ms = arg2;
            arg0.live_cetus_last_action_code = 2;
        };
    }

    public(friend) fun record_cetus_live_open<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        sync_cetus_live_presence<T0>(arg0, arg1);
        arg0.live_cetus_enabled = true;
        arg0.live_cetus_position_present = true;
        arg0.live_cetus_last_position_id = arg2;
        arg0.live_cetus_last_principal_a = arg3;
        arg0.live_cetus_last_principal_b = arg4;
        arg0.live_cetus_last_snapshot_ts_ms = arg5;
        arg0.live_cetus_last_action_code = 1;
    }

    public(friend) fun record_cetus_live_remove<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        sync_cetus_live_presence<T0>(arg0, arg1);
        arg0.live_cetus_enabled = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg1);
        arg0.live_cetus_position_present = true;
        arg0.live_cetus_last_position_id = arg2;
        arg0.live_cetus_last_principal_a = arg3;
        arg0.live_cetus_last_principal_b = arg4;
        arg0.live_cetus_last_snapshot_ts_ms = arg5;
        arg0.live_cetus_last_action_code = 5;
    }

    public(friend) fun record_cetus_live_snapshot<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        sync_cetus_live_presence<T0>(arg0, arg1);
        arg0.live_cetus_enabled = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg1);
        arg0.live_cetus_position_present = true;
        arg0.live_cetus_last_position_id = arg2;
        arg0.live_cetus_last_principal_a = arg3;
        arg0.live_cetus_last_principal_b = arg4;
        arg0.live_cetus_last_snapshot_ts_ms = arg5;
        arg0.live_cetus_last_action_code = 2;
    }

    public(friend) fun record_live_yield_deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        sync_yield_live_presence<T0>(arg0, arg1);
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg1);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::normalize_live_receipt_id(arg1, arg2, arg4);
        let v2 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::principal_after_live_deposit(live_yield_metric_slot<T0>(arg0, 2), arg3);
        set_live_yield_metric_slot<T0>(arg0, 0, bool_to_u64(v0));
        let v3 = if (v0) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg1)
        } else {
            @0x0
        };
        set_live_yield_address_slot<T0>(arg0, 0, v3);
        set_live_yield_address_slot<T0>(arg0, 1, v1);
        set_live_yield_metric_slot<T0>(arg0, 1, bool_to_u64(v1 != @0x0));
        set_live_yield_metric_slot<T0>(arg0, 2, v2);
        set_live_yield_metric_slot<T0>(arg0, 3, arg4);
        set_live_yield_metric_slot<T0>(arg0, 4, arg5);
        set_live_yield_metric_slot<T0>(arg0, 5, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::live_yield_action_deposit());
        arg0.yield_receipt_id = v1;
        arg0.yield_last_rebalance_ts_ms = arg5;
    }

    public(friend) fun record_live_yield_hold<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64) {
        sync_yield_live_presence<T0>(arg0, arg1);
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg1);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::normalize_live_receipt_id(arg1, arg2, arg3);
        let v2 = v1 != @0x0;
        set_live_yield_metric_slot<T0>(arg0, 0, bool_to_u64(v0));
        let v3 = if (v0) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg1)
        } else {
            @0x0
        };
        set_live_yield_address_slot<T0>(arg0, 0, v3);
        set_live_yield_address_slot<T0>(arg0, 1, v1);
        set_live_yield_metric_slot<T0>(arg0, 1, bool_to_u64(v2));
        set_live_yield_metric_slot<T0>(arg0, 3, arg3);
        set_live_yield_metric_slot<T0>(arg0, 4, arg4);
        let v4 = if (v2) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::live_yield_action_hold()
        } else {
            0
        };
        set_live_yield_metric_slot<T0>(arg0, 5, v4);
        arg0.yield_receipt_id = v1;
        arg0.yield_last_rebalance_ts_ms = arg4;
    }

    public(friend) fun record_live_yield_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::principal_after_live_withdraw(live_yield_metric_slot<T0>(arg0, 2), live_yield_metric_slot<T0>(arg0, 3), arg3);
        sync_yield_live_presence<T0>(arg0, arg1);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg1);
        let v2 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::normalize_live_receipt_id(arg1, arg2, arg4);
        set_live_yield_metric_slot<T0>(arg0, 0, bool_to_u64(v1));
        let v3 = if (v1) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg1)
        } else {
            @0x0
        };
        set_live_yield_address_slot<T0>(arg0, 0, v3);
        set_live_yield_address_slot<T0>(arg0, 1, v2);
        set_live_yield_metric_slot<T0>(arg0, 1, bool_to_u64(v2 != @0x0));
        set_live_yield_metric_slot<T0>(arg0, 2, v0);
        set_live_yield_metric_slot<T0>(arg0, 3, arg4);
        set_live_yield_metric_slot<T0>(arg0, 4, arg5);
        let v4 = if (arg4 == 0) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::live_yield_action_withdraw_full()
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::live_yield_action_withdraw_partial()
        };
        set_live_yield_metric_slot<T0>(arg0, 5, v4);
        arg0.yield_receipt_id = v2;
        arg0.yield_last_rebalance_ts_ms = arg5;
    }

    fun regime_code(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::Regime) : u64 {
        if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::is_regime_calm(arg0)) {
            0
        } else if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::is_regime_normal(arg0)) {
            1
        } else {
            2
        }
    }

    public fun request_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: 0x2::coin::Coin<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::WithdrawPlan, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>(&arg2);
        let v2 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::request_withdraw(&mut arg0.state, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state_mut(arg1), v0, v1, 0x2::clock::timestamp_ms(arg3));
        if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::plan_is_instant(&v2)) {
            assert!(0x2::coin::burn<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>(&mut arg0.sdye_treasury, arg2) == v1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
            let v4 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::instant_usdc_out(&v2);
            assert_vault_synced<T0>(arg0);
            let v5 = WithdrawRequestedEvent{
                sender             : v0,
                request_id         : 0,
                shares             : v1,
                queued             : false,
                instant_assets_out : v4,
            };
            0x2::event::emit<WithdrawRequestedEvent>(v5);
            (v2, 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v4, arg4)))
        } else {
            let v6 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::queued_request_id(&v2);
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::lock_shares_for_new_request(arg1, v6, 0x2::coin::into_balance<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>(arg2));
            assert_vault_synced<T0>(arg0);
            let v7 = WithdrawRequestedEvent{
                sender             : v0,
                request_id         : v6,
                shares             : v1,
                queued             : true,
                instant_assets_out : 0,
            };
            0x2::event::emit<WithdrawRequestedEvent>(v7);
            (v2, 0x1::option::none<0x2::coin::Coin<T0>>())
        }
    }

    public fun request_withdraw_entry<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: 0x2::coin::Coin<0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye::SDYE>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = request_withdraw<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v2), 0x2::tx_context::sender(arg4));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
        };
    }

    public fun safe_cycles_since_storm<T0>(arg0: &Vault<T0>) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::safe_cycles_since_storm(&arg0.state)
    }

    fun set_live_yield_address_slot<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address) {
        *0x1::vector::borrow_mut<address>(&mut arg0.live_yield_address_slots, arg1) = arg2;
    }

    fun set_live_yield_metric_slot<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.live_yield_metric_slots, arg1) = arg2;
    }

    fun set_pilot_address_slot<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address) {
        *0x1::vector::borrow_mut<address>(&mut arg0.pilot_address_slots, arg1) = arg2;
    }

    fun set_pilot_metric_slot<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64) {
        *0x1::vector::borrow_mut<u64>(&mut arg0.pilot_metric_slots, arg1) = arg2;
    }

    public(friend) fun should_close_live_cetus_from_strategy<T0>(arg0: &Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : bool {
        let v0 = build_strategy_plan<T0>(arg0, arg1, arg2);
        v0.lp_action == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close()
    }

    public fun store_cetus_position<T0>(arg0: &mut Vault<T0>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        assert!(!has_stored_cetus_position<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_invalid_plan());
        0x2::dynamic_object_field::add<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, cetus_position_key(), arg1);
    }

    public fun stored_cetus_position_id<T0>(arg0: &Vault<T0>) : address {
        assert!(has_stored_cetus_position<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_missing_object());
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_object_field::borrow<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, cetus_position_key()));
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun strategy_plan_actions_for_testing<T0>(arg0: &Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : (u64, u64, u64, u64, u64, u64) {
        let v0 = build_strategy_plan<T0>(arg0, arg1, arg2);
        (v0.lp_action, v0.yield_action, v0.hedge_action, v0.target_lp_usdc, v0.target_yield_usdc, v0.target_hedge_usdc)
    }

    public(friend) fun strategy_plan_lp_for_testing<T0>(arg0: &Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : (u64, u64, u64, u64, u64, u64) {
        let v0 = build_strategy_plan<T0>(arg0, arg1, arg2);
        (v0.lp_action, v0.lp_reason, v0.current_lp_usdc, v0.target_lp_usdc, v0.reserve_target_usdc, v0.queue_pressure_bps)
    }

    fun sync_cetus_live_presence<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) {
        arg0.live_cetus_enabled = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg1);
        arg0.live_cetus_position_present = has_stored_cetus_position<T0>(arg0);
        if (arg0.live_cetus_position_present) {
            arg0.live_cetus_last_position_id = stored_cetus_position_id<T0>(arg0);
        };
    }

    public fun sync_live_yield_deposit_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        record_live_yield_deposit<T0>(arg0, arg1, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun sync_live_yield_hold_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        record_live_yield_hold<T0>(arg0, arg1, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    public fun sync_live_yield_withdraw_entry<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::AdminCap, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        record_live_yield_withdraw<T0>(arg0, arg1, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    fun sync_strategy_metadata<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.cetus_balance);
        arg0.cetus_deployed_usdc = v0;
        arg0.cetus_last_rebalance_ts_ms = arg2;
        let v1 = if ((v0 > 0 || has_stored_cetus_position<T0>(arg0)) && 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg1)) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::cetus_pool_id(arg1)
        } else {
            @0x0
        };
        arg0.cetus_pool_id = v1;
        sync_cetus_live_presence<T0>(arg0, arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.yield_balance);
        arg0.yield_deployed_usdc = v2;
        arg0.yield_last_rebalance_ts_ms = arg2;
        sync_yield_live_presence<T0>(arg0, arg1);
        let v3 = live_yield_address_slot<T0>(arg0, 1);
        let v4 = if (v3 != @0x0) {
            v3
        } else if (v2 > 0 && 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg1)) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg1)
        } else {
            @0x0
        };
        arg0.yield_receipt_id = v4;
        let v5 = 0x2::balance::value<T0>(&arg0.hedge_margin_balance);
        arg0.hedge_margin_usdc = v5;
        arg0.hedge_last_rebalance_ts_ms = arg2;
        let v6 = if (v5 > 0) {
            if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge::is_available(arg1)) {
                v0 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            arg0.hedge_position_id = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::perps_market_id(arg1);
            arg0.hedge_notional_usdc = v0;
        } else {
            arg0.hedge_position_id = @0x0;
            arg0.hedge_notional_usdc = 0;
        };
    }

    fun sync_yield_live_presence<T0>(arg0: &mut Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) {
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg1);
        set_live_yield_metric_slot<T0>(arg0, 0, bool_to_u64(v0));
        let v1 = if (v0) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::lending_market_id(arg1)
        } else {
            @0x0
        };
        set_live_yield_address_slot<T0>(arg0, 0, v1);
        let v2 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::normalize_live_receipt_id(arg1, live_yield_address_slot<T0>(arg0, 1), live_yield_metric_slot<T0>(arg0, 3));
        set_live_yield_address_slot<T0>(arg0, 1, v2);
        let v3 = v2 != @0x0;
        set_live_yield_metric_slot<T0>(arg0, 1, bool_to_u64(v3));
        if (!v3) {
            set_live_yield_address_slot<T0>(arg0, 1, @0x0);
            if (live_yield_metric_slot<T0>(arg0, 3) == 0) {
                set_live_yield_metric_slot<T0>(arg0, 2, 0);
                if (live_yield_metric_slot<T0>(arg0, 5) == 0) {
                    set_live_yield_metric_slot<T0>(arg0, 4, 0);
                };
            };
        };
    }

    public fun take_cetus_position<T0>(arg0: &mut Vault<T0>) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!(has_stored_cetus_position<T0>(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_missing_object());
        0x2::dynamic_object_field::remove<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, cetus_position_key())
    }

    fun target_strategy_mix<T0>(arg0: &Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : (u64, u64, u64) {
        let v0 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_assets(&arg0.state);
        let v1 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::risk_mode(&arg0.state);
        if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::is_only_unwind(&v1)) {
            let v2 = if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg2)) {
                0x2::balance::value<T0>(&arg0.yield_balance)
            } else {
                0
            };
            return (0, v2, 0)
        };
        let v3 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle::current_regime(&arg0.oracle);
        let (v4, v5, v6) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::get_allocation(&v3);
        let v7 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::max_deployable_usdc(v0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::reserve_target_usdc(v6, v0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_ready_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1)), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::total_pending_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::state(arg1))));
        let v8 = is_only_unwind_mode<T0>(arg0);
        let v9 = if (v8) {
            0
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::target_lp_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg2), v0, v5, v7, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge::is_available(arg2), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge::initial_margin_bps())
        };
        let v10 = if (v8) {
            0
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::target_hedge_margin_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge::is_available(arg2), v9, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::perp_hedge::initial_margin_bps())
        };
        let v11 = if (v8) {
            if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg2)) {
                v7
            } else {
                0
            }
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::target_yield_usdc(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::yield_source::is_available(arg2), v0, v4, v7, v9, v10)
        };
        (v9, v11, v10)
    }

    public fun total_assets<T0>(arg0: &Vault<T0>) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_assets(&arg0.state)
    }

    fun total_deployed_internal<T0>(arg0: &Vault<T0>) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(0x2::balance::value<T0>(&arg0.cetus_balance), 0x2::balance::value<T0>(&arg0.yield_balance)), 0x2::balance::value<T0>(&arg0.hedge_margin_balance))
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::total_shares(&arg0.state)
    }

    public fun treasury_usdc<T0>(arg0: &Vault<T0>) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::treasury_usdc(&arg0.state)
    }

    fun u64_to_bool(arg0: u64) : bool {
        arg0 != 0
    }

    fun unwind_to_cover_liquidity<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.treasury);
        if (v0 >= arg1) {
            return
        };
        let v1 = arg1 - v0;
        let v2 = 0x2::balance::value<T0>(&arg0.hedge_margin_balance);
        let v3 = if (v2 < v1) {
            v2
        } else {
            v1
        };
        let v4 = &mut arg0.hedge_margin_balance;
        let v5 = &mut arg0.treasury;
        move_balance_to_treasury<T0>(v4, v5, v3);
        let v6 = v1 - v3;
        let v7 = 0x2::balance::value<T0>(&arg0.yield_balance);
        let v8 = if (v7 < v6) {
            v7
        } else {
            v6
        };
        let v9 = &mut arg0.yield_balance;
        let v10 = &mut arg0.treasury;
        move_balance_to_treasury<T0>(v9, v10, v8);
        let v11 = v6 - v8;
        let v12 = 0x2::balance::value<T0>(&arg0.cetus_balance);
        let v13 = if (v12 < v11) {
            v12
        } else {
            v11
        };
        let v14 = &mut arg0.cetus_balance;
        let v15 = &mut arg0.treasury;
        move_balance_to_treasury<T0>(v14, v15, v13);
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::vault::set_treasury_usdc_for_testing(&mut arg0.state, 0x2::balance::value<T0>(&arg0.treasury));
    }

    public fun yield_deployed_usdc<T0>(arg0: &Vault<T0>) : u64 {
        arg0.yield_deployed_usdc
    }

    public fun yield_receipt_id<T0>(arg0: &Vault<T0>) : address {
        arg0.yield_receipt_id
    }

    // decompiled from Move bytecode v6
}

