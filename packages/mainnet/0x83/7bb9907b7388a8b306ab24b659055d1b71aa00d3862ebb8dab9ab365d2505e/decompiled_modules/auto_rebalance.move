module 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::auto_rebalance {
    struct NewAutoRebalanceStrategyEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        lower_sqrt_price_change_threshold_bps: u64,
        upper_sqrt_price_change_threshold_bps: u64,
        lower_sqrt_price_change_threshold_direction: bool,
        upper_sqrt_price_change_threshold_direction: bool,
        rebalance_cooldown_secs: u64,
        range_multiplier_lower: u64,
        range_multiplier_upper: u64,
        rebalance_max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        rebalance_min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        rebalance_paused: bool,
        lp_slippage_tolerance_bps: u64,
    }

    struct AutoRebalanceTriggerEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        current_sqrt_price: u128,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        timestamp_ms: u64,
    }

    struct AutoRebalanceStrategy has store, key {
        id: 0x2::object::UID,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        lower_sqrt_price_change_threshold_bps: u64,
        upper_sqrt_price_change_threshold_bps: u64,
        lower_sqrt_price_change_threshold_direction: bool,
        upper_sqrt_price_change_threshold_direction: bool,
        rebalance_cooldown_secs: u64,
        range_multiplier_lower: u64,
        range_multiplier_upper: u64,
        rebalance_max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        rebalance_min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        rebalance_paused: bool,
        lp_slippage_tolerance_bps: u64,
        last_rebalance_timestamp: u64,
    }

    struct AutoRebalanceReceipt {
        strategy_id: 0x2::object::ID,
        new_tick_lower_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        new_tick_upper_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct AutoRebalanceRequest has copy, drop {
        strategy_id: 0x2::object::ID,
        current_tick_u32: u32,
        current_sqrt_price: u128,
        tick_spacing: u32,
        tick_lower_index_u32: u32,
        tick_upper_index_u32: u32,
    }

    struct AUTO_REBALANCE has drop {
        dummy_field: bool,
    }

    public fun decode_auto_rebalance_strategy_data(arg0: vector<u8>) : (0x1::string::String, u64, u64, bool, bool, u64, u64, u64, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, bool, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v0)), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun get_new_tick_range(arg0: &AutoRebalanceStrategy, arg1: u128, arg2: u32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::tick_math::get_sqrt_price_at_tick(arg3);
        let v1 = 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::tick_math::get_sqrt_price_at_tick(arg4);
        let v2 = if (arg0.lower_sqrt_price_change_threshold_direction) {
            v0 + v0 * (arg0.lower_sqrt_price_change_threshold_bps as u128) / 10000
        } else {
            v0 - v0 * (arg0.lower_sqrt_price_change_threshold_bps as u128) / 10000
        };
        let v3 = v2;
        let v4 = if (arg0.upper_sqrt_price_change_threshold_direction) {
            v1 - v1 * (arg0.upper_sqrt_price_change_threshold_bps as u128) / 10000
        } else {
            v1 + v1 * (arg0.upper_sqrt_price_change_threshold_bps as u128) / 10000
        };
        let v5 = v4;
        if (v2 < 4295048016) {
            v3 = 4295048016;
        };
        if (v4 > 79226673515401279992447579055) {
            v5 = 79226673515401279992447579055;
        };
        if (arg1 > v3 && arg1 < v5) {
            abort 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_sqrt_price()
        };
        let v6 = arg1 - arg1 * (arg0.range_multiplier_lower as u128) / 10000;
        let v7 = v6;
        let v8 = arg1 + arg1 * (arg0.range_multiplier_upper as u128) / 10000;
        let v9 = v8;
        if (v6 < 4295048016) {
            v7 = 4295048016;
        };
        if (v8 > 79226673515401279992447579055) {
            v9 = 79226673515401279992447579055;
        };
        (0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::math_utils::round_tick_to_spacing(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::math_utils::bound_tick(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::tick_math::get_tick_at_sqrt_price(v7)), arg2), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::math_utils::round_tick_to_spacing(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::math_utils::bound_tick(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::tick_math::get_tick_at_sqrt_price(v9)), arg2))
    }

    fun init(arg0: AUTO_REBALANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::new_cap<AUTO_REBALANCE>(arg0, arg1);
        0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::create_enclave_config<AUTO_REBALANCE>(&v0, 0x1::string::utf8(b"first version auto rebalance enclave"), x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", arg1);
        0x2::transfer::public_transfer<0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Cap<AUTO_REBALANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_auto_rebalance_request(arg0: 0x2::object::ID, arg1: u32, arg2: u128, arg3: u32, arg4: u32, arg5: u32) : AutoRebalanceRequest {
        AutoRebalanceRequest{
            strategy_id          : arg0,
            current_tick_u32     : arg1,
            current_sqrt_price   : arg2,
            tick_spacing         : arg3,
            tick_lower_index_u32 : arg4,
            tick_upper_index_u32 : arg5,
        }
    }

    public fun new_auto_rebalance_strategy<T0: store>(arg0: &0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::GlobalConfig, arg1: &mut 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::PositionRegistry, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AutoRebalanceStrategy {
        0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::check_version(arg0);
        0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::check_is_paused(arg0);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = decode_auto_rebalance_strategy_data(arg3);
        assert!(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::is_some_position<T0>(arg1, arg2), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_position_registry_not_exists());
        assert!(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::owner<T0>(arg1, arg2) == 0x2::tx_context::sender(arg5), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_owner());
        let v12 = AutoRebalanceStrategy{
            id                                          : 0x2::object::new(arg5),
            owner                                       : 0x2::tx_context::sender(arg5),
            position_registry_id                        : arg2,
            description                                 : v0,
            lower_sqrt_price_change_threshold_bps       : v1,
            upper_sqrt_price_change_threshold_bps       : v2,
            lower_sqrt_price_change_threshold_direction : v3,
            upper_sqrt_price_change_threshold_direction : v4,
            rebalance_cooldown_secs                     : v5,
            range_multiplier_lower                      : v6,
            range_multiplier_upper                      : v7,
            rebalance_max_tick                          : v8,
            rebalance_min_tick                          : v9,
            rebalance_paused                            : v10,
            lp_slippage_tolerance_bps                   : v11,
            last_rebalance_timestamp                    : 0x2::clock::timestamp_ms(arg4),
        };
        let v13 = NewAutoRebalanceStrategyEvent{
            strategy_id                                 : *0x2::object::uid_as_inner(&v12.id),
            owner                                       : v12.owner,
            position_registry_id                        : arg2,
            description                                 : v0,
            lower_sqrt_price_change_threshold_bps       : v1,
            upper_sqrt_price_change_threshold_bps       : v2,
            lower_sqrt_price_change_threshold_direction : v3,
            upper_sqrt_price_change_threshold_direction : v4,
            rebalance_cooldown_secs                     : v5,
            range_multiplier_lower                      : v6,
            range_multiplier_upper                      : v7,
            rebalance_max_tick                          : v8,
            rebalance_min_tick                          : v9,
            rebalance_paused                            : v10,
            lp_slippage_tolerance_bps                   : v11,
        };
        0x2::event::emit<NewAutoRebalanceStrategyEvent>(v13);
        v12
    }

    public fun prepare_rebalance_bot<T0: store>(arg0: &mut AutoRebalanceStrategy, arg1: &0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::GlobalConfig, arg2: &mut 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::PositionRegistry, arg3: &0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Enclave<AUTO_REBALANCE>, arg4: u64, arg5: AutoRebalanceRequest, arg6: &vector<u8>, arg7: &0x2::clock::Clock) : (T0, AutoRebalanceReceipt, 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::GetCoinReceipt) {
        0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::check_version(arg1);
        0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::check_is_paused(arg1);
        assert!(0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::verify_signature<AUTO_REBALANCE, AutoRebalanceRequest>(arg3, 0, arg4, arg5, arg6), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_signature());
        let AutoRebalanceRequest {
            strategy_id          : v0,
            current_tick_u32     : v1,
            current_sqrt_price   : v2,
            tick_spacing         : v3,
            tick_lower_index_u32 : v4,
            tick_upper_index_u32 : v5,
        } = arg5;
        assert!(v0 == *0x2::object::uid_as_inner(&arg0.id), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_strategy_id());
        let (v6, v7) = prepare_rebalance_internal<T0>(arg2, arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), v2, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5), arg7);
        (v6, v7, 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::emit_get_coin_receipt(arg0.position_registry_id))
    }

    fun prepare_rebalance_internal<T0: store>(arg0: &mut 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::PositionRegistry, arg1: &AutoRebalanceStrategy, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u32, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: &0x2::clock::Clock) : (T0, AutoRebalanceReceipt) {
        if (arg1.last_rebalance_timestamp > 0x2::clock::timestamp_ms(arg7)) {
            abort 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_last_rebalance_timestamp_after_current_timestamp()
        };
        if (arg1.last_rebalance_timestamp + arg1.rebalance_cooldown_secs > 0x2::clock::timestamp_ms(arg7)) {
            abort 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_rebalance_cooldown()
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg2, arg1.rebalance_min_tick) == 0 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg2, arg1.rebalance_max_tick) == 2) {
            abort 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_current_tick_out_of_range()
        };
        if (arg1.rebalance_paused) {
            abort 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_rebalance_paused()
        };
        let (v0, v1) = get_new_tick_range(arg1, arg3, arg4, arg5, arg6);
        let v2 = AutoRebalanceTriggerEvent{
            strategy_id          : *0x2::object::uid_as_inner(&arg1.id),
            current_sqrt_price   : arg3,
            current_tick         : arg2,
            tick_lower_index     : arg5,
            tick_upper_index     : arg6,
            new_tick_lower_index : v0,
            new_tick_upper_index : v1,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<AutoRebalanceTriggerEvent>(v2);
        let v3 = AutoRebalanceReceipt{
            strategy_id          : *0x2::object::uid_as_inner(&arg1.id),
            new_tick_lower_index : v0,
            new_tick_upper_index : v1,
        };
        (0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::get_position_by_id<T0>(arg0, arg1.position_registry_id), v3)
    }

    public fun prepare_rebalance_owner<T0: store>(arg0: &0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::GlobalConfig, arg1: &mut 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::PositionRegistry, arg2: &mut AutoRebalanceStrategy, arg3: AutoRebalanceRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (T0, AutoRebalanceReceipt) {
        0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::check_version(arg0);
        0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::config::check_is_paused(arg0);
        let AutoRebalanceRequest {
            strategy_id          : v0,
            current_tick_u32     : v1,
            current_sqrt_price   : v2,
            tick_spacing         : v3,
            tick_lower_index_u32 : v4,
            tick_upper_index_u32 : v5,
        } = arg3;
        assert!(v0 == *0x2::object::uid_as_inner(&arg2.id), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_strategy_id());
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_owner());
        prepare_rebalance_internal<T0>(arg1, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), v2, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5), arg4)
    }

    public fun repay_receipt<T0: store>(arg0: &mut 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::PositionRegistry, arg1: &mut AutoRebalanceStrategy, arg2: AutoRebalanceReceipt, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock) {
        let AutoRebalanceReceipt {
            strategy_id          : v0,
            new_tick_lower_index : v1,
            new_tick_upper_index : v2,
        } = arg2;
        let v3 = v0;
        assert!(0x2::object::uid_as_inner(&arg1.id) == &v3, 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_strategy_id());
        assert!(0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::registry::is_some_position<T0>(arg0, arg1.position_registry_id), 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_position_registry_not_exists());
        assert!(arg3 == v1, 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_tick_lower_index());
        assert!(arg4 == v2, 0x837bb9907b7388a8b306ab24b659055d1b71aa00d3862ebb8dab9ab365d2505e::errors::error_invalid_tick_upper_index());
        arg1.last_rebalance_timestamp = 0x2::clock::timestamp_ms(arg5);
    }

    // decompiled from Move bytecode v6
}

