module 0xa90bba686d02e4fcbc62f8efb58f943f58e88ce55e4e29f5a0b14c994720915a::n {
    struct N has store, key {
        id: 0x2::object::UID,
        v: u64,
    }

    public fun bump(arg0: &mut N) {
        arg0.v = arg0.v + 1;
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : N {
        N{
            id : 0x2::object::new(arg0),
            v  : 0,
        }
    }

    public fun destroy(arg0: N) {
        let N {
            id : v0,
            v  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

