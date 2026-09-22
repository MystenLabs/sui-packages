module 0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock {
    struct PopLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        locked: 0x2::balance::Balance<T0>,
        pending: 0x2::balance::Balance<T0>,
        ready_ms: u64,
    }

    struct Locked<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        locked: u64,
    }

    struct WithdrawRequested<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        locked: u64,
        pending: u64,
        ready_ms: u64,
    }

    struct WithdrawCancelled<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        locked: u64,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        locked: u64,
    }

    struct LockClosed<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
    }

    public fun add<T0>(arg0: &mut PopLock<T0>, arg1: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::Config, arg2: 0x2::coin::Coin<T0>) {
        0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::assert_version(arg1);
        deposit<T0>(arg0, arg2);
    }

    public fun cancel_withdraw<T0>(arg0: &mut PopLock<T0>, arg1: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::Config) {
        0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::assert_version(arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.pending);
        assert!(v0 > 0, 202);
        0x2::balance::join<T0>(&mut arg0.locked, 0x2::balance::withdraw_all<T0>(&mut arg0.pending));
        arg0.ready_ms = 0;
        let v1 = WithdrawCancelled<T0>{
            lock_id : 0x2::object::id<PopLock<T0>>(arg0),
            owner   : arg0.owner,
            amount  : v0,
            locked  : 0x2::balance::value<T0>(&arg0.locked),
        };
        0x2::event::emit<WithdrawCancelled<T0>>(v1);
    }

    public fun close<T0>(arg0: PopLock<T0>, arg1: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::Config) {
        0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::assert_version(arg1);
        assert!(0x2::balance::value<T0>(&arg0.locked) == 0 && 0x2::balance::value<T0>(&arg0.pending) == 0, 204);
        let PopLock {
            id       : v0,
            owner    : v1,
            locked   : v2,
            pending  : v3,
            ready_ms : _,
        } = arg0;
        let v5 = v0;
        let v6 = LockClosed<T0>{
            lock_id : 0x2::object::uid_to_inner(&v5),
            owner   : v1,
        };
        0x2::event::emit<LockClosed<T0>>(v6);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v5);
    }

    fun deposit<T0>(arg0: &mut PopLock<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 200);
        0x2::balance::join<T0>(&mut arg0.locked, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Locked<T0>{
            lock_id : 0x2::object::id<PopLock<T0>>(arg0),
            owner   : arg0.owner,
            amount  : v0,
            locked  : 0x2::balance::value<T0>(&arg0.locked),
        };
        0x2::event::emit<Locked<T0>>(v1);
    }

    public fun locked_amount<T0>(arg0: &PopLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun open<T0>(arg0: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = PopLock<T0>{
            id       : 0x2::object::new(arg2),
            owner    : v0,
            locked   : 0x2::balance::zero<T0>(),
            pending  : 0x2::balance::zero<T0>(),
            ready_ms : 0,
        };
        let v2 = &mut v1;
        deposit<T0>(v2, arg1);
        0x2::transfer::transfer<PopLock<T0>>(v1, v0);
    }

    public fun owner<T0>(arg0: &PopLock<T0>) : address {
        arg0.owner
    }

    public fun pending_amount<T0>(arg0: &PopLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pending)
    }

    public fun ready_ms<T0>(arg0: &PopLock<T0>) : u64 {
        arg0.ready_ms
    }

    public fun request_withdraw<T0>(arg0: &mut PopLock<T0>, arg1: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::Config, arg2: u64, arg3: &0x2::clock::Clock) {
        0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::assert_version(arg1);
        assert!(arg2 > 0, 200);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.locked), 201);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::balance::split<T0>(&mut arg0.locked, arg2));
        arg0.ready_ms = 0x2::clock::timestamp_ms(arg3) + 86400000;
        let v0 = WithdrawRequested<T0>{
            lock_id  : 0x2::object::id<PopLock<T0>>(arg0),
            owner    : arg0.owner,
            amount   : arg2,
            locked   : 0x2::balance::value<T0>(&arg0.locked),
            pending  : 0x2::balance::value<T0>(&arg0.pending),
            ready_ms : arg0.ready_ms,
        };
        0x2::event::emit<WithdrawRequested<T0>>(v0);
    }

    public fun withdraw<T0>(arg0: &mut PopLock<T0>, arg1: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::config::assert_version(arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.pending);
        assert!(v0 > 0, 202);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.ready_ms, 203);
        arg0.ready_ms = 0;
        let v1 = Withdrawn<T0>{
            lock_id : 0x2::object::id<PopLock<T0>>(arg0),
            owner   : arg0.owner,
            amount  : v0,
            locked  : 0x2::balance::value<T0>(&arg0.locked),
        };
        0x2::event::emit<Withdrawn<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending), arg3)
    }

    public fun withdraw_delay_ms() : u64 {
        86400000
    }

    // decompiled from Move bytecode v7
}

