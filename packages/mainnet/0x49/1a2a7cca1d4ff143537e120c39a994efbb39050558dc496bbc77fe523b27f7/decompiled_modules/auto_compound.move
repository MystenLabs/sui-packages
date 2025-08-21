module 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::auto_compound {
    struct NewAutoCompoundStrategyEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        compound_interval_ms: u64,
        compound_trigger_threshold: u64,
    }

    struct AutoCompoundTriggerEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        pending_rewards_value: u64,
        timestamp_ms: u64,
    }

    struct AutoCompoundStrategy has store, key {
        id: 0x2::object::UID,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        compound_interval_ms: u64,
        compound_paused: bool,
        compound_trigger_threshold: u64,
        last_compound_timestamp: u64,
    }

    struct AutoCompoundReceipt {
        strategy_id: 0x2::object::ID,
        pending_rewards_value: u64,
    }

    struct AutoCompoundRequest has copy, drop {
        strategy_id: 0x2::object::ID,
        pending_rewards_value: u64,
    }

    struct AUTO_COMPOUND has drop {
        dummy_field: bool,
    }

    public fun decode_auto_compound_strategy_data(arg0: vector<u8>) : (0x1::string::String, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun new_auto_compound_request(arg0: 0x2::object::ID, arg1: u64) : AutoCompoundRequest {
        AutoCompoundRequest{
            strategy_id           : arg0,
            pending_rewards_value : arg1,
        }
    }

    public fun new_auto_compound_strategy<T0: store>(arg0: &0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::GlobalConfig, arg1: &mut 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::PositionRegistry, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AutoCompoundStrategy {
        0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::check_version(arg0);
        0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::check_is_paused(arg0);
        let (v0, v1, v2) = decode_auto_compound_strategy_data(arg2);
        assert!(0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::is_some_position<T0>(arg1, arg3), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_position_registry_not_exists());
        assert!(0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::owner<T0>(arg1, arg3) == 0x2::tx_context::sender(arg5), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_owner());
        let v3 = AutoCompoundStrategy{
            id                         : 0x2::object::new(arg5),
            owner                      : 0x2::tx_context::sender(arg5),
            position_registry_id       : arg3,
            description                : v0,
            compound_interval_ms       : v1,
            compound_paused            : false,
            compound_trigger_threshold : v2,
            last_compound_timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        let v4 = NewAutoCompoundStrategyEvent{
            strategy_id                : *0x2::object::uid_as_inner(&v3.id),
            owner                      : v3.owner,
            position_registry_id       : arg3,
            description                : v0,
            compound_interval_ms       : v1,
            compound_trigger_threshold : v2,
        };
        0x2::event::emit<NewAutoCompoundStrategyEvent>(v4);
        v3
    }

    public fun prepare_compound_bot<T0: store>(arg0: &mut AutoCompoundStrategy, arg1: &0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::GlobalConfig, arg2: &mut 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::PositionRegistry, arg3: &0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Enclave<AUTO_COMPOUND>, arg4: u64, arg5: AutoCompoundRequest, arg6: &vector<u8>, arg7: &0x2::clock::Clock) : (T0, AutoCompoundReceipt, 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::GetCoinReceipt) {
        0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::check_version(arg1);
        0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::check_is_paused(arg1);
        assert!(0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::verify_signature<AUTO_COMPOUND, AutoCompoundRequest>(arg3, 0, arg4, arg5, arg6), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_signature());
        let AutoCompoundRequest {
            strategy_id           : v0,
            pending_rewards_value : v1,
        } = arg5;
        assert!(v0 == *0x2::object::uid_as_inner(&arg0.id), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_strategy_id());
        let (v2, v3) = prepare_compound_internal<T0>(arg2, arg0, v1, arg7);
        (v2, v3, 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::emit_get_coin_receipt(arg0.position_registry_id))
    }

    fun prepare_compound_internal<T0: store>(arg0: &mut 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::PositionRegistry, arg1: &mut AutoCompoundStrategy, arg2: u64, arg3: &0x2::clock::Clock) : (T0, AutoCompoundReceipt) {
        if (arg1.last_compound_timestamp > 0x2::clock::timestamp_ms(arg3)) {
            abort 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_last_compound_timestamp_in_future()
        };
        if (arg1.last_compound_timestamp + arg1.compound_interval_ms > 0x2::clock::timestamp_ms(arg3)) {
            abort 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_compound_interval()
        };
        if (arg2 < arg1.compound_trigger_threshold) {
            abort 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_total_position_value_below_trigger_threshold()
        };
        arg1.last_compound_timestamp = 0x2::clock::timestamp_ms(arg3);
        let v0 = AutoCompoundTriggerEvent{
            strategy_id           : *0x2::object::uid_as_inner(&arg1.id),
            pending_rewards_value : arg2,
            timestamp_ms          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AutoCompoundTriggerEvent>(v0);
        let v1 = AutoCompoundReceipt{
            strategy_id           : *0x2::object::uid_as_inner(&arg1.id),
            pending_rewards_value : arg2,
        };
        (0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::get_position_by_id<T0>(arg0, arg1.position_registry_id), v1)
    }

    public fun prepare_compound_owner<T0: store>(arg0: &0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::GlobalConfig, arg1: &mut 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::PositionRegistry, arg2: &mut AutoCompoundStrategy, arg3: AutoCompoundRequest, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (T0, AutoCompoundReceipt) {
        0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::check_version(arg0);
        0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::config::check_is_paused(arg0);
        let AutoCompoundRequest {
            strategy_id           : v0,
            pending_rewards_value : v1,
        } = arg3;
        assert!(v0 == *0x2::object::uid_as_inner(&arg2.id), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_strategy_id());
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_owner());
        prepare_compound_internal<T0>(arg1, arg2, v1, arg4)
    }

    public fun repay_receipt<T0: store>(arg0: &mut 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::PositionRegistry, arg1: &mut AutoCompoundStrategy, arg2: AutoCompoundReceipt) {
        assert!(0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::registry::is_some_position<T0>(arg0, arg1.position_registry_id), 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_position_registry_not_exists());
        let AutoCompoundReceipt {
            strategy_id           : v0,
            pending_rewards_value : _,
        } = arg2;
        let v2 = v0;
        assert!(0x2::object::uid_as_inner(&arg1.id) == &v2, 0x491a2a7cca1d4ff143537e120c39a994efbb39050558dc496bbc77fe523b27f7::errors::error_invalid_strategy_id());
    }

    // decompiled from Move bytecode v6
}

