module 0x44c8fe12c1aa228e2d205f3f665c22dc968b753480e6cbb7e1a152554e1c706b::lock {
    struct LockedObjectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Locked<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        key: 0x2::object::ID,
    }

    struct Key has store, key {
        id: 0x2::object::UID,
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (Locked<T0>, Key) {
        let v0 = Key{id: 0x2::object::new(arg1)};
        let v1 = Locked<T0>{
            id  : 0x2::object::new(arg1),
            key : 0x2::object::id<Key>(&v0),
        };
        let v2 = LockedObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<LockedObjectKey, T0>(&mut v1.id, v2, arg0);
        (v1, v0)
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: Key, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::object::id<Key>(&arg1) == arg0.key, 13906834307487367167);
        let Key { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = LockedObjectKey{dummy_field: false};
        let Locked {
            id  : v2,
            key : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::dynamic_object_field::remove<LockedObjectKey, T0>(&mut arg0.id, v1)
    }

    // decompiled from Move bytecode v6
}

