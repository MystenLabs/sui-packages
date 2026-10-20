module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::keeper {
    public fun assert_batch_order(arg0: u8, arg1: u8) {
        assert!(batch_order_ok(arg0, arg1), 13835058175541248001);
    }

    public fun batch_order_ok(arg0: u8, arg1: u8) : bool {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::keeper_batch_ok(arg0, arg1)
    }

    public fun priority_close() : u8 {
        1
    }

    public fun priority_fill_close() : u8 {
        1
    }

    public fun priority_fill_open() : u8 {
        2
    }

    public fun priority_force_close() : u8 {
        0
    }

    public fun priority_liq() : u8 {
        0
    }

    public fun priority_open() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

