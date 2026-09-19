module 0x6946bdf42efd336205aa5c9fcda5aa25ab7482db7fb540d28645837c04e0d057::settle {
    public fun join<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        take<T0>(arg0, arg1)
    }

    fun check<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg4, 120);
        let v0 = (arg1 as u128) + (arg2 as u128);
        let v1 = (0x2::balance::value<T0>(arg0) as u128);
        if (v1 < v0) {
            abort gap_code(v0 - v1)
        };
    }

    public fun finish<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        check<T0>(&arg0, arg1, arg2, arg3, arg4);
        sweep<T0>(arg0, arg6);
    }

    public fun finish_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check<T0>(&arg0, arg1, arg2, arg3, arg4);
        0x2::coin::from_balance<T0>(arg0, arg6)
    }

    public fun finish_quiet<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg4, 120);
        assert!((0x2::balance::value<T0>(&arg0) as u128) >= (arg1 as u128) + (arg2 as u128), 130);
        sweep<T0>(arg0, arg6);
    }

    public fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public(friend) fun gap_code(arg0: u128) : u64 {
        let v0 = if (arg0 > (281474976710655 as u128)) {
            281474976710655
        } else {
            (arg0 as u64)
        };
        200 + v0
    }

    public fun min_out<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 100);
    }

    public fun redeem<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>) : 0x2::balance::Balance<T0> {
        0x2::balance::redeem_funds<T0>(arg0)
    }

    public fun sweep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public(friend) fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 < arg1) {
            abort gap_code(((arg1 - v0) as u128))
        };
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

