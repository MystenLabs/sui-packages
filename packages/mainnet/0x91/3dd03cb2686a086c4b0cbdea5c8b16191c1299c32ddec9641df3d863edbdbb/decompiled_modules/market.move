module 0x913dd03cb2686a086c4b0cbdea5c8b16191c1299c32ddec9641df3d863edbdbb::market {
    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    // decompiled from Move bytecode v7
}

