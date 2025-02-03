module 0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::linear_vesting_wallet {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        released: u64,
        duration: u64,
    }

    public fun balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Wallet<T0>) {
        let Wallet {
            id       : v0,
            balance  : v1,
            start    : _,
            released : _,
            duration : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Wallet<T0> {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1), 0);
        Wallet<T0>{
            id       : 0x2::object::new(arg4),
            balance  : 0x2::coin::into_balance<T0>(arg0),
            start    : arg2,
            released : 0,
            duration : arg3,
        }
    }

    public fun claim<T0>(arg0: &mut Wallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = vesting_status<T0>(arg0, arg1);
        arg0.released = arg0.released + v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun duration<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.duration
    }

    public fun released<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.released
    }

    public fun start<T0>(arg0: &Wallet<T0>) : u64 {
        arg0.start
    }

    public fun vesting_status<T0>(arg0: &Wallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::vesting::linear_vested_amount(arg0.start, arg0.duration, 0x2::balance::value<T0>(&arg0.balance), arg0.released, 0x2::clock::timestamp_ms(arg1)) - arg0.released
    }

    // decompiled from Move bytecode v6
}

