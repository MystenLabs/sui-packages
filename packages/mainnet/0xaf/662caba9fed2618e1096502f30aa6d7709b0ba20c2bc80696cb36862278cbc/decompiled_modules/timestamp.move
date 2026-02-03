module 0xaf662caba9fed2618e1096502f30aa6d7709b0ba20c2bc80696cb36862278cbc::timestamp {
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

    entry fun tsde2(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = TSDE{
            E1 : 0x2::clock::timestamp_ms(arg0),
            E2 : arg1,
        };
        0x2::event::emit<TSDE>(v0);
    }

    // decompiled from Move bytecode v6
}

