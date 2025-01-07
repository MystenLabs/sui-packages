module 0x6a77c6c18aca515e6a19f9a3fcef6d8e56e7c4fb24a87acb464400e53b7ca507::artfivesting {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        released: u64,
        duration: u64,
        claim_interval: u64,
        last_claimed: u64,
    }

    public fun balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Wallet<T0>) {
        let Wallet {
            id             : v0,
            balance        : v1,
            start          : _,
            released       : _,
            duration       : _,
            claim_interval : _,
            last_claimed   : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Wallet<T0> {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1), 0);
        Wallet<T0>{
            id             : 0x2::object::new(arg5),
            balance        : 0x2::coin::into_balance<T0>(arg0),
            start          : arg2,
            released       : 0,
            duration       : arg3,
            claim_interval : arg4,
            last_claimed   : arg2,
        }
    }

    public fun claim<T0>(arg0: &mut Wallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_claimed + arg0.claim_interval, 0);
        let v1 = vesting_status<T0>(arg0, arg1);
        arg0.released = arg0.released + v1;
        arg0.last_claimed = v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2)
    }

    public fun claim_interval<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.claim_interval
    }

    public fun duration<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.duration
    }

    entry fun entry_claim<T0>(arg0: &mut Wallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    entry fun entry_destroy_zero<T0>(arg0: Wallet<T0>) {
        destroy_zero<T0>(arg0);
    }

    entry fun entry_new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Wallet<T0>>(new<T0>(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public fun last_claimed<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.last_claimed
    }

    fun linear_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        linear_vesting_schedule(arg0, arg1, arg2 + arg3, arg4)
    }

    fun linear_vesting_schedule(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 > 0, 2);
        if (arg3 <= arg0) {
            return 0
        };
        if (arg3 >= arg0 + arg1) {
            return arg2
        };
        (((arg2 as u128) * ((arg3 - arg0) as u128) / (arg1 as u128)) as u64)
    }

    public fun released<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.released
    }

    public fun start<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.start
    }

    public fun vesting_status<T0>(arg0: &Wallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        linear_vested_amount(arg0.start, arg0.duration, 0x2::balance::value<T0>(&arg0.balance), arg0.released, 0x2::clock::timestamp_ms(arg1)) - arg0.released
    }

    // decompiled from Move bytecode v6
}

