module 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::wit_collection {
    struct WitCollection<phantom T0, T1> has store, key {
        id: 0x2::object::UID,
        collection: T1,
    }

    public fun borrow<T0: drop, T1: store>(arg0: &WitCollection<T0, T1>) : &T1 {
        &arg0.collection
    }

    public fun borrow_mut<T0: drop, T1: store>(arg0: &mut WitCollection<T0, T1>, arg1: T0) : &mut T1 {
        &mut arg0.collection
    }

    public fun new<T0: drop, T1: store>(arg0: T1, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : WitCollection<T0, T1> {
        WitCollection<T0, T1>{
            id         : 0x2::object::new(arg2),
            collection : arg0,
        }
    }

    public fun borrow_mut_uid<T0: drop, T1: store>(arg0: &mut WitCollection<T0, T1>, arg1: T0) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun destroy<T0: drop, T1: store>(arg0: WitCollection<T0, T1>, arg1: T0) : T1 {
        let WitCollection {
            id         : v0,
            collection : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun drop<T0: drop, T1: drop + store>(arg0: WitCollection<T0, T1>, arg1: T0) {
        let WitCollection {
            id         : v0,
            collection : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

