module 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap {
    struct UnpauseCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        group_id: 0x2::object::ID,
    }

    public(friend) fun delete<T0>(arg0: UnpauseCap<T0>) {
        let UnpauseCap {
            id       : v0,
            group_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : UnpauseCap<T0> {
        UnpauseCap<T0>{
            id       : 0x2::object::new(arg1),
            group_id : arg0,
        }
    }

    public fun burn<T0>(arg0: UnpauseCap<T0>) {
        let UnpauseCap {
            id       : v0,
            group_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun group_id<T0>(arg0: &UnpauseCap<T0>) : 0x2::object::ID {
        arg0.group_id
    }

    // decompiled from Move bytecode v6
}

