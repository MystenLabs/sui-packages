module 0x801a0a0750f2358d5a1e45539364b2cb234e74f4ca967ea8716807e1208250ae::lock {
    struct Lock<T0: store + key> has store, key {
        id: 0x2::object::UID,
        locked: 0x1::option::Option<T0>,
    }

    struct Key<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public entry fun lock<T0: store + key>(arg0: T0, arg1: &mut Lock<T0>, arg2: &Key<T0>) {
        assert!(0x1::option::is_none<T0>(&arg1.locked), 2);
        assert!(&arg2.for == 0x2::object::borrow_id<Lock<T0>>(arg1), 1);
        0x1::option::fill<T0>(&mut arg1.locked, arg0);
    }

    public entry fun create<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Lock<T0>{
            id     : v0,
            locked : 0x1::option::some<T0>(arg0),
        };
        0x2::transfer::public_share_object<Lock<T0>>(v1);
        let v2 = Key<T0>{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<Key<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun key_for<T0: store + key>(arg0: &Key<T0>) : 0x2::object::ID {
        arg0.for
    }

    public fun take<T0: store + key>(arg0: &mut Lock<T0>, arg1: &Key<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(unlock<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun unlock<T0: store + key>(arg0: &mut Lock<T0>, arg1: &Key<T0>) : T0 {
        assert!(0x1::option::is_some<T0>(&arg0.locked), 0);
        assert!(&arg1.for == 0x2::object::borrow_id<Lock<T0>>(arg0), 1);
        0x1::option::extract<T0>(&mut arg0.locked)
    }

    // decompiled from Move bytecode v6
}

