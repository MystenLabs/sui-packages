module 0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::swap_scallop_lsd {
    public fun swap_a2b<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::swap_transaction::SwapTransaction<T1, T2>, arg5: &0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1);
        0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::swap_event::emit_common_swap<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::consts::LSD_SCALLOP(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::swap_transaction::SwapTransaction<T1, T2>, arg5: &0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1);
        0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::swap_event::emit_common_swap<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(0xefaa15e100435c70efd582005dbf6b0fcca10cc260ebc224dbf7cc9abaa53d85::consts::LSD_SCALLOP(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg2), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

