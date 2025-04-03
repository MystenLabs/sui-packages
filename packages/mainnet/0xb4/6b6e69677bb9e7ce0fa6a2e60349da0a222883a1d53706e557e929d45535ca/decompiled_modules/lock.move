module 0xb46b6e69677bb9e7ce0fa6a2e60349da0a222883a1d53706e557e929d45535ca::lock {
    struct Locked<T0: store> has store, key {
        id: 0x2::object::UID,
        key: 0x2::object::ID,
        obj: T0,
    }

    struct Key has store, key {
        id: 0x2::object::UID,
    }

    public fun lock<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (Locked<T0>, Key) {
        let v0 = Key{id: 0x2::object::new(arg1)};
        let v1 = Locked<T0>{
            id  : 0x2::object::new(arg1),
            key : 0x2::object::id<Key>(&v0),
            obj : arg0,
        };
        (v1, v0)
    }

    public fun unlock<T0: store>(arg0: Locked<T0>, arg1: Key) : T0 {
        assert!(arg0.key == 0x2::object::id<Key>(&arg1), 0);
        let Key { id: v0 } = arg1;
        0x2::object::delete(v0);
        let Locked {
            id  : v1,
            key : _,
            obj : v3,
        } = arg0;
        0x2::object::delete(v1);
        v3
    }

    // decompiled from Move bytecode v6
}

