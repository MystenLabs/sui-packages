module 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin {
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

