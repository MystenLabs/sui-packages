module 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::flash_book {
    struct FlashBook {
        owed: u64,
    }

    public fun add(arg0: FlashBook, arg1: u64) : FlashBook {
        assert!(arg1 > 0, 1);
        arg0.owed = arg0.owed + arg1;
        arg0
    }

    public fun close(arg0: FlashBook, arg1: u64) {
        let FlashBook { owed: v0 } = arg0;
        assert!(arg1 >= v0, 2);
    }

    public fun open(arg0: u64) : FlashBook {
        assert!(arg0 > 0, 1);
        FlashBook{owed: arg0}
    }

    public fun owed(arg0: &FlashBook) : u64 {
        arg0.owed
    }

    public fun require_repayable(arg0: &FlashBook, arg1: u64) {
        assert!(arg1 >= arg0.owed, 3);
    }

    // decompiled from Move bytecode v7
}

