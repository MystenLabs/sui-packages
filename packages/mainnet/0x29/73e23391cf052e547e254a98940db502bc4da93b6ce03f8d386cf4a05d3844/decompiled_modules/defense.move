module 0x2973e23391cf052e547e254a98940db502bc4da93b6ce03f8d386cf4a05d3844::defense {
    struct DefenseController has key {
        id: 0x2::object::UID,
        target_controller: address,
        is_active: bool,
        defender: address,
        created_at: u64,
    }

    struct DefenseEvent has copy, drop {
        defender: address,
        target: address,
        action: vector<u8>,
        timestamp: u64,
    }

    public fun create_defense_controller(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = DefenseController{
            id                : 0x2::object::new(arg1),
            target_controller : arg0,
            is_active         : true,
            defender          : v0,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        let v2 = DefenseEvent{
            defender  : v0,
            target    : arg0,
            action    : b"DEFENSE_CONTROLLER_CREATED",
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DefenseEvent>(v2);
        0x2::transfer::share_object<DefenseController>(v1);
    }

    public fun emergency_stop(arg0: &mut DefenseController, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.defender, 401);
        arg0.is_active = false;
        let v1 = DefenseEvent{
            defender  : v0,
            target    : arg0.target_controller,
            action    : b"EMERGENCY_STOP_EXECUTED",
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DefenseEvent>(v1);
    }

    public fun get_defender(arg0: &DefenseController) : address {
        arg0.defender
    }

    public fun get_target_controller(arg0: &DefenseController) : address {
        arg0.target_controller
    }

    public fun is_defense_active(arg0: &DefenseController) : bool {
        arg0.is_active
    }

    public fun reactivate_defense(arg0: &mut DefenseController, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.defender, 401);
        arg0.is_active = true;
        let v1 = DefenseEvent{
            defender  : v0,
            target    : arg0.target_controller,
            action    : b"DEFENSE_REACTIVATED",
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DefenseEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

