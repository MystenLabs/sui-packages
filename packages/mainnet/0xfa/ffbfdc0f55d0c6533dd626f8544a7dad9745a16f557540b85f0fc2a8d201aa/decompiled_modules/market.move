module 0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::market {
    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    // decompiled from Move bytecode v7
}

