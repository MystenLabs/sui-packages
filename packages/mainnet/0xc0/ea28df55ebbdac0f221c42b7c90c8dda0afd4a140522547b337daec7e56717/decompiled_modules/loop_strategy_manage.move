module 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        init: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct BreakerCap has store, key {
        id: 0x2::object::UID,
    }

    struct RobotCap has store, key {
        id: 0x2::object::UID,
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::Strategy) {
        0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::migrate(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id   : 0x2::object::new(arg0),
            init : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_strategy_config(arg0: &mut AdminCap, arg1: 0x2::coin::TreasuryCap<0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::vaultlpt::VAULTLPT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.init, 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::error::already_initialized());
        0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::loop_strategy_core::initialize(arg1, arg2);
        arg0.init = true;
    }

    public fun set_breaker_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BreakerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<BreakerCap>(v0, arg1);
    }

    public fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public fun set_robot_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RobotCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<RobotCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

