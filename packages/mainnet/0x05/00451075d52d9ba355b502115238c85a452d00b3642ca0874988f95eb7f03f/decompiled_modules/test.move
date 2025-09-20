module 0x500451075d52d9ba355b502115238c85a452d00b3642ca0874988f95eb7f03f::test {
    struct SettledAmount has copy, drop {
        amount: u64,
    }

    public fun settle<T0>(arg0: &0x2::coin::Coin<T0>) {
        let v0 = SettledAmount{amount: 0x2::coin::value<T0>(arg0)};
        0x2::event::emit<SettledAmount>(v0);
    }

    // decompiled from Move bytecode v6
}

