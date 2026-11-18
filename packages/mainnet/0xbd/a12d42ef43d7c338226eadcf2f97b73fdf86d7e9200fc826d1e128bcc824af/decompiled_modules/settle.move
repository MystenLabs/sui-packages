module 0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::settle {
    public fun split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 1001);
        if (v0 > 0) {
            0x2::balance::send_funds<T0>(arg0, arg2);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun merge<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(&mut arg0, arg1);
        arg0
    }

    public fun settle_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 1001);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg3), arg2);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun sweep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

