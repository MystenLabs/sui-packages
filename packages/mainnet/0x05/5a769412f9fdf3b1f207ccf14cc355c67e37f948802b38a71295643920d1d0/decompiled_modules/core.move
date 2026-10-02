module 0x55a769412f9fdf3b1f207ccf14cc355c67e37f948802b38a71295643920d1d0::core {
    public fun merge<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(&mut arg0, arg1);
        arg0
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 2);
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg2);
        };
    }

    public fun settle_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 2);
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg3), arg2);
        };
    }

    public fun sweep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    // decompiled from Move bytecode v7
}

