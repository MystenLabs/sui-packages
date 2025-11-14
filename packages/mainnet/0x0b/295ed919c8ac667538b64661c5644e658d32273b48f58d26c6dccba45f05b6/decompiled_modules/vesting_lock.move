module 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::vesting_lock {
    struct VestingLock<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        start_time: u64,
        duration: u64,
        released_amount: u64,
    }

    public entry fun destroy_empty<T0>(arg0: VestingLock<T0>) {
        let VestingLock {
            id              : v0,
            vault           : v1,
            start_time      : _,
            duration        : _,
            released_amount : _,
        } = arg0;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) == 0, 1);
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v5);
    }

    public fun split<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : VestingLock<T0> {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.start_time, 4);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg2, 5);
        VestingLock<T0>{
            id              : 0x2::object::new(arg3),
            vault           : 0x2::balance::split<T0>(&mut arg0.vault, arg2),
            start_time      : arg0.start_time,
            duration        : arg0.duration,
            released_amount : arg0.released_amount,
        }
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : VestingLock<T0> {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1), 2);
        assert!(arg3 > 0, 3);
        VestingLock<T0>{
            id              : 0x2::object::new(arg4),
            vault           : arg0,
            start_time      : arg2,
            duration        : arg3,
            released_amount : 0,
        }
    }

    public fun compute_vested_amount<T0>(arg0: &VestingLock<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.start_time) {
            0
        } else if (arg1 > arg0.start_time + arg0.duration) {
            0x2::balance::value<T0>(&arg0.vault) + arg0.released_amount
        } else {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(0x2::balance::value<T0>(&arg0.vault) + arg0.released_amount, arg1 - arg0.start_time, arg0.duration)
        }
    }

    public entry fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VestingLock<T0>>(new<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2, arg3, arg5), arg4);
    }

    public fun duration<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.duration
    }

    public fun releasable_amount<T0>(arg0: &VestingLock<T0>, arg1: &0x2::clock::Clock) : u64 {
        compute_vested_amount<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) - released_amount<T0>(arg0)
    }

    public fun release<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = releasable_amount<T0>(arg0, arg1);
        assert!(v0 > 0, 0);
        arg0.released_amount = arg0.released_amount + v0;
        0x2::balance::split<T0>(&mut arg0.vault, v0)
    }

    public entry fun release_to<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(release<T0>(arg0, arg1), arg3), arg2);
    }

    public fun released_amount<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.released_amount
    }

    public entry fun split_to<T0>(arg0: &mut VestingLock<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VestingLock<T0>>(split<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun start_time<T0>(arg0: &VestingLock<T0>) : u64 {
        arg0.start_time
    }

    // decompiled from Move bytecode v6
}

