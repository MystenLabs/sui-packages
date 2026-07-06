module 0x9cd6d8016c82f74941208c6cff5bee295c8d1130cfe63e84039be4afbc3dc47::settlement {
    struct Settled has copy, drop {
        amount: u64,
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>) {
        let v0 = Settled{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Settled>(v0);
        0x2::balance::send_funds<T0>(arg0, @0x3e20282341ad3b98a05ce6139b6e62d4349b9078cf25e44b5f80e16e8f4d8047);
    }

    // decompiled from Move bytecode v7
}

