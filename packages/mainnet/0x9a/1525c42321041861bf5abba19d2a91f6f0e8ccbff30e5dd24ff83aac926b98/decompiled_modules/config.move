module 0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::config {
    struct PauseStatus has key {
        id: 0x2::object::UID,
        pause: bool,
    }

    struct SetPauseEvent has copy, drop {
        sender: address,
        status: bool,
    }

    public fun assert_pause(arg0: &PauseStatus) {
        assert!(!get_pause_status(arg0), 1);
    }

    fun get_pause_status(arg0: &PauseStatus) : bool {
        arg0.pause
    }

    public(friend) fun new_pause_status(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PauseStatus{
            id    : 0x2::object::new(arg0),
            pause : false,
        };
        0x2::transfer::share_object<PauseStatus>(v0);
        0x2::object::id<PauseStatus>(&v0)
    }

    public(friend) fun pause(arg0: &mut PauseStatus, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.pause = true;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg1),
            status : arg0.pause,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    public(friend) fun unpause(arg0: &mut PauseStatus, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.pause = false;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg1),
            status : arg0.pause,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

