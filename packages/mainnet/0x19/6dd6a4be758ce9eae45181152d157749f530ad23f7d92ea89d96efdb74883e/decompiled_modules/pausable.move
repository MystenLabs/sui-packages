module 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::pausable {
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
            0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::events::emit_pause(true);
        };
    }

    public(friend) fun unpause(arg0: &mut Pause) {
        if (arg0.paused) {
            arg0.paused = false;
            0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::events::emit_pause(false);
        };
    }

    // decompiled from Move bytecode v7
}

