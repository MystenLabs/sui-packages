module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::keeper {
    public fun assert_batch_order(arg0: u8, arg1: u8) {
        assert!(batch_order_ok(arg0, arg1), 13835058175541248001);
    }

    public fun batch_order_ok(arg0: u8, arg1: u8) : bool {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::safety::keeper_batch_ok(arg0, arg1)
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

