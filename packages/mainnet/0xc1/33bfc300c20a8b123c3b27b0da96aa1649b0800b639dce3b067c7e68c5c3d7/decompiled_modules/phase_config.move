module 0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::phase_config {
    struct PhaseConfig has store, key {
        id: 0x2::object::UID,
        allow_public_mint: bool,
        start_time: u64,
        end_time: u64,
    }

    struct Phase has store, key {
        id: 0x2::object::UID,
        current_phase: u8,
        config: 0x2::object_table::ObjectTable<u8, PhaseConfig>,
    }

    struct SetCurrentPhaseEvent has copy, drop {
        current_phase: u8,
    }

    struct AddPhaseConfigEvent has copy, drop {
        id: 0x2::object::ID,
        add_phase_id: 0x2::object::ID,
        add_phase_key: u8,
        allow_public_mint: bool,
        start_time: u64,
        end_time: u64,
    }

    struct ModifyPhaseConfigEvent has copy, drop {
        id: 0x2::object::ID,
        modify_phase_id: 0x2::object::ID,
        modify_phase_key: u8,
        allow_public_mint: bool,
        start_time: u64,
        end_time: u64,
    }

    public entry fun add_or_modify_phase_config(arg0: &mut Phase, arg1: &0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::Contract, arg2: u8, arg3: bool, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::assert_admin(arg1, arg6);
        assert_phase_time(arg4, arg5);
        if (0x2::object_table::contains<u8, PhaseConfig>(&arg0.config, arg2)) {
            let v0 = 0x2::object_table::borrow_mut<u8, PhaseConfig>(&mut arg0.config, arg2);
            v0.allow_public_mint = arg3;
            v0.start_time = arg4;
            v0.end_time = arg5;
            let v1 = ModifyPhaseConfigEvent{
                id                : 0x2::object::uid_to_inner(&arg0.id),
                modify_phase_id   : 0x2::object::uid_to_inner(&v0.id),
                modify_phase_key  : arg2,
                allow_public_mint : arg3,
                start_time        : arg4,
                end_time          : arg5,
            };
            0x2::event::emit<ModifyPhaseConfigEvent>(v1);
        } else {
            let v2 = 0x2::object::new(arg6);
            let v3 = AddPhaseConfigEvent{
                id                : 0x2::object::uid_to_inner(&arg0.id),
                add_phase_id      : 0x2::object::uid_to_inner(&v2),
                add_phase_key     : arg2,
                allow_public_mint : arg3,
                start_time        : arg4,
                end_time          : arg5,
            };
            0x2::event::emit<AddPhaseConfigEvent>(v3);
            let v4 = PhaseConfig{
                id                : v2,
                allow_public_mint : arg3,
                start_time        : arg4,
                end_time          : arg5,
            };
            0x2::object_table::add<u8, PhaseConfig>(&mut arg0.config, arg2, v4);
        };
    }

    public fun assert_can_public_mint(arg0: &PhaseConfig) {
        assert!(arg0.allow_public_mint, 5);
    }

    public fun assert_phase_in_progress(arg0: &Phase, arg1: &0x2::clock::Clock) {
        let v0 = get_phase_config(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= v0.start_time, 3);
        assert!(v1 <= v0.end_time, 4);
    }

    fun assert_phase_key_exists(arg0: &0x2::object_table::ObjectTable<u8, PhaseConfig>, arg1: u8) {
        assert!(0x2::object_table::contains<u8, PhaseConfig>(arg0, arg1), 2);
    }

    fun assert_phase_time(arg0: u64, arg1: u64) {
        assert!(arg0 < arg1, 1);
    }

    public fun get_current_phase(arg0: &Phase) : u8 {
        arg0.current_phase
    }

    public fun get_phase_config(arg0: &Phase) : &PhaseConfig {
        get_phase_config_by_key(&arg0.config, arg0.current_phase)
    }

    public fun get_phase_config_by_key(arg0: &0x2::object_table::ObjectTable<u8, PhaseConfig>, arg1: u8) : &PhaseConfig {
        assert_phase_key_exists(arg0, arg1);
        0x2::object_table::borrow<u8, PhaseConfig>(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Phase{
            id            : 0x2::object::new(arg0),
            current_phase : 0,
            config        : 0x2::object_table::new<u8, PhaseConfig>(arg0),
        };
        0x2::transfer::share_object<Phase>(v0);
    }

    public entry fun set_current_phase(arg0: &mut Phase, arg1: &0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::Contract, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin::assert_admin(arg1, arg3);
        assert_phase_key_exists(&arg0.config, arg2);
        arg0.current_phase = arg2;
        let v0 = SetCurrentPhaseEvent{current_phase: arg2};
        0x2::event::emit<SetCurrentPhaseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

