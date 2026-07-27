module 0x6cf21c427d03d1c62dc788e901df58e1cc33312600750d08796fa6ea8e69c2fd::settlement {
    struct Settled has copy, drop {
        amount: u64,
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>) {
        let v0 = Settled{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Settled>(v0);
        0x2::balance::send_funds<T0>(arg0, @0xa7ef677d20fd51aa08ed142184ea098269762f6c7bbf94cafdbce6bc2609cb1);
    }

    // decompiled from Move bytecode v7
}

