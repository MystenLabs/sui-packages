module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable {
    struct Pausable<phantom T0> has store {
        paused: bool,
    }

    struct Paused<phantom T0> has copy, drop {
        by: address,
    }

    struct Unpaused<phantom T0> has copy, drop {
        by: address,
    }

    public fun assert_not_paused<T0>(arg0: &Pausable<T0>) {
        assert!(!arg0.paused, 10);
    }

    public fun is_paused<T0>(arg0: &Pausable<T0>) : bool {
        arg0.paused
    }

    public fun new<T0>() : Pausable<T0> {
        Pausable<T0>{paused: false}
    }

    public(friend) fun pause<T0>(arg0: &mut Pausable<T0>, arg1: &0x2::tx_context::TxContext) {
        if (!arg0.paused) {
            arg0.paused = true;
            let v0 = Paused<T0>{by: 0x2::tx_context::sender(arg1)};
            0x2::event::emit<Paused<T0>>(v0);
        };
    }

    public(friend) fun unpause<T0>(arg0: &mut Pausable<T0>, arg1: &0x2::tx_context::TxContext) {
        if (arg0.paused) {
            arg0.paused = false;
            let v0 = Unpaused<T0>{by: 0x2::tx_context::sender(arg1)};
            0x2::event::emit<Unpaused<T0>>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

