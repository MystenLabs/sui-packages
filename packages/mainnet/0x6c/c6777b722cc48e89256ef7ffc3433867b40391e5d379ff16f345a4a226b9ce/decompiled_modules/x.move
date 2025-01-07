module 0x6cc6777b722cc48e89256ef7ffc3433867b40391e5d379ff16f345a4a226b9ce::x {
    struct Call_X_Event has copy, drop {
        num: u64,
    }

    public entry fun call_x(arg0: u64) {
        let v0 = Call_X_Event{num: arg0};
        0x2::event::emit<Call_X_Event>(v0);
    }

    // decompiled from Move bytecode v6
}

