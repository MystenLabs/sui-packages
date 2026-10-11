module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock {
    struct ItemKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LpLock<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        locked_at_ms: u64,
        unlock_at_ms: u64,
        withdrawn: bool,
    }

    struct LpLockCap has store, key {
        id: 0x2::object::UID,
        lock_id: 0x2::object::ID,
    }

    struct Locked has copy, drop {
        lock_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        locked_at_ms: u64,
        unlock_at_ms: u64,
        permanent: bool,
        locker: address,
    }

    struct Extended has copy, drop {
        lock_id: 0x2::object::ID,
        old_unlock_at_ms: u64,
        new_unlock_at_ms: u64,
    }

    struct Withdrawn has copy, drop {
        lock_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        at_ms: u64,
        to: address,
    }

    public(friend) fun borrow<T0: store + key>(arg0: &LpLock<T0>, arg1: &LpLockCap) : &T0 {
        assert!(arg1.lock_id == 0x2::object::id<LpLock<T0>>(arg0), 301);
        assert!(!arg0.withdrawn, 304);
        let v0 = ItemKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<ItemKey, T0>(&arg0.id, v0)
    }

    public fun cap_lock_id(arg0: &LpLockCap) : 0x2::object::ID {
        arg0.lock_id
    }

    public fun extend<T0: store + key>(arg0: &mut LpLock<T0>, arg1: &LpLockCap, arg2: u64) {
        assert!(arg1.lock_id == 0x2::object::id<LpLock<T0>>(arg0), 301);
        assert!(!arg0.withdrawn, 304);
        assert!(arg2 > arg0.unlock_at_ms, 306);
        let v0 = Extended{
            lock_id          : 0x2::object::id<LpLock<T0>>(arg0),
            old_unlock_at_ms : arg0.unlock_at_ms,
            new_unlock_at_ms : arg2,
        };
        0x2::event::emit<Extended>(v0);
        arg0.unlock_at_ms = arg2;
    }

    public fun is_permanent<T0: store + key>(arg0: &LpLock<T0>) : bool {
        arg0.unlock_at_ms == 18446744073709551615
    }

    public fun is_withdrawn<T0: store + key>(arg0: &LpLock<T0>) : bool {
        arg0.withdrawn
    }

    public fun item_id<T0: store + key>(arg0: &LpLock<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : LpLockCap {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > v0, 305);
        let v1 = 0x2::object::id<T0>(&arg0);
        let v2 = 0x2::object::new(arg3);
        let v3 = ItemKey{dummy_field: false};
        0x2::dynamic_object_field::add<ItemKey, T0>(&mut v2, v3, arg0);
        let v4 = 0x2::object::uid_to_inner(&v2);
        let v5 = Locked{
            lock_id      : v4,
            item_id      : v1,
            locked_at_ms : v0,
            unlock_at_ms : arg1,
            permanent    : arg1 == 18446744073709551615,
            locker       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Locked>(v5);
        let v6 = LpLock<T0>{
            id           : v2,
            item_id      : v1,
            locked_at_ms : v0,
            unlock_at_ms : arg1,
            withdrawn    : false,
        };
        0x2::transfer::share_object<LpLock<T0>>(v6);
        LpLockCap{
            id      : 0x2::object::new(arg3),
            lock_id : v4,
        }
    }

    public fun lock_permanent<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : LpLockCap {
        lock<T0>(arg0, 18446744073709551615, arg1, arg2)
    }

    public fun locked_at_ms<T0: store + key>(arg0: &LpLock<T0>) : u64 {
        arg0.locked_at_ms
    }

    public fun permanent_sentinel() : u64 {
        18446744073709551615
    }

    public fun unlock_at_ms<T0: store + key>(arg0: &LpLock<T0>) : u64 {
        arg0.unlock_at_ms
    }

    public fun withdraw<T0: store + key>(arg0: &mut LpLock<T0>, arg1: LpLockCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(arg1.lock_id == 0x2::object::id<LpLock<T0>>(arg0), 301);
        assert!(arg0.unlock_at_ms != 18446744073709551615, 302);
        assert!(!arg0.withdrawn, 304);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.unlock_at_ms, 303);
        let LpLockCap {
            id      : v1,
            lock_id : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.withdrawn = true;
        let v3 = Withdrawn{
            lock_id : 0x2::object::id<LpLock<T0>>(arg0),
            item_id : arg0.item_id,
            at_ms   : v0,
            to      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdrawn>(v3);
        let v4 = ItemKey{dummy_field: false};
        0x2::dynamic_object_field::remove<ItemKey, T0>(&mut arg0.id, v4)
    }

    // decompiled from Move bytecode v7
}

