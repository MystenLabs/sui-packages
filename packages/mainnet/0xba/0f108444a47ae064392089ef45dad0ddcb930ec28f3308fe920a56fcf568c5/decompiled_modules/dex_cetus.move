module 0xba0f108444a47ae064392089ef45dad0ddcb930ec28f3308fe920a56fcf568c5::dex_cetus {
    public fun get_swap_params() : (u64, u64) {
        (1000000, 4294967295)
    }

    public entry fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

