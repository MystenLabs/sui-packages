module 0x8de3003dfbbb997a906cb5bdf39a8ff24876ccc07b1e55f9a65462c67fa931c6::any {
    struct Any has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Any {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<vector<u8>, T0>(&mut v0, b"inner_type", arg0);
        Any{id: v0}
    }

    public fun cast<T0: store>(arg0: Any) : T0 {
        let Any { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<vector<u8>, T0>(&mut arg0.id, b"inner_type")
    }

    // decompiled from Move bytecode v6
}

