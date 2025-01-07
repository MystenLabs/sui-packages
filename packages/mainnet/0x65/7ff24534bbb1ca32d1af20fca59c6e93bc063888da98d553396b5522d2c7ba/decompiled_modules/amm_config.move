module 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config {
    struct GlobalPauseStatus has key {
        id: 0x2::object::UID,
        pause: bool,
    }

    struct SetPauseEvent has copy, drop {
        sender: address,
        status: bool,
    }

    public fun assert_pause(arg0: &GlobalPauseStatus) {
        assert!(!get_pause_status(arg0), 1);
    }

    fun get_pause_status(arg0: &GlobalPauseStatus) : bool {
        arg0.pause
    }

    public(friend) fun new_global_pause_status_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalPauseStatus{
            id    : 0x2::object::new(arg0),
            pause : false,
        };
        0x2::transfer::share_object<GlobalPauseStatus>(v0);
        0x2::object::id<GlobalPauseStatus>(&v0)
    }

    public(friend) fun set_status_and_emit_event(arg0: &mut GlobalPauseStatus, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.pause = arg1;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

