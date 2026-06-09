module 0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::repay {
    public fun repay<T0, T1>(arg0: &0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::app::ProtocolApp, arg1: &0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::obligation::ObligationOwnerCap, arg2: &mut 0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun repay_coin_refund<T0, T1>(arg0: &0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::app::ProtocolApp, arg1: &0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::obligation::ObligationOwnerCap, arg2: &mut 0xfaffbfdc0f55d0c6533dd626f8544a7dad9745a16f557540b85f0fc2a8d201aa::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

