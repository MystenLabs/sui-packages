module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe_events {
    struct Output<phantom T0, phantom T1: drop> has copy, drop {
        volume: u64,
    }

    struct Input<phantom T0, phantom T1: drop> has copy, drop {
        volume: u64,
    }

    public(friend) fun emit_input<T0, T1: drop>(arg0: &0x2::balance::Balance<T0>) {
        let v0 = Input<T0, T1>{volume: 0x2::balance::value<T0>(arg0)};
        0x2::event::emit<Input<T0, T1>>(v0);
    }

    public(friend) fun emit_output<T0, T1: drop>(arg0: u64) {
        let v0 = Output<T0, T1>{volume: arg0};
        0x2::event::emit<Output<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

