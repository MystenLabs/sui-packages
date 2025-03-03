module 0x70559ade9d20a6b13747f5f456ee39a4cc5922e28b0b2a388165b90b653c3ef1::wintermute_sucks {
    struct Stashed has copy, drop, store {
        amount: u64,
    }

    public entry fun wintermute_sucks<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(arg1, arg0);
        let v0 = Stashed{amount: 0x2::coin::value<T0>(&arg0)};
        0x2::event::emit<Stashed>(v0);
    }

    // decompiled from Move bytecode v6
}

