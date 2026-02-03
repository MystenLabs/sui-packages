module 0x1555b309a099f787f62ed4d7a47c5054b6230259f028258bae920da21cd97926::timestamp {
    struct TSDE has copy, drop {
        E1: u64,
        E2: u64,
    }

    entry fun tsd(arg0: &0x2::clock::Clock, arg1: u64) {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 369
        };
    }

    entry fun tsde(arg0: &0x2::clock::Clock, arg1: u64) {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 369
        };
        let v0 = TSDE{
            E1 : 0x2::clock::timestamp_ms(arg0),
            E2 : arg1,
        };
        0x2::event::emit<TSDE>(v0);
    }

    // decompiled from Move bytecode v6
}

