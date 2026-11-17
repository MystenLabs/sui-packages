module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::keeper {
    public fun assert_batch_order(arg0: u8, arg1: u8) {
        assert!(batch_order_ok(arg0, arg1), 13835058175541248001);
    }

    public fun batch_order_ok(arg0: u8, arg1: u8) : bool {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::safety::keeper_batch_ok(arg0, arg1)
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

