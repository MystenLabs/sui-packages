module 0x45430c43270e379b88c3ce27f23f91480dc6f6a7c2292b285939edc97c2e3c7c::option {
    struct DemoEvent has copy, drop {
        a1: 0x1::option::Option<u64>,
        a2: u64,
    }

    public entry fun test(arg0: 0x1::option::Option<u64>, arg1: u64) {
        let v0 = DemoEvent{
            a1 : arg0,
            a2 : arg1,
        };
        0x2::event::emit<DemoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

