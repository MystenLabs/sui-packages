module 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::withdraw {
    public fun withdraw<T0, T1>(arg0: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::app::ProtocolApp, arg1: &mut 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::market::Market<T0>, arg2: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::obligation::ObligationOwnerCap, arg3: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun withdraw_as_coin<T0, T1>(arg0: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::app::ProtocolApp, arg1: &mut 0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::market::Market<T0>, arg2: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::obligation::ObligationOwnerCap, arg3: &0x145327cef02a018604987715f847ec7e5cf347c052983cdf9d1e672dff348f9a::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

