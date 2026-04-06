module 0xccddc96ee46b4f22bc5600d6583a418499e1ab5b51b74a9d651a4e2150743d0b::pausable {
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
            0xccddc96ee46b4f22bc5600d6583a418499e1ab5b51b74a9d651a4e2150743d0b::events::emit_pause(true);
        };
    }

    public(friend) fun unpause(arg0: &mut Pause) {
        if (arg0.paused) {
            arg0.paused = false;
            0xccddc96ee46b4f22bc5600d6583a418499e1ab5b51b74a9d651a4e2150743d0b::events::emit_pause(false);
        };
    }

    // decompiled from Move bytecode v7
}

