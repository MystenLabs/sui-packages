module 0x5b37d9b945d2ddcd16a8fa05862958aea9c19c189161dc6a5c05e7592ca34264::mev {
    struct Stashed has copy, drop, store {
        amount: u64,
    }

    public fun print_money<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 1);
        0x2::coin::join<T0>(arg2, arg0);
        let v1 = Stashed{amount: v0};
        0x2::event::emit<Stashed>(v1);
    }

    // decompiled from Move bytecode v6
}

