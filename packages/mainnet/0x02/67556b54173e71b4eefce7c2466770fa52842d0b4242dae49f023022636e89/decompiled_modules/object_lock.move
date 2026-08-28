module 0xe0f23402fae139961a3d5ffa99d054a7821b82295eb5988957053f0c9a4dd14d::object_lock {
    struct ObjectLock<T0: store + key> has key {
        id: 0x2::object::UID,
        item: 0x1::option::Option<T0>,
        unlock_ms: u64,
        beneficiary: address,
        creator: address,
        locked_at_ms: u64,
    }

    struct ObjectLocked has copy, drop {
        lock_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        unlock_ms: u64,
        creator: address,
        beneficiary: address,
    }

    struct ObjectClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        beneficiary: address,
    }

    struct LockExtended has copy, drop {
        lock_id: 0x2::object::ID,
        old_unlock_ms: u64,
        new_unlock_ms: u64,
    }

    public fun beneficiary<T0: store + key>(arg0: &ObjectLock<T0>) : address {
        arg0.beneficiary
    }

    public fun claim<T0: store + key>(arg0: &mut ObjectLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(0x1::option::is_some<T0>(&arg0.item), 3);
        let v0 = 0x1::option::extract<T0>(&mut arg0.item);
        let v1 = ObjectClaimed{
            lock_id     : 0x2::object::id<ObjectLock<T0>>(arg0),
            item_id     : 0x2::object::id<T0>(&v0),
            beneficiary : arg0.beneficiary,
        };
        0x2::event::emit<ObjectClaimed>(v1);
        0x2::transfer::public_transfer<T0>(v0, arg0.beneficiary);
    }

    public fun creator<T0: store + key>(arg0: &ObjectLock<T0>) : address {
        arg0.creator
    }

    public fun extend<T0: store + key>(arg0: &mut ObjectLock<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(0x1::option::is_some<T0>(&arg0.item), 3);
        assert!(arg1 > arg0.unlock_ms, 4);
        let v0 = LockExtended{
            lock_id       : 0x2::object::id<ObjectLock<T0>>(arg0),
            old_unlock_ms : arg0.unlock_ms,
            new_unlock_ms : arg1,
        };
        0x2::event::emit<LockExtended>(v0);
        arg0.unlock_ms = arg1;
    }

    public fun is_claimed<T0: store + key>(arg0: &ObjectLock<T0>) : bool {
        0x1::option::is_none<T0>(&arg0.item)
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg3), 2);
        assert!(arg2 != @0x0, 5);
        let v0 = ObjectLock<T0>{
            id           : 0x2::object::new(arg4),
            item         : 0x1::option::some<T0>(arg0),
            unlock_ms    : arg1,
            beneficiary  : arg2,
            creator      : 0x2::tx_context::sender(arg4),
            locked_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = ObjectLocked{
            lock_id     : 0x2::object::id<ObjectLock<T0>>(&v0),
            item_id     : 0x2::object::id<T0>(&arg0),
            unlock_ms   : arg1,
            creator     : 0x2::tx_context::sender(arg4),
            beneficiary : arg2,
        };
        0x2::event::emit<ObjectLocked>(v1);
        0x2::transfer::share_object<ObjectLock<T0>>(v0);
    }

    public fun lock_self<T0: store + key>(arg0: T0, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        lock<T0>(arg0, arg1, v0, arg2, arg3);
    }

    public fun locked_at_ms<T0: store + key>(arg0: &ObjectLock<T0>) : u64 {
        arg0.locked_at_ms
    }

    public fun unlock_ms<T0: store + key>(arg0: &ObjectLock<T0>) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v7
}

