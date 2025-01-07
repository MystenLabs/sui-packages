module 0x677bdf5f7a141fa036047fe72c7e601631ea39796b0c7d6e16dd9f9751231668::x {
    struct Call_X_Event has copy, drop {
        num: u64,
    }

    public entry fun call_x(arg0: u64) {
        let v0 = Call_X_Event{num: arg0};
        0x2::event::emit<Call_X_Event>(v0);
    }

    public entry fun call_x_twice(arg0: u64) {
        let v0 = Call_X_Event{num: arg0 * 2};
        0x2::event::emit<Call_X_Event>(v0);
    }

    // decompiled from Move bytecode v6
}

