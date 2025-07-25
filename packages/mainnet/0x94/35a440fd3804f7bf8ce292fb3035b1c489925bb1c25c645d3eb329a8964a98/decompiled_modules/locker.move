module 0x9435a440fd3804f7bf8ce292fb3035b1c489925bb1c25c645d3eb329a8964a98::locker {
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

    public fun lock<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Key{id: 0x2::object::new(arg1)};
        let v1 = Locked<T0>{
            id  : 0x2::object::new(arg1),
            key : 0x2::object::id<Key>(&v0),
        };
        let v2 = LockedObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<LockedObjectKey, T0>(&mut v1.id, v2, arg0);
        0x2::transfer::share_object<Locked<T0>>(v1);
        0x2::transfer::transfer<Key>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: Key, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.key == 0x2::object::id<Key>(&arg1), 0);
        let Key { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = LockedObjectKey{dummy_field: false};
        let Locked {
            id  : v2,
            key : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<LockedObjectKey, T0>(&mut arg0.id, v1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

