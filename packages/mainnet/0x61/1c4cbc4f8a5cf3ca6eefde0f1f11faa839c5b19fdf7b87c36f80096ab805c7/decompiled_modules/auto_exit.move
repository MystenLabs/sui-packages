module 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::auto_exit {
    struct NewAutoExitStrategyEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        version: u64,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        exit_trigger_value: u64,
        to_coin: 0x1::type_name::TypeName,
    }

    struct AutoExitTriggerEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        exit_value: u64,
        timestamp_ms: u64,
    }

    struct AutoExitStrategy has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        position_registry_id: u64,
        description: 0x1::string::String,
        exit_trigger_value: u64,
        exit_trigger_direction: bool,
        to_coin: 0x1::type_name::TypeName,
    }

    struct AutoExitRequest has copy, drop {
        strategy_id: 0x2::object::ID,
        exit_value: u64,
    }

    struct AUTO_EXIT has drop {
        dummy_field: bool,
    }

    public fun bump_version(arg0: &0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::acl::AclRegistry, arg1: &mut AutoExitStrategy, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::acl::get_admin(arg0) == 0x2::tx_context::sender(arg2), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_invalid_owner());
        assert!(arg1.version < 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::config::get_version(), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_version_too_high());
        arg1.version = 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::config::get_version();
    }

    public fun decode_auto_exit_strategy_data<T0>(arg0: vector<u8>) : (u64, 0x1::string::String, u64, bool, 0x1::type_name::TypeName) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_u64(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x1::type_name::get<T0>())
    }

    public fun new_auto_exit_strategy<T0: store, T1>(arg0: &mut 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::PositionRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : AutoExitStrategy {
        let (v0, v1, v2, v3, v4) = decode_auto_exit_strategy_data<T1>(arg1);
        assert!(0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::is_some<T0>(arg0, v0), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_position_registry_not_exists());
        assert!(0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::owner<T0>(arg0, v0) == 0x2::tx_context::sender(arg2), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_invalid_owner());
        let v5 = AutoExitStrategy{
            id                     : 0x2::object::new(arg2),
            version                : 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::config::get_version(),
            owner                  : 0x2::tx_context::sender(arg2),
            position_registry_id   : v0,
            description            : v1,
            exit_trigger_value     : v2,
            exit_trigger_direction : v3,
            to_coin                : v4,
        };
        let v6 = NewAutoExitStrategyEvent{
            strategy_id          : *0x2::object::uid_as_inner(&v5.id),
            version              : 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::config::get_version(),
            owner                : v5.owner,
            position_registry_id : v0,
            description          : v1,
            exit_trigger_value   : v2,
            to_coin              : v4,
        };
        0x2::event::emit<NewAutoExitStrategyEvent>(v6);
        v5
    }

    public fun prepare_exit_bot<T0: store>(arg0: &mut 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::PositionRegistry, arg1: &AutoExitStrategy, arg2: &0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::Enclave<T0>, arg3: u64, arg4: AutoExitRequest, arg5: &vector<u8>, arg6: &0x2::clock::Clock) : T0 {
        assert!(0x4376812594277ddf4c5cf03c9e3d6ee78019defab822916e4bdb7b874f621951::enclave::verify_signature<T0, AutoExitRequest>(arg2, 0, arg3, arg4, arg5), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_invalid_signature());
        let AutoExitRequest {
            strategy_id : v0,
            exit_value  : v1,
        } = arg4;
        assert!(v0 == *0x2::object::uid_as_inner(&arg1.id), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_invalid_strategy_id());
        prepare_exit_internal<T0>(arg0, arg1, v1, arg6)
    }

    fun prepare_exit_internal<T0: store>(arg0: &mut 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::PositionRegistry, arg1: &AutoExitStrategy, arg2: u64, arg3: &0x2::clock::Clock) : T0 {
        if (arg1.exit_trigger_direction && arg2 < arg1.exit_trigger_value) {
            abort 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_total_position_value_below_trigger_threshold()
        };
        if (!arg1.exit_trigger_direction && arg2 > arg1.exit_trigger_value) {
            abort 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_total_position_value_above_trigger_threshold()
        };
        let v0 = AutoExitTriggerEvent{
            strategy_id  : *0x2::object::uid_as_inner(&arg1.id),
            exit_value   : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AutoExitTriggerEvent>(v0);
        0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::get_position_by_id<T0>(arg0, arg1.position_registry_id)
    }

    public fun prepare_exit_owner<T0: store>(arg0: &mut 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::registry::PositionRegistry, arg1: &AutoExitStrategy, arg2: AutoExitRequest, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let AutoExitRequest {
            strategy_id : v0,
            exit_value  : v1,
        } = arg2;
        assert!(v0 == *0x2::object::uid_as_inner(&arg1.id), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_invalid_strategy_id());
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 0x611c4cbc4f8a5cf3ca6eefde0f1f11faa839c5b19fdf7b87c36f80096ab805c7::errors::error_invalid_owner());
        prepare_exit_internal<T0>(arg0, arg1, v1, arg3)
    }

    // decompiled from Move bytecode v6
}

