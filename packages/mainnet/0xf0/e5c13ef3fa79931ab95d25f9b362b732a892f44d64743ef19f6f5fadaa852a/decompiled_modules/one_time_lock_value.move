module 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::one_time_lock_value {
    struct OneTimeLockValue<T0: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        value: T0,
        lock_until_epoch: u64,
        valid_before_epoch: u64,
    }

    public fun new<T0: copy + drop + store>(arg0: T0, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : OneTimeLockValue<T0> {
        let v0 = 0x2::tx_context::epoch(arg3) + arg1;
        let v1 = if (arg2 > 0) {
            v0 + arg2
        } else {
            0
        };
        OneTimeLockValue<T0>{
            id                 : 0x2::object::new(arg3),
            value              : arg0,
            lock_until_epoch   : v0,
            valid_before_epoch : v1,
        }
    }

    public fun destroy<T0: copy + drop + store>(arg0: OneTimeLockValue<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let OneTimeLockValue {
            id                 : v0,
            value              : _,
            lock_until_epoch   : _,
            valid_before_epoch : v3,
        } = arg0;
        0x2::object::delete(v0);
        assert!(v3 > 0, 3);
        assert!(0x2::tx_context::epoch(arg1) >= v3, 3);
    }

    public fun get_value<T0: copy + drop + store>(arg0: OneTimeLockValue<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        let OneTimeLockValue {
            id                 : v0,
            value              : v1,
            lock_until_epoch   : v2,
            valid_before_epoch : v3,
        } = arg0;
        0x2::object::delete(v0);
        let v4 = 0x2::tx_context::epoch(arg1);
        assert!(v2 <= v4, 2);
        if (v3 > 0) {
            assert!(v4 < v3, 1);
        };
        v1
    }

    public fun lock_until_epoch<T0: copy + drop + store>(arg0: &OneTimeLockValue<T0>) : u64 {
        arg0.lock_until_epoch
    }

    public fun valid_before_epoch<T0: copy + drop + store>(arg0: &OneTimeLockValue<T0>) : u64 {
        arg0.valid_before_epoch
    }

    // decompiled from Move bytecode v6
}

