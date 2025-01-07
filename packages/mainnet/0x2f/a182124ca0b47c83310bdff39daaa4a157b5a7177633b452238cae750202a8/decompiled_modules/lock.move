module 0x2fa182124ca0b47c83310bdff39daaa4a157b5a7177633b452238cae750202a8::lock {
    struct Locked<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        key: 0x2::object::ID,
    }

    struct Key has store, key {
        id: 0x2::object::UID,
    }

    struct LockedObject has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun lock<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Key{id: 0x2::object::new(arg1)};
        let v1 = Locked<T0>{
            id  : 0x2::object::new(arg1),
            key : 0x2::object::id<Key>(&v0),
        };
        let v2 = LockedObject{dummy_field: false};
        0x2::dynamic_object_field::add<LockedObject, T0>(&mut v1.id, v2, arg0);
        0x2::transfer::public_transfer<Locked<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<Key>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun unlockAndTransfer<T0: store + key>(arg0: Locked<T0>, arg1: Key, arg2: address) {
        assert!(arg0.key == 0x2::object::id<Key>(&arg1), 2);
        let Key { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = LockedObject{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<LockedObject, T0>(&mut arg0.id, v1), arg2);
        let Locked {
            id  : v2,
            key : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

