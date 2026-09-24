module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting {
    struct VestingLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        locked: 0x2::balance::Balance<T0>,
        schedule_total: u64,
        released: u64,
        start_ms: u64,
        duration_ms: u64,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        duration_ms: u64,
    }

    struct LockToppedUp has copy, drop {
        lock_id: 0x2::object::ID,
        added: u64,
        new_total: u64,
    }

    struct LockClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public fun claim<T0>(arg0: &mut VestingLock<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 301);
        let v0 = vested_unreleased<T0>(arg0, arg2);
        assert!(v0 > 0, 303);
        release<T0>(arg0, v0, arg3);
    }

    public fun create<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::share_object<VestingLock<T0>>(new_lock<T0>(arg1, arg2, v0, arg3, arg4));
    }

    public fun duration_ms_for_days(arg0: u64) : u64 {
        let v0 = if (arg0 == 7) {
            true
        } else if (arg0 == 30) {
            true
        } else if (arg0 == 90) {
            true
        } else {
            arg0 == 180
        };
        assert!(v0, 300);
        arg0 * 86400000
    }

    public fun end_ms<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.start_ms + arg0.duration_ms
    }

    public fun locked_amount<T0>(arg0: &VestingLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public(friend) fun new_lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VestingLock<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 302);
        let v1 = duration_ms_for_days(arg1);
        let v2 = VestingLock<T0>{
            id             : 0x2::object::new(arg4),
            owner          : arg2,
            locked         : 0x2::coin::into_balance<T0>(arg0),
            schedule_total : v0,
            released       : 0,
            start_ms       : 0x2::clock::timestamp_ms(arg3),
            duration_ms    : v1,
        };
        let v3 = LockCreated{
            lock_id     : 0x2::object::id<VestingLock<T0>>(&v2),
            owner       : arg2,
            amount      : v0,
            duration_ms : v1,
        };
        0x2::event::emit<LockCreated>(v3);
        v2
    }

    public fun owner<T0>(arg0: &VestingLock<T0>) : address {
        arg0.owner
    }

    fun release<T0>(arg0: &mut VestingLock<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.released = arg0.released + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.locked, arg1, arg2), arg0.owner);
        let v0 = LockClaimed{
            lock_id : 0x2::object::id<VestingLock<T0>>(arg0),
            amount  : arg1,
        };
        0x2::event::emit<LockClaimed>(v0);
    }

    public(friend) fun share<T0>(arg0: VestingLock<T0>) {
        0x2::transfer::share_object<VestingLock<T0>>(arg0);
    }

    public fun top_up<T0>(arg0: &mut VestingLock<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 301);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 302);
        let v1 = vested_unreleased<T0>(arg0, arg3);
        if (v1 > 0) {
            release<T0>(arg0, v1, arg4);
        };
        0x2::balance::join<T0>(&mut arg0.locked, 0x2::coin::into_balance<T0>(arg2));
        arg0.schedule_total = 0x2::balance::value<T0>(&arg0.locked);
        arg0.released = 0;
        arg0.start_ms = 0x2::clock::timestamp_ms(arg3);
        let v2 = LockToppedUp{
            lock_id   : 0x2::object::id<VestingLock<T0>>(arg0),
            added     : v0,
            new_total : arg0.schedule_total,
        };
        0x2::event::emit<LockToppedUp>(v2);
    }

    public fun vested_unreleased<T0>(arg0: &VestingLock<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.start_ms;
        let v1 = if (v0 >= arg0.duration_ms) {
            arg0.schedule_total
        } else {
            0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg0.schedule_total, v0, arg0.duration_ms)
        };
        v1 - arg0.released
    }

    // decompiled from Move bytecode v7
}

