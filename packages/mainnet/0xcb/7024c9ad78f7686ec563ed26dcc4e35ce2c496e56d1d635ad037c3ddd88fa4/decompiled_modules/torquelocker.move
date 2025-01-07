module 0xcb7024c9ad78f7686ec563ed26dcc4e35ce2c496e56d1d635ad037c3ddd88fa4::torquelocker {
    struct Locker<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        unlocked: u64,
        duration: u64,
    }

    public fun balance<T0>(arg0: &Locker<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Locker<T0>) {
        let Locker {
            id       : v0,
            balance  : v1,
            start    : _,
            unlocked : _,
            duration : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Locker<T0> {
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg2), 0);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        Locker<T0>{
            id       : 0x2::object::new(arg5),
            balance  : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg5)),
            start    : arg3,
            unlocked : 0,
            duration : arg4,
        }
    }

    public fun duration<T0>(arg0: &Locker<T0>) : u64 {
        arg0.duration
    }

    entry fun entry_destroy_zero<T0>(arg0: Locker<T0>) {
        destroy_zero<T0>(arg0);
    }

    entry fun entry_new<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        0x2::transfer::public_transfer<Locker<T0>>(new<T0>(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    entry fun entry_unlock<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun lock_status<T0>(arg0: &Locker<T0>, arg1: &0x2::clock::Clock) : u64 {
        locked_amount(arg0.start, arg0.duration, 0x2::balance::value<T0>(&arg0.balance), arg0.unlocked, 0x2::clock::timestamp_ms(arg1)) - arg0.unlocked
    }

    fun locked_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        locking_schedule(arg0, arg1, arg2 + arg3, arg4)
    }

    fun locking_schedule(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg0) {
            0
        } else if (arg3 >= arg0 + arg1) {
            arg2
        } else {
            arg2 * (arg3 - arg0) / arg1
        }
    }

    public fun start<T0>(arg0: &Locker<T0>) : u64 {
        arg0.start
    }

    public fun unlock<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start + arg0.duration, 1);
        let v0 = lock_status<T0>(arg0, arg1);
        assert!(v0 > 0, 2);
        arg0.unlocked = arg0.unlocked + v0;
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2);
        assert!(0x2::coin::value<T0>(&v1) == v0, 2);
        v1
    }

    public fun unlocked<T0>(arg0: &Locker<T0>) : u64 {
        arg0.unlocked
    }

    // decompiled from Move bytecode v6
}

