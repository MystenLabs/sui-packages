module 0xde5e615d3b60fda8fb3be04675caf45fb108ed1edd0fa80004afde65c08aa98d::learn_move {
    struct GlobalState has key {
        id: 0x2::object::UID,
        started: bool,
        count: u8,
    }

    public fun end_move(arg0: &mut GlobalState) {
        assert!(arg0.started, 0);
        arg0.started = false;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState{
            id      : 0x2::object::new(arg0),
            started : false,
            count   : 0,
        };
        0x2::transfer::share_object<GlobalState>(v0);
    }

    public fun start_move(arg0: &mut GlobalState) {
        arg0.started = true;
    }

    // decompiled from Move bytecode v6
}

