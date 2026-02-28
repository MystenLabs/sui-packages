module 0xf41773a726523b13dd30a96a4c2b1f569cde60b9a6726d8bd60284fa0019d8e5::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PauseFlag has key {
        id: 0x2::object::UID,
        paused: bool,
    }

    public(friend) fun assert_not_paused(arg0: &PauseFlag) {
        assert!(!arg0.paused, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PauseFlag{
            id     : 0x2::object::new(arg0),
            paused : false,
        };
        0x2::transfer::share_object<PauseFlag>(v1);
    }

    entry fun pause(arg0: &AdminCap, arg1: &mut PauseFlag) {
        arg1.paused = true;
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun unpause(arg0: &AdminCap, arg1: &mut PauseFlag) {
        arg1.paused = false;
    }

    // decompiled from Move bytecode v6
}

