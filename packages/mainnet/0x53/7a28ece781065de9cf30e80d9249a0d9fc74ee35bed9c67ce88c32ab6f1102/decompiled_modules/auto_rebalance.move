module 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::auto_rebalance {
    struct NewAutoRebalanceStrategyEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        version: u64,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        lower_sqrt_price_change_threshold_bps: u64,
        upper_sqrt_price_change_threshold_bps: u64,
        lower_sqrt_price_change_threshold_direction: bool,
        upper_sqrt_price_change_threshold_direction: bool,
        rebalance_cooldown_secs: u64,
        range_multiplier: u64,
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
        version: u64,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        lower_sqrt_price_change_threshold_bps: u64,
        upper_sqrt_price_change_threshold_bps: u64,
        lower_sqrt_price_change_threshold_direction: bool,
        upper_sqrt_price_change_threshold_direction: bool,
        rebalance_cooldown_secs: u64,
        range_multiplier: u64,
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

    public fun bump_version(arg0: &0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::acl::AclRegistry, arg1: &mut AutoRebalanceStrategy, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::acl::get_admin(arg0) == 0x2::tx_context::sender(arg2), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_owner());
        assert!(arg1.version < 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::config::get_version(), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_version_too_high());
        arg1.version = 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::config::get_version();
    }

    public fun decode_auto_rebalance_strategy_data(arg0: vector<u8>) : (u64, 0x1::string::String, u64, u64, bool, bool, u64, u64, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, bool, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_u64(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v0)), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun get_new_tick_range(arg0: &AutoRebalanceStrategy, arg1: u128, arg2: u32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::tick_math::get_sqrt_price_at_tick(arg3);
        let v1 = 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::tick_math::get_sqrt_price_at_tick(arg4);
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
            abort 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_sqrt_price()
        };
        let v6 = arg1 - arg1 * (arg0.range_multiplier as u128) / 10000;
        let v7 = v6;
        let v8 = arg1 + arg1 * (arg0.range_multiplier as u128) / 10000;
        let v9 = v8;
        if (v6 < 4295048016) {
            v7 = 4295048016;
        };
        if (v8 > 79226673515401279992447579055) {
            v9 = 79226673515401279992447579055;
        };
        (0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::utils::round_tick_to_spacing(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::utils::bound_tick(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::tick_math::get_tick_at_sqrt_price(v7)), arg2), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::utils::round_tick_to_spacing(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::utils::bound_tick(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::tick_math::get_tick_at_sqrt_price(v9)), arg2))
    }

    fun init(arg0: AUTO_REBALANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::new_cap<AUTO_REBALANCE>(arg0, arg1);
        0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::create_enclave_config<AUTO_REBALANCE>(&v0, 0x1::string::utf8(b"first version auto rebalance enclave"), x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", arg1);
        0x2::transfer::public_transfer<0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Cap<AUTO_REBALANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_auto_rebalance_strategy<T0: store>(arg0: &mut 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::PositionRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : AutoRebalanceStrategy {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = decode_auto_rebalance_strategy_data(arg1);
        assert!(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::is_some<T0>(arg0, v0), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_position_registry_not_exists());
        assert!(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::owner<T0>(arg0, v0) == 0x2::tx_context::sender(arg3), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_owner());
        let v12 = AutoRebalanceStrategy{
            id                                          : 0x2::object::new(arg3),
            version                                     : 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::config::get_version(),
            owner                                       : 0x2::tx_context::sender(arg3),
            position_registry_id                        : v0,
            description                                 : v1,
            lower_sqrt_price_change_threshold_bps       : v2,
            upper_sqrt_price_change_threshold_bps       : v3,
            lower_sqrt_price_change_threshold_direction : v4,
            upper_sqrt_price_change_threshold_direction : v5,
            rebalance_cooldown_secs                     : v6,
            range_multiplier                            : v7,
            rebalance_max_tick                          : v8,
            rebalance_min_tick                          : v9,
            rebalance_paused                            : v10,
            lp_slippage_tolerance_bps                   : v11,
            last_rebalance_timestamp                    : 0x2::clock::timestamp_ms(arg2),
        };
        let v13 = NewAutoRebalanceStrategyEvent{
            strategy_id                                 : *0x2::object::uid_as_inner(&v12.id),
            version                                     : 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::config::get_version(),
            owner                                       : v12.owner,
            position_registry_id                        : v0,
            description                                 : v1,
            lower_sqrt_price_change_threshold_bps       : v2,
            upper_sqrt_price_change_threshold_bps       : v3,
            lower_sqrt_price_change_threshold_direction : v4,
            upper_sqrt_price_change_threshold_direction : v5,
            rebalance_cooldown_secs                     : v6,
            range_multiplier                            : v7,
            rebalance_max_tick                          : v8,
            rebalance_min_tick                          : v9,
            rebalance_paused                            : v10,
            lp_slippage_tolerance_bps                   : v11,
        };
        0x2::event::emit<NewAutoRebalanceStrategyEvent>(v13);
        v12
    }

    public fun prepare_rebalance_bot<T0: store>(arg0: &mut 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::PositionRegistry, arg1: &mut AutoRebalanceStrategy, arg2: &0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Enclave<T0>, arg3: u64, arg4: AutoRebalanceRequest, arg5: &vector<u8>, arg6: &0x2::clock::Clock) : (T0, AutoRebalanceReceipt) {
        assert!(0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::verify_signature<T0, AutoRebalanceRequest>(arg2, 0, arg3, arg4, arg5), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_signature());
        let AutoRebalanceRequest {
            strategy_id          : v0,
            current_tick_u32     : v1,
            current_sqrt_price   : v2,
            tick_spacing         : v3,
            tick_lower_index_u32 : v4,
            tick_upper_index_u32 : v5,
        } = arg4;
        assert!(v0 == *0x2::object::uid_as_inner(&arg1.id), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_strategy_id());
        prepare_rebalance_internal<T0>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), v2, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5), arg6)
    }

    fun prepare_rebalance_internal<T0: store>(arg0: &mut 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::PositionRegistry, arg1: &AutoRebalanceStrategy, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u32, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: &0x2::clock::Clock) : (T0, AutoRebalanceReceipt) {
        if (arg1.last_rebalance_timestamp > 0x2::clock::timestamp_ms(arg7)) {
            abort 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_last_rebalance_timestamp_after_current_timestamp()
        };
        if (arg1.last_rebalance_timestamp + arg1.rebalance_cooldown_secs > 0x2::clock::timestamp_ms(arg7)) {
            abort 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_rebalance_cooldown()
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg2, arg1.rebalance_min_tick) == 0 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg2, arg1.rebalance_max_tick) == 2) {
            abort 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_current_tick_out_of_range()
        };
        if (arg1.rebalance_paused) {
            abort 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_rebalance_paused()
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
        (0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::get_position_by_id<T0>(arg0, arg1.position_registry_id), v3)
    }

    public fun prepare_rebalance_owner<T0: store>(arg0: &mut 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::PositionRegistry, arg1: &mut AutoRebalanceStrategy, arg2: AutoRebalanceRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, AutoRebalanceReceipt) {
        let AutoRebalanceRequest {
            strategy_id          : v0,
            current_tick_u32     : v1,
            current_sqrt_price   : v2,
            tick_spacing         : v3,
            tick_lower_index_u32 : v4,
            tick_upper_index_u32 : v5,
        } = arg2;
        assert!(v0 == *0x2::object::uid_as_inner(&arg1.id), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_strategy_id());
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_owner());
        prepare_rebalance_internal<T0>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), v2, v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v5), arg3)
    }

    public fun repay_receipt<T0: store>(arg0: &mut 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::PositionRegistry, arg1: &mut AutoRebalanceStrategy, arg2: AutoRebalanceReceipt, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock) {
        let AutoRebalanceReceipt {
            strategy_id          : v0,
            new_tick_lower_index : v1,
            new_tick_upper_index : v2,
        } = arg2;
        let v3 = v0;
        assert!(0x2::object::uid_as_inner(&arg1.id) == &v3, 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_strategy_id());
        assert!(0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::registry::is_some<T0>(arg0, arg1.position_registry_id), 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_position_registry_not_exists());
        assert!(arg3 == v1, 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_tick_lower_index());
        assert!(arg4 == v2, 0x537a28ece781065de9cf30e80d9249a0d9fc74ee35bed9c67ce88c32ab6f1102::errors::error_invalid_tick_upper_index());
        arg1.last_rebalance_timestamp = 0x2::clock::timestamp_ms(arg5);
    }

    // decompiled from Move bytecode v6
}

