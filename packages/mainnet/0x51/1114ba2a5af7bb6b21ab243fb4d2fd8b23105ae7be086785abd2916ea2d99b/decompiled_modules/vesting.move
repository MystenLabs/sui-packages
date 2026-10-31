module 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::vesting {
    struct LockMigrated has copy, drop {
        lock_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct VestingLock<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        beneficiary: address,
        locked: 0x2::balance::Balance<T0>,
        total_amount: u64,
        claimed: u64,
        start_ms: u64,
        duration_ms: u64,
        mode: u8,
        version: u64,
    }

    struct TokensLocked has copy, drop {
        lock_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        beneficiary: address,
        total_amount: u64,
        start_ms: u64,
        duration_ms: u64,
        mode: u8,
    }

    struct VestedClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        remaining: u64,
    }

    fun assert_lock_version<T0>(arg0: &VestingLock<T0>) {
        assert!(arg0.version == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853635798883106833);
    }

    public fun claim_vested<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_lock_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.beneficiary, 13844347524083089417);
        let v1 = vested_amount(arg0.total_amount, arg0.start_ms, arg0.duration_ms, arg0.mode, 0x2::clock::timestamp_ms(arg1));
        let v2 = if (v1 > arg0.claimed) {
            v1 - arg0.claimed
        } else {
            0
        };
        assert!(v2 > 0, 13844629020534767627);
        arg0.claimed = arg0.claimed + v2;
        let v3 = VestedClaimed{
            lock_id     : 0x2::object::id<VestingLock<T0>>(arg0),
            beneficiary : v0,
            amount      : v2,
            remaining   : 0x2::balance::value<T0>(&arg0.locked),
        };
        0x2::event::emit<VestedClaimed>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked, v2), arg2)
    }

    public fun destroy_empty_lock<T0>(arg0: VestingLock<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.beneficiary, 13844347631457271817);
        assert!(0x2::balance::value<T0>(&arg0.locked) == 0, 13859265809518297103);
        let VestingLock {
            id           : v0,
            curve_id     : _,
            beneficiary  : _,
            locked       : v3,
            total_amount : _,
            claimed      : _,
            start_ms     : _,
            duration_ms  : _,
            mode         : _,
            version      : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun lock_beneficiary<T0>(arg0: &VestingLock<T0>) : address {
        arg0.beneficiary
    }

    public fun lock_claimed<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.claimed
    }

    public fun lock_remaining<T0>(arg0: &VestingLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun lock_tokens<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::assert_curve_version<T0>(arg0);
        assert!(!0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::paused<T0>(arg0), 13842939878616072193);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13844910212043767821);
        let v1 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v1, 13843502858634395651);
        let v2 = if (arg3 == 604800000) {
            true
        } else if (arg3 == 2592000000) {
            true
        } else if (arg3 == 15552000000) {
            true
        } else {
            arg3 == 31536000000
        };
        assert!(v2, 13843784363676008453);
        if (arg2 == 2) {
            assert!(arg3 >= 2592000000, 13844065851537752071);
        };
        let v3 = VestingLock<T0>{
            id           : 0x2::object::new(arg5),
            curve_id     : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg0),
            beneficiary  : 0x2::tx_context::sender(arg5),
            locked       : 0x2::coin::into_balance<T0>(arg1),
            total_amount : v0,
            claimed      : 0,
            start_ms     : 0x2::clock::timestamp_ms(arg4),
            duration_ms  : arg3,
            mode         : arg2,
            version      : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        let v4 = TokensLocked{
            lock_id      : 0x2::object::id<VestingLock<T0>>(&v3),
            curve_id     : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg0),
            beneficiary  : v3.beneficiary,
            total_amount : v0,
            start_ms     : v3.start_ms,
            duration_ms  : arg3,
            mode         : arg2,
        };
        0x2::event::emit<TokensLocked>(v4);
        0x2::transfer::share_object<VestingLock<T0>>(v3);
    }

    public fun lock_total<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.total_amount
    }

    public fun lock_version<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.version
    }

    public fun migrate_lock<T0>(arg0: &mut VestingLock<T0>) {
        assert!(arg0.version < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853635833242845201);
        arg0.version = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current();
        let v0 = LockMigrated{
            lock_id      : 0x2::object::id<VestingLock<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        0x2::event::emit<LockMigrated>(v0);
    }

    fun vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64) : u64 {
        if (arg4 < arg1) {
            return 0
        };
        let v0 = arg4 - arg1;
        if (arg3 == 0) {
            if (v0 >= arg2) {
                arg0
            } else {
                0
            }
        } else if (arg3 == 1) {
            if (v0 >= arg2) {
                arg0
            } else {
                (((arg0 as u128) * (v0 as u128) / (arg2 as u128)) as u64)
            }
        } else if (v0 >= arg2) {
            arg0
        } else {
            let v2 = arg2 / 2592000000;
            if (v2 == 0) {
                0
            } else {
                let v3 = v0 / 2592000000;
                let v4 = if (v3 >= v2) {
                    v2 - 1
                } else {
                    v3
                };
                (((arg0 as u128) * (v4 as u128) / (v2 as u128)) as u64)
            }
        }
    }

    // decompiled from Move bytecode v7
}

