module 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle {
    public fun destroy_zero<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun join<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun zero<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun finish<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 0);
        send<T0>(arg0, arg2);
    }

    public fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun into_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun join2<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(&mut arg0, arg1);
        arg0
    }

    public fun join3<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(&mut arg0, arg1);
        0x2::balance::join<T0>(&mut arg0, arg2);
        arg0
    }

    public fun redeem<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>) : 0x2::balance::Balance<T0> {
        0x2::balance::redeem_funds<T0>(arg0)
    }

    public fun repay_split<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 1);
        assert!(v0 - arg1 >= arg2, 2);
        (0x2::balance::split<T0>(&mut arg0, arg1), arg0)
    }

    public fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    public fun split_bps<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, (((0x2::balance::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64))
    }

    public fun split_capped<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        0x2::balance::split<T0>(arg0, v1)
    }

    // decompiled from Move bytecode v7
}

