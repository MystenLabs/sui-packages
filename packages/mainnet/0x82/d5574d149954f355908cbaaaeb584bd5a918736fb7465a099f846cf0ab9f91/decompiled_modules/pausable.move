module 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::pausable {
    struct Pause has copy, drop, store {
        paused: bool,
    }

    public fun assert_not_paused(arg0: &Pause) {
        assert!(!arg0.paused, 0);
    }

    public fun assert_paused(arg0: &Pause) {
        assert!(arg0.paused, 1);
    }

    public fun is_paused(arg0: &Pause) : bool {
        arg0.paused
    }

    public fun new() : Pause {
        Pause{paused: false}
    }

    public(friend) fun pause(arg0: &mut Pause) {
        if (!arg0.paused) {
            arg0.paused = true;
            0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::events::emit_pause(true);
        };
    }

    public(friend) fun unpause(arg0: &mut Pause) {
        if (arg0.paused) {
            arg0.paused = false;
            0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::events::emit_pause(false);
        };
    }

    // decompiled from Move bytecode v7
}

