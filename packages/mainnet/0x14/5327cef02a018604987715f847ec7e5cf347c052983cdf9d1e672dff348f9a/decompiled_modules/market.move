module 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::market {
    struct Market<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FlashLoan<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    // decompiled from Move bytecode v7
}

