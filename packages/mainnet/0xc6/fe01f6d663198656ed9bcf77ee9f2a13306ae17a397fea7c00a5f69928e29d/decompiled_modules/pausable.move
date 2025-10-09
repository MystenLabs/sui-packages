module 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable {
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

    public fun pause(arg0: &mut Pause) {
        if (!arg0.paused) {
            arg0.paused = true;
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_pause(true);
        };
    }

    public fun unpause(arg0: &mut Pause) {
        if (arg0.paused) {
            arg0.paused = false;
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_pause(false);
        };
    }

    // decompiled from Move bytecode v6
}

