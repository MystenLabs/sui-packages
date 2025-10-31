module 0xf028303ea0d8dc2ac3ec17c696ca04f097d0c9af01e8a6607dc28242bd393a8c::pausable {
    struct Pausable has drop, store {
        paused: bool,
    }

    struct PausedSetEvent has copy, drop {
        paused: bool,
    }

    public(friend) fun assert_not_paused(arg0: &Pausable) {
        assert!(!arg0.paused, 1);
    }

    public(friend) fun is_paused(arg0: &Pausable) : bool {
        arg0.paused
    }

    public(friend) fun new() : Pausable {
        Pausable{paused: false}
    }

    public(friend) fun set_pause(arg0: &mut Pausable, arg1: bool) {
        assert!(arg0.paused != arg1, 2);
        arg0.paused = arg1;
        let v0 = PausedSetEvent{paused: arg1};
        0x2::event::emit<PausedSetEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

