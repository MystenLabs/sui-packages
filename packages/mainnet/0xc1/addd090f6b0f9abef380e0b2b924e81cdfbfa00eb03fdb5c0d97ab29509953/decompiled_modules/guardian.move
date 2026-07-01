module 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian {
    struct GuardianKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GuardianCap has key {
        id: 0x2::object::UID,
    }

    struct GuardianState has store {
        guardian: address,
        active_guardian_cap_id: 0x2::object::ID,
        protocol_paused: bool,
    }

    public fun guardian(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) : address {
        borrow_state(arg0).guardian
    }

    public fun active_guardian_cap_id(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) : 0x2::object::ID {
        borrow_state(arg0).active_guardian_cap_id
    }

    fun assert_cap_active(arg0: &GuardianState, arg1: &GuardianCap) {
        assert!(0x2::object::id<GuardianCap>(arg1) == arg0.active_guardian_cap_id, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_guardian());
    }

    public fun assert_is_guardian(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &GuardianCap) {
        assert_cap_active(borrow_state(arg0), arg1);
    }

    public fun assert_not_paused(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) {
        let v0 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::id(arg0);
        let v1 = GuardianKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<GuardianKey>(v0, v1)) {
            return
        };
        let v2 = GuardianKey{dummy_field: false};
        assert!(!0x2::dynamic_field::borrow<GuardianKey, GuardianState>(v0, v2).protocol_paused, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::protocol_paused());
    }

    fun borrow_state(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) : &GuardianState {
        let v0 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::id(arg0);
        let v1 = GuardianKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<GuardianKey>(v0, v1), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::guardian_not_initialized());
        let v2 = GuardianKey{dummy_field: false};
        0x2::dynamic_field::borrow<GuardianKey, GuardianState>(v0, v2)
    }

    fun borrow_state_mut(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) : &mut GuardianState {
        let v0 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::get_config_id(arg0);
        let v1 = GuardianKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<GuardianKey>(v0, v1), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::guardian_not_initialized());
        let v2 = GuardianKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<GuardianKey, GuardianState>(v0, v2)
    }

    public(friend) fun init_state(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::zero_guardian_address());
        let v0 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::get_config_id(arg0);
        let v1 = GuardianKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<GuardianKey>(v0, v1), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::guardian_already_initialized());
        let v2 = GuardianCap{id: 0x2::object::new(arg2)};
        let v3 = 0x2::object::id<GuardianCap>(&v2);
        0x2::transfer::transfer<GuardianCap>(v2, arg1);
        let v4 = GuardianKey{dummy_field: false};
        let v5 = GuardianState{
            guardian               : arg1,
            active_guardian_cap_id : v3,
            protocol_paused        : false,
        };
        0x2::dynamic_field::add<GuardianKey, GuardianState>(v0, v4, v5);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_guardian_initialized_event(arg1, v3);
    }

    public fun is_initialized(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) : bool {
        let v0 = GuardianKey{dummy_field: false};
        0x2::dynamic_field::exists_<GuardianKey>(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::id(arg0), v0)
    }

    public fun is_paused(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig) : bool {
        borrow_state(arg0).protocol_paused
    }

    public fun pause_protocol(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &GuardianCap, arg2: &0x2::clock::Clock) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        let v0 = borrow_state_mut(arg0);
        assert_cap_active(v0, arg1);
        v0.protocol_paused = true;
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_protocol_paused_event(v0.guardian, 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun set_guardian(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::zero_guardian_address());
        let v0 = borrow_state_mut(arg0);
        assert!(arg1 != v0.guardian, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::rotation_to_same_guardian());
        let v1 = GuardianCap{id: 0x2::object::new(arg2)};
        let v2 = 0x2::object::id<GuardianCap>(&v1);
        0x2::transfer::transfer<GuardianCap>(v1, arg1);
        v0.guardian = arg1;
        v0.active_guardian_cap_id = v2;
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_guardian_rotated_event(v0.guardian, arg1, v0.active_guardian_cap_id, v2);
    }

    public fun unpause_protocol(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &GuardianCap, arg2: &0x2::clock::Clock) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        let v0 = borrow_state_mut(arg0);
        assert_cap_active(v0, arg1);
        v0.protocol_paused = false;
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_protocol_unpaused_event(v0.guardian, 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

