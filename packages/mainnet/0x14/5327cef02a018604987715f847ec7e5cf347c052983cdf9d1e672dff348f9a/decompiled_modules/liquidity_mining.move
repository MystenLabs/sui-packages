module 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::liquidity_mining {
    public fun claim_reward<T0, T1, T2>(arg0: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::app::ProtocolApp, arg1: &mut 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::market::Market<T0>, arg2: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::obligation::ObligationOwnerCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_reward_as_coin<T0, T1, T2>(arg0: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::app::ProtocolApp, arg1: &mut 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::market::Market<T0>, arg2: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::obligation::ObligationOwnerCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

