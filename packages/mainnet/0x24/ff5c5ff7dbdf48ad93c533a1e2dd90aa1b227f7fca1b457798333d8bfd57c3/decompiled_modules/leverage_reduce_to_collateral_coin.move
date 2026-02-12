module 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg1: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::ensure_same_market<T0>(arg1);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::id(arg1), arg2, 0, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::market_obligation(arg1), arg5, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg1: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::ensure_same_market<T0>(arg1);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::id(arg1), v1, 0, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

