module 0x70def7106e477281dfa543efec0160b8a3b62a9034bdc91e1f18e26c1b852414::vesting_lock {
    struct New<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        cliff: u64,
        duration: u64,
        amount: u64,
    }

    struct Release<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct Split<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
        new_lock_id: 0x2::object::ID,
        new_amount: u64,
    }

    struct Destroy<phantom T0> has copy, drop {
        lock_id: 0x2::object::ID,
    }

    struct VestingLock<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        cliff: u64,
        duration: u64,
        released_amount: u64,
    }

    public fun destroy_empty<T0>(arg0: VestingLock<T0>) {
        let VestingLock {
            id              : v0,
            balance         : v1,
            cliff           : _,
            duration        : _,
            released_amount : _,
        } = arg0;
        let v5 = v1;
        let v6 = v0;
        if (0x2::balance::value<T0>(&v5) > 0) {
            err_cannot_destroy_non_empty_lock();
        };
        let v7 = Destroy<T0>{lock_id: 0x2::object::uid_to_inner(&v6)};
        0x2::event::emit<Destroy<T0>>(v7);
        0x2::object::delete(v6);
        0x2::balance::destroy_zero<T0>(v5);
    }

    public fun split<T0>(arg0: &mut VestingLock<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VestingLock<T0> {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_bps(arg1);
        if (0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::gt(v0, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(1)) || 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::eq(v0, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(0))) {
            err_invalid_portion();
        };
        let v1 = 0x2::balance::split<T0>(&mut arg0.balance, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(v0, value<T0>(arg0))));
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(v0, released_amount<T0>(arg0)));
        arg0.released_amount = released_amount<T0>(arg0) - v2;
        let v3 = 0x2::object::new(arg2);
        let v4 = Split<T0>{
            lock_id     : 0x2::object::id<VestingLock<T0>>(arg0),
            new_lock_id : 0x2::object::uid_to_inner(&v3),
            new_amount  : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<Split<T0>>(v4);
        VestingLock<T0>{
            id              : v3,
            balance         : v1,
            cliff           : cliff<T0>(arg0),
            duration        : duration<T0>(arg0),
            released_amount : v2,
        }
    }

    public fun value<T0>(arg0: &VestingLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : VestingLock<T0> {
        if (arg2 < 0x2::clock::timestamp_ms(arg1)) {
            err_invalid_cliff();
        };
        if (arg3 == 0) {
            err_duration_cannot_be_zero();
        };
        let v0 = 0x2::object::new(arg4);
        let v1 = New<T0>{
            lock_id  : 0x2::object::uid_to_inner(&v0),
            cliff    : arg2,
            duration : arg3,
            amount   : 0x2::balance::value<T0>(&arg0),
        };
        0x2::event::emit<New<T0>>(v1);
        VestingLock<T0>{
            id              : v0,
            balance         : arg0,
            cliff           : arg2,
            duration        : arg3,
            released_amount : 0,
        }
    }

    public fun cliff<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.cliff
    }

    public fun compute_vested_amount<T0>(arg0: &VestingLock<T0>, arg1: u64) : u64 {
        if (arg1 < cliff<T0>(arg0)) {
            0
        } else if (arg1 >= end<T0>(arg0)) {
            value<T0>(arg0) + released_amount<T0>(arg0)
        } else {
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg1 - cliff<T0>(arg0), duration<T0>(arg0)), value<T0>(arg0) + released_amount<T0>(arg0)))
        }
    }

    entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VestingLock<T0>>(new<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2, arg3, arg5), arg4);
    }

    public fun duration<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.duration
    }

    public fun end<T0>(arg0: &VestingLock<T0>) : u64 {
        cliff<T0>(arg0) + duration<T0>(arg0)
    }

    fun err_cannot_destroy_non_empty_lock() {
        abort 1
    }

    fun err_duration_cannot_be_zero() {
        abort 3
    }

    fun err_invalid_cliff() {
        abort 2
    }

    fun err_invalid_portion() {
        abort 4
    }

    fun err_zero_releaseable_amount() {
        abort 0
    }

    public fun releasable_amount<T0>(arg0: &VestingLock<T0>, arg1: &0x2::clock::Clock) : u64 {
        compute_vested_amount<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) - released_amount<T0>(arg0)
    }

    public fun release<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = releasable_amount<T0>(arg0, arg1);
        if (v0 == 0) {
            err_zero_releaseable_amount();
        };
        arg0.released_amount = released_amount<T0>(arg0) + v0;
        let v1 = Release<T0>{
            lock_id : 0x2::object::id<VestingLock<T0>>(arg0),
            amount  : v0,
        };
        0x2::event::emit<Release<T0>>(v1);
        0x2::balance::split<T0>(&mut arg0.balance, v0)
    }

    entry fun release_to<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(release<T0>(arg0, arg1), arg3), arg2);
    }

    public fun released_amount<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.released_amount
    }

    entry fun split_to<T0>(arg0: &mut VestingLock<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VestingLock<T0>>(split<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

