module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::public_transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun increment(arg0: &mut Counter, arg1: u64, arg2: u64) {
        assert!(arg0.count == arg1, 135289680000);
        arg0.count = arg0.count + arg2;
    }

    // decompiled from Move bytecode v6
}

