module 0xd8c388256baf6f9a924e057b39af9e17fd9a907dabeabcb08f755554809a9700::linear_vesting {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        claimed: u64,
        duration: u64,
    }

    public fun balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun claim<T0>(arg0: &mut Wallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = claimable<T0>(arg0, arg1);
        arg0.claimed = arg0.claimed + v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun claimable<T0>(arg0: &Wallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start) {
            return 0
        };
        if (v0 >= arg0.start + arg0.duration) {
            return 0x2::balance::value<T0>(&arg0.balance)
        };
        ((((0x2::balance::value<T0>(&arg0.balance) + arg0.claimed) as u128) * ((v0 - arg0.start) as u128) / (arg0.duration as u128)) as u64) - arg0.claimed
    }

    public fun delete_wallet<T0>(arg0: Wallet<T0>) {
        let Wallet {
            id       : v0,
            balance  : v1,
            start    : _,
            claimed  : _,
            duration : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun duration<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.duration
    }

    public fun new_wallet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Wallet<T0> {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg1), 13906834341847105537);
        Wallet<T0>{
            id       : 0x2::object::new(arg4),
            balance  : 0x2::coin::into_balance<T0>(arg0),
            start    : arg2,
            claimed  : 0,
            duration : arg3,
        }
    }

    public fun start<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.start
    }

    // decompiled from Move bytecode v7
}

