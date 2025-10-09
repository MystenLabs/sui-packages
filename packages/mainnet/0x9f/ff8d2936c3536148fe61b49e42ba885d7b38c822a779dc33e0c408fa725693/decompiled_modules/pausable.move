module 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable {
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

