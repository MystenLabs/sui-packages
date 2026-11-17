module 0x80fd09efdec56a089550aabfbd3ea083d78f24667a7ed86e98a85ae1c3486805::coin {
    public fun split_coin(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg1 > arg0, 0);
        let v0 = arg1 - arg0;
        assert!(v0 <= arg2, 1);
        (v0, 0x2::coin::split<0x2::sui::SUI>(arg4, v0 * arg3, arg5))
    }

    // decompiled from Move bytecode v7
}

