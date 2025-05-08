module 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::fragment_key {
    struct FragmentKey has store, key {
        id: 0x2::object::UID,
        action_id: 0x2::object::ID,
    }

    public fun new(arg0: &0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action::Action, arg1: &mut 0x2::tx_context::TxContext) : FragmentKey {
        FragmentKey{
            id        : 0x2::object::new(arg1),
            action_id : 0x2::object::id<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action::Action>(arg0),
        }
    }

    public fun action_id(arg0: &FragmentKey) : 0x2::object::ID {
        arg0.action_id
    }

    public fun destroy(arg0: FragmentKey) {
        let FragmentKey {
            id        : v0,
            action_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

