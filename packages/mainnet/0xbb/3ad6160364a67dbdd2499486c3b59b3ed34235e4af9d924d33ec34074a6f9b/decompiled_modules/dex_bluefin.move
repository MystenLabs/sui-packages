module 0xbb3ad6160364a67dbdd2499486c3b59b3ed34235e4af9d924d33ec34074a6f9b::dex_bluefin {
    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        abort 999
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 999
    }

    // decompiled from Move bytecode v6
}

