module 0x410ceddd715f97c511d21a17a95a3eedbab9b23de7c6773ff2a9aa5172217109::billa_github2016_lock {
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

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        key_id: 0x2::object::ID,
        creator: address,
        item_id: 0x2::object::ID,
    }

    struct LockDestroyed has copy, drop {
        lock_id: 0x2::object::ID,
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (Locked<T0>, Key) {
        let v0 = Key{id: 0x2::object::new(arg1)};
        let v1 = Locked<T0>{
            id  : 0x2::object::new(arg1),
            key : 0x2::object::id<Key>(&v0),
        };
        let v2 = LockCreated{
            lock_id : 0x2::object::id<Locked<T0>>(&v1),
            key_id  : 0x2::object::id<Key>(&v0),
            creator : 0x2::tx_context::sender(arg1),
            item_id : 0x2::object::id<T0>(&arg0),
        };
        0x2::event::emit<LockCreated>(v2);
        let v3 = LockedObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<LockedObjectKey, T0>(&mut v1.id, v3, arg0);
        (v1, v0)
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: Key) : T0 {
        assert!(arg0.key == 0x2::object::id<Key>(&arg1), 0);
        let Key { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = LockedObjectKey{dummy_field: false};
        let v2 = LockDestroyed{lock_id: 0x2::object::id<Locked<T0>>(&arg0)};
        0x2::event::emit<LockDestroyed>(v2);
        let Locked {
            id  : v3,
            key : _,
        } = arg0;
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<LockedObjectKey, T0>(&mut arg0.id, v1)
    }

    // decompiled from Move bytecode v6
}

