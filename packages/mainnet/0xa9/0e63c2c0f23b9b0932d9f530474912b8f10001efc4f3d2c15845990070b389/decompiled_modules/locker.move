module 0xa90e63c2c0f23b9b0932d9f530474912b8f10001efc4f3d2c15845990070b389::locker {
    struct LockedObjectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Locked<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        key_id: 0x2::object::ID,
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

    public entry fun lock<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Key{id: 0x2::object::new(arg1)};
        let v1 = Locked<T0>{
            id     : 0x2::object::new(arg1),
            key_id : 0x2::object::id<Key>(&v0),
        };
        let v2 = LockCreated{
            lock_id : 0x2::object::id<Locked<T0>>(&v1),
            key_id  : 0x2::object::id<Key>(&v0),
            creator : 0x2::tx_context::sender(arg1),
            item_id : 0x2::object::id<0x2::coin::Coin<T0>>(&arg0),
        };
        0x2::event::emit<LockCreated>(v2);
        let v3 = LockedObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<LockedObjectKey, 0x2::coin::Coin<T0>>(&mut v1.id, v3, arg0);
        0x2::transfer::share_object<Locked<T0>>(v1);
        0x2::transfer::transfer<Key>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: Key, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.key_id == 0x2::object::id<Key>(&arg1), 0);
        let Key { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = LockedObjectKey{dummy_field: false};
        let v2 = LockDestroyed{lock_id: 0x2::object::id<Locked<T0>>(&arg0)};
        0x2::event::emit<LockDestroyed>(v2);
        let Locked {
            id     : v3,
            key_id : _,
        } = arg0;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<LockedObjectKey, T0>(&mut arg0.id, v1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

