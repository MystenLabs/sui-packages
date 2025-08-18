module 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::auto_compound {
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
        version: u64,
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

    public fun bump_version(arg0: &0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::acl::AclRegistry, arg1: &mut AutoCompoundStrategy, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::acl::get_admin(arg0) == 0x2::tx_context::sender(arg2), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_owner());
        assert!(arg1.version < 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::config::get_version(), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_version_too_high());
        arg1.version = 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::config::get_version();
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

    public fun new_auto_compound_strategy<T0: store>(arg0: &mut 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::PositionRegistry, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : AutoCompoundStrategy {
        let (v0, v1, v2) = decode_auto_compound_strategy_data(arg1);
        assert!(0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::is_some<T0>(arg0, arg2), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_position_registry_not_exists());
        assert!(0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::owner<T0>(arg0, arg2) == 0x2::tx_context::sender(arg4), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_owner());
        let v3 = AutoCompoundStrategy{
            id                         : 0x2::object::new(arg4),
            version                    : 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::config::get_version(),
            owner                      : 0x2::tx_context::sender(arg4),
            position_registry_id       : arg2,
            description                : v0,
            compound_interval_ms       : v1,
            compound_paused            : false,
            compound_trigger_threshold : v2,
            last_compound_timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        let v4 = NewAutoCompoundStrategyEvent{
            strategy_id                : *0x2::object::uid_as_inner(&v3.id),
            owner                      : v3.owner,
            position_registry_id       : arg2,
            description                : v0,
            compound_interval_ms       : v1,
            compound_trigger_threshold : v2,
        };
        0x2::event::emit<NewAutoCompoundStrategyEvent>(v4);
        v3
    }

    public fun prepare_compound_bot<T0: store>(arg0: &mut 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::PositionRegistry, arg1: &mut AutoCompoundStrategy, arg2: &0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Enclave<AUTO_COMPOUND>, arg3: u64, arg4: AutoCompoundRequest, arg5: &vector<u8>, arg6: &0x2::clock::Clock) : (T0, AutoCompoundReceipt) {
        assert!(0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::verify_signature<AUTO_COMPOUND, AutoCompoundRequest>(arg2, 0, arg3, arg4, arg5), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_signature());
        let AutoCompoundRequest {
            strategy_id           : v0,
            pending_rewards_value : v1,
        } = arg4;
        assert!(v0 == *0x2::object::uid_as_inner(&arg1.id), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_strategy_id());
        prepare_compound_internal<T0>(arg0, arg1, v1, arg6)
    }

    fun prepare_compound_internal<T0: store>(arg0: &mut 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::PositionRegistry, arg1: &mut AutoCompoundStrategy, arg2: u64, arg3: &0x2::clock::Clock) : (T0, AutoCompoundReceipt) {
        if (arg1.last_compound_timestamp > 0x2::clock::timestamp_ms(arg3)) {
            abort 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_last_compound_timestamp_in_future()
        };
        if (arg1.last_compound_timestamp + arg1.compound_interval_ms > 0x2::clock::timestamp_ms(arg3)) {
            abort 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_compound_interval()
        };
        if (arg2 < arg1.compound_trigger_threshold) {
            abort 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_total_position_value_below_trigger_threshold()
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
        (0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::get_position_by_id<T0>(arg0, arg1.position_registry_id), v1)
    }

    public fun prepare_compound_owner<T0: store>(arg0: &mut 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::registry::PositionRegistry, arg1: &mut AutoCompoundStrategy, arg2: AutoCompoundRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, AutoCompoundReceipt) {
        let AutoCompoundRequest {
            strategy_id           : v0,
            pending_rewards_value : v1,
        } = arg2;
        assert!(v0 == *0x2::object::uid_as_inner(&arg1.id), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_strategy_id());
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_owner());
        prepare_compound_internal<T0>(arg0, arg1, v1, arg3)
    }

    public fun repay_receipt(arg0: &mut AutoCompoundStrategy, arg1: AutoCompoundReceipt) {
        let AutoCompoundReceipt {
            strategy_id           : v0,
            pending_rewards_value : _,
        } = arg1;
        let v2 = v0;
        assert!(0x2::object::uid_as_inner(&arg0.id) == &v2, 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors::error_invalid_strategy_id());
    }

    // decompiled from Move bytecode v6
}

