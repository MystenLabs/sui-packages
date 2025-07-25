module 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::pause_registry {
    struct GlobalPauseRegistry has store, key {
        id: 0x2::object::UID,
        emergency_pause: bool,
        admin: 0x2::object::ID,
    }

    struct GlobalPauseRegistryWrapper has key {
        id: 0x2::object::UID,
        registry: GlobalPauseRegistry,
    }

    struct GlobalPauseRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct EmergencyPauseActivated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct EmergencyPauseDeactivated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun assert_not_emergency_paused(arg0: &GlobalPauseRegistryWrapper) {
        assert!(!arg0.registry.emergency_pause, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::emergency_paused());
    }

    public entry fun create_global_pause_registry(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::get_admin_cap_id(arg0);
        let v2 = GlobalPauseRegistry{
            id              : v0,
            emergency_pause : false,
            admin           : v1,
        };
        let v3 = GlobalPauseRegistryWrapper{
            id       : 0x2::object::new(arg1),
            registry : v2,
        };
        let v4 = GlobalPauseRegistryCreated{
            registry_id  : 0x2::object::uid_to_inner(&v0),
            admin_cap_id : v1,
        };
        0x2::event::emit<GlobalPauseRegistryCreated>(v4);
        0x2::transfer::share_object<GlobalPauseRegistryWrapper>(v3);
    }

    public entry fun emergency_pause_all(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut GlobalPauseRegistryWrapper, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::get_admin_cap_id(arg0);
        assert!(arg1.registry.admin == v0, 1);
        assert!(!arg1.registry.emergency_pause, 2);
        arg1.registry.emergency_pause = true;
        let v1 = EmergencyPauseActivated{
            registry_id  : 0x2::object::uid_to_inner(&arg1.registry.id),
            admin_cap_id : v0,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<EmergencyPauseActivated>(v1);
    }

    public entry fun emergency_resume_all(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut GlobalPauseRegistryWrapper, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::get_admin_cap_id(arg0);
        assert!(arg1.registry.admin == v0, 1);
        assert!(arg1.registry.emergency_pause, 3);
        arg1.registry.emergency_pause = false;
        let v1 = EmergencyPauseDeactivated{
            registry_id  : 0x2::object::uid_to_inner(&arg1.registry.id),
            admin_cap_id : v0,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<EmergencyPauseDeactivated>(v1);
    }

    public fun is_emergency_paused(arg0: &GlobalPauseRegistryWrapper) : bool {
        arg0.registry.emergency_pause
    }

    // decompiled from Move bytecode v6
}

