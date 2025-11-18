module 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg1: &mut 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::id(arg1), arg2, 0);
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::market_obligation(arg1), arg5, 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg1: &mut 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::id(arg1), v1, v2, 0);
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

