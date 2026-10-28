module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::keeper {
    public fun assert_batch_order(arg0: u8, arg1: u8) {
        assert!(batch_order_ok(arg0, arg1), 13835058175541248001);
    }

    public fun batch_order_ok(arg0: u8, arg1: u8) : bool {
        0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::keeper_batch_ok(arg0, arg1)
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

