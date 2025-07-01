module 0x857bb7e11e17e5237ebf02016f8b455d65512132585f885090f9a3c7d78870e3::SwapChain {
    public fun swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        0x2::coin::zero<T1>(arg1)
    }

    public fun swap_chain_three<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = swap<T0, T1>(arg0, arg1);
        let v1 = swap<T1, T2>(v0, arg1);
        swap<T2, T3>(v1, arg1)
    }

    public fun swap_chain_two<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = swap<T0, T1>(arg0, arg1);
        swap<T1, T2>(v0, arg1)
    }

    // decompiled from Move bytecode v6
}

