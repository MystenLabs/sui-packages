module 0xd9cd7ac4d86f1e8c80fa7019d9cf885cbf62d2d178affefc4785b4e96b4971b1::settlement {
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

