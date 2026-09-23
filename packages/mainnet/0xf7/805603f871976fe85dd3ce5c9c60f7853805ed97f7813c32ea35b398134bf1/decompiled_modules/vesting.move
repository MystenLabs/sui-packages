module 0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::vesting {
    struct VestingLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        offer_id: 0x2::object::ID,
        locked: 0x2::balance::Balance<T0>,
        schedule_total: u64,
        released: u64,
        start_ms: u64,
        duration_ms: u64,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        start_ms: u64,
        duration_ms: u64,
    }

    struct LockClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        left: u64,
    }

    struct LockClosed has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
    }

    public fun claim<T0>(arg0: &mut VestingLock<T0>, arg1: &0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 300);
        let v0 = vested_unreleased<T0>(arg0, arg2);
        assert!(v0 > 0, 302);
        arg0.released = arg0.released + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.locked, v0, arg3), arg0.owner);
        let v1 = LockClaimed{
            lock_id : 0x2::object::id<VestingLock<T0>>(arg0),
            owner   : arg0.owner,
            amount  : v0,
            left    : 0x2::balance::value<T0>(&arg0.locked),
        };
        0x2::event::emit<LockClaimed>(v1);
    }

    public fun close<T0>(arg0: VestingLock<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 300);
        assert!(0x2::balance::value<T0>(&arg0.locked) == 0, 303);
        let v0 = LockClosed{
            lock_id : 0x2::object::id<VestingLock<T0>>(&arg0),
            owner   : arg0.owner,
        };
        0x2::event::emit<LockClosed>(v0);
        let VestingLock {
            id             : v1,
            owner          : _,
            offer_id       : _,
            locked         : v4,
            schedule_total : _,
            released       : _,
            start_ms       : _,
            duration_ms    : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v4);
        0x2::object::delete(v1);
    }

    public fun duration_ms<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.duration_ms
    }

    public fun end_ms<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.start_ms + arg0.duration_ms
    }

    public(friend) fun keep<T0>(arg0: VestingLock<T0>) {
        0x2::transfer::transfer<VestingLock<T0>>(arg0, arg0.owner);
    }

    public fun locked_amount<T0>(arg0: &VestingLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public(friend) fun new_lock<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VestingLock<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0, 301);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = VestingLock<T0>{
            id             : 0x2::object::new(arg5),
            owner          : arg2,
            offer_id       : arg1,
            locked         : arg0,
            schedule_total : v0,
            released       : 0,
            start_ms       : v1,
            duration_ms    : arg3,
        };
        let v3 = LockCreated{
            lock_id     : 0x2::object::id<VestingLock<T0>>(&v2),
            offer_id    : arg1,
            owner       : arg2,
            amount      : v0,
            start_ms    : v1,
            duration_ms : arg3,
        };
        0x2::event::emit<LockCreated>(v3);
        v2
    }

    public fun offer_id<T0>(arg0: &VestingLock<T0>) : 0x2::object::ID {
        arg0.offer_id
    }

    public fun owner<T0>(arg0: &VestingLock<T0>) : address {
        arg0.owner
    }

    public fun released<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.released
    }

    public fun schedule_total<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.schedule_total
    }

    public fun start_ms<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.start_ms
    }

    public fun vested_unreleased<T0>(arg0: &VestingLock<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.start_ms) {
            return 0
        };
        let v1 = v0 - arg0.start_ms;
        let v2 = if (v1 >= arg0.duration_ms) {
            arg0.schedule_total
        } else {
            0xf7805603f871976fe85dd3ce5c9c60f7853805ed97f7813c32ea35b398134bf1::math::mul_div(arg0.schedule_total, v1, arg0.duration_ms)
        };
        v2 - arg0.released
    }

    // decompiled from Move bytecode v7
}

