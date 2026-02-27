module 0xe09af1fdaa3a773fc268b80bed1a0a8354bd6bebc03dad371fd9ee57d26c8a4c::admin {
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

