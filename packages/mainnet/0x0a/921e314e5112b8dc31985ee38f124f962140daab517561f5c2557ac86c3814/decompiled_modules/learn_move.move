module 0xa921e314e5112b8dc31985ee38f124f962140daab517561f5c2557ac86c3814::learn_move {
    struct GlobalState has key {
        id: 0x2::object::UID,
        started: bool,
        count: u8,
    }

    struct StartEvent has copy, drop {
        started: bool,
    }

    struct EndEvent has copy, drop {
        started: bool,
    }

    public fun end_move(arg0: &mut GlobalState) {
        assert!(arg0.started, 0);
        arg0.started = false;
        let v0 = EndEvent{started: false};
        0x2::event::emit<EndEvent>(v0);
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
        let v0 = StartEvent{started: true};
        0x2::event::emit<StartEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

