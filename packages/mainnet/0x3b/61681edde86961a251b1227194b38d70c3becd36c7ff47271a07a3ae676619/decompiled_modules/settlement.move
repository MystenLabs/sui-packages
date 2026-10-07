module 0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::settlement {
    public fun assert_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg3 > 0, 3);
        assert!(arg1 <= arg2, 1);
        assert!(arg0 >= arg1, 2);
        assert!(arg0 - arg1 >= arg3, 2);
    }

    public fun assert_deadline(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 4);
    }

    public fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0, arg1);
        assert_bounds(0x2::coin::value<T0>(&arg0), arg2, arg3, arg4);
        (0x2::coin::split<T0>(&mut arg0, arg2, arg5), arg0)
    }

    // decompiled from Move bytecode v7
}

