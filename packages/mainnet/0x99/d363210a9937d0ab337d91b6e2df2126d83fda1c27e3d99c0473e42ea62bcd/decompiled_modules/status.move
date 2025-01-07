module 0x99d363210a9937d0ab337d91b6e2df2126d83fda1c27e3d99c0473e42ea62bcd::status {
    struct GlobalStatus has key {
        id: 0x2::object::UID,
        pause: bool,
    }

    struct SetPauseEvent has copy, drop {
        sender: address,
        status: bool,
    }

    public(friend) fun assert_pause(arg0: &GlobalStatus) {
        assert!(!get_pause_status(arg0), 1);
    }

    fun get_pause_status(arg0: &GlobalStatus) : bool {
        arg0.pause
    }

    public(friend) fun new_global_pause_status_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalStatus{
            id    : 0x2::object::new(arg0),
            pause : false,
        };
        0x2::transfer::share_object<GlobalStatus>(v0);
        0x2::object::id<GlobalStatus>(&v0)
    }

    public(friend) fun set_status_and_emit_event(arg0: &mut GlobalStatus, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        arg0.pause = arg1;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

