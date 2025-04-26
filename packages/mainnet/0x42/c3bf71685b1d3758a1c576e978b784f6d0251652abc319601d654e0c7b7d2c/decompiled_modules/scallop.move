module 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::scallop {
    public fun borrow<T0, T1>(arg0: &mut 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey) {
        if (0x2::coin::value<T0>(&arg6) != 0) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg1, arg3, arg2, arg6, arg10);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg1, arg3, &arg4, arg2, arg5, arg7, arg8, arg9, arg10);
        0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::supported_defi_confirm_1l_for_1l_1nl<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0, 0x2::coin::value<T1>(&v0), 1);
        (v0, arg4)
    }

    public fun deposit<T0>(arg0: &mut 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::Take_1_Liquidity_For_1_Liquidity_Request<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg1, arg4, arg5);
        0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::supported_defi_confirm_1l_for_1l<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0));
        0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::protocol_event::emit_deposited_event(0x1::string::utf8(b"Scallop"), 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::fund_id_of_1l_for_1l_req<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg1), 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(), 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0));
        v0
    }

    public fun open_obligation_and_borrow<T0, T1>(arg0: &mut 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey) {
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg1, arg8);
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = borrow<T0, T1>(arg0, arg1, arg2, v4, v1, arg3, arg4, arg5, arg6, arg7, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg1, v3, v2);
        (v5, v6)
    }

    public fun repay<T0>(arg0: &mut 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::Take_1_Liquidity_For_Nothing_Request<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::supported_defi_confirm_1l_for_nothing<T0>(arg0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun withdraw<T0>(arg0: &mut 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::Take_1_Liquidity_For_1_Liquidity_Request<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, arg1, arg4, arg5);
        0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::supported_defi_confirm_1l_for_1l<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg0, 0x2::coin::value<T0>(&v0));
        0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::protocol_event::emit_withdrawn_event(0x1::string::utf8(b"Scallop"), 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::fund::fund_id_of_1l_for_1l_req<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg0), 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(), 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

