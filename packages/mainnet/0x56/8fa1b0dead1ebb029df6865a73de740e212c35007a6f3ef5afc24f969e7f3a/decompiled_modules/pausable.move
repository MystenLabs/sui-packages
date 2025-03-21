module 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pausable {
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

    public(friend) fun new_global_pause_status(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalPauseStatus{
            id    : 0x2::object::new(arg0),
            pause : false,
        };
        0x2::transfer::share_object<GlobalPauseStatus>(v0);
        0x2::object::id<GlobalPauseStatus>(&v0)
    }

    public(friend) fun set_pausable(arg0: &mut GlobalPauseStatus, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.pause = arg1;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

