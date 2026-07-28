module 0x4554d6b3ca3db2d99af2916b371255d5a87f605860eab097291e6ea979c29883::settle {
    struct Settled has copy, drop {
        amount: u64,
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) {
        0x4554d6b3ca3db2d99af2916b371255d5a87f605860eab097291e6ea979c29883::asserts::must_collector_set(@0x259013476e54ad6af8128d60683840949ebf4e6a5f40776714832cff08a9dafe);
        let v0 = 0x2::balance::value<T0>(&arg0);
        0x4554d6b3ca3db2d99af2916b371255d5a87f605860eab097291e6ea979c29883::asserts::must_profit_at_least(v0, arg1);
        let v1 = Settled{amount: v0};
        0x2::event::emit<Settled>(v1);
        0x2::balance::send_funds<T0>(arg0, @0x259013476e54ad6af8128d60683840949ebf4e6a5f40776714832cff08a9dafe);
    }

    public fun collector() : address {
        @0x259013476e54ad6af8128d60683840949ebf4e6a5f40776714832cff08a9dafe
    }

    public fun settle_dust<T0>(arg0: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x4554d6b3ca3db2d99af2916b371255d5a87f605860eab097291e6ea979c29883::asserts::must_collector_set(@0x259013476e54ad6af8128d60683840949ebf4e6a5f40776714832cff08a9dafe);
            0x2::balance::send_funds<T0>(arg0, @0x259013476e54ad6af8128d60683840949ebf4e6a5f40776714832cff08a9dafe);
        };
    }

    // decompiled from Move bytecode v7
}

