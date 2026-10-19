module 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::keeper {
    public fun assert_batch_order(arg0: u8, arg1: u8) {
        assert!(batch_order_ok(arg0, arg1), 13835058166951313409);
    }

    public fun batch_order_ok(arg0: u8, arg1: u8) : bool {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::safety::keeper_batch_ok(arg0, arg1)
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

    public fun priority_liq() : u8 {
        0
    }

    public fun priority_open() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

