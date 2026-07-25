module 0xa83ecc4e530594f8e184faf6a4c3da6791267f6791a653644d59e2e603c055b8::vesting {
    struct VestingLock<phantom T0> has key {
        id: 0x2::object::UID,
        agent: address,
        balance: 0x2::balance::Balance<T0>,
        total: u64,
        released: u64,
        start_ms: u64,
        duration_ms: u64,
    }

    struct TreasuryVested has copy, drop {
        lock_id: 0x2::object::ID,
        agent: address,
        total: u64,
        start_ms: u64,
        duration_ms: u64,
    }

    struct TreasuryClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        agent: address,
        amount: u64,
        released_total: u64,
        timestamp_ms: u64,
    }

    public fun agent<T0>(arg0: &VestingLock<T0>) : address {
        arg0.agent
    }

    public fun claim<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = vested_amount<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(v0 > arg0.released, 0);
        let v1 = v0 - arg0.released;
        arg0.released = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2), arg0.agent);
        let v2 = TreasuryClaimed{
            lock_id        : 0x2::object::id<VestingLock<T0>>(arg0),
            agent          : arg0.agent,
            amount         : v1,
            released_total : arg0.released,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TreasuryClaimed>(v2);
    }

    public fun duration_ms<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.duration_ms
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = VestingLock<T0>{
            id          : 0x2::object::new(arg3),
            agent       : arg1,
            balance     : 0x2::coin::into_balance<T0>(arg0),
            total       : v1,
            released    : 0,
            start_ms    : v0,
            duration_ms : 15552000000,
        };
        let v3 = 0x2::object::id<VestingLock<T0>>(&v2);
        let v4 = TreasuryVested{
            lock_id     : v3,
            agent       : arg1,
            total       : v1,
            start_ms    : v0,
            duration_ms : 15552000000,
        };
        0x2::event::emit<TreasuryVested>(v4);
        0x2::transfer::share_object<VestingLock<T0>>(v2);
        v3
    }

    public fun released<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.released
    }

    public fun start_ms<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.start_ms
    }

    public fun total<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.total
    }

    public fun vested_amount<T0>(arg0: &VestingLock<T0>, arg1: u64) : u64 {
        if (arg1 <= arg0.start_ms) {
            return 0
        };
        let v0 = arg1 - arg0.start_ms;
        if (v0 >= arg0.duration_ms) {
            return arg0.total
        };
        (((arg0.total as u128) * (v0 as u128) / (arg0.duration_ms as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

