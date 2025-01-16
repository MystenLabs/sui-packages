module 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config {
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

