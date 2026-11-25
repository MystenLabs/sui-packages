module 0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state {
    struct State has key {
        id: 0x2::object::UID,
        slot: u8,
        arm_at: u64,
    }

    struct StateCap has key {
        id: 0x2::object::UID,
        slot: u8,
    }

    public fun arm(arg0: &mut State, arg1: &StateCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.slot == arg1.slot, 1);
        arg0.arm_at = 0x2::clock::timestamp_ms(arg2) + 400;
    }

    public fun arm_at(arg0: &State) : u64 {
        arg0.arm_at
    }

    public fun disarm(arg0: &mut State, arg1: &StateCap) {
        assert!(arg0.slot == arg1.slot, 1);
        arg0.arm_at = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 2) {
            let v1 = State{
                id     : 0x2::object::new(arg0),
                slot   : v0,
                arm_at : 0,
            };
            0x2::transfer::share_object<State>(v1);
            let v2 = StateCap{
                id   : 0x2::object::new(arg0),
                slot : v0,
            };
            0x2::transfer::transfer<StateCap>(v2, 0x2::tx_context::sender(arg0));
            v0 = v0 + 1;
        };
    }

    public fun live(arg0: &State, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.arm_at != 0) {
            if (v0 >= arg0.arm_at) {
                v0 - arg0.arm_at < 600000
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun slot(arg0: &State) : u8 {
        arg0.slot
    }

    // decompiled from Move bytecode v7
}

