module 0x1f0891a785a4030a9bf562f08bbc7dee531bd543483bab58700ee6005da5989f::rescue {
    public fun rescue<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T0, T1>, arg2: 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::unstake<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

