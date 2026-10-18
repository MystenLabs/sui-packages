module 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::keeper {
    public fun assert_batch_order(arg0: u8, arg1: u8) {
        assert!(batch_order_ok(arg0, arg1), 13835058149771444225);
    }

    public fun batch_order_ok(arg0: u8, arg1: u8) : bool {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::safety::keeper_batch_ok(arg0, arg1)
    }

    public fun priority_close() : u8 {
        1
    }

    public fun priority_liq() : u8 {
        0
    }

    public fun priority_open() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

