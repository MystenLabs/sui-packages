module 0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::swap_scallop_lsd {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg5: &0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::swap_transaction::SwapTransaction<T2, T3>, arg6: &0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg1, arg2, arg3, arg7);
        let v1 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1);
        0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::swap_event::emit_common_swap<T0, T1>(0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::consts::LSD_SCALLOP(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0), true);
        0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T1, T0>(arg4, v0, arg7)
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg5: &0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::swap_transaction::SwapTransaction<T2, T3>, arg6: &0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T1, T0>(arg4, arg2, arg7), arg3, arg7);
        let v1 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1);
        0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::swap_event::emit_common_swap<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(0x7065a46bcbcaa712fec55e0c20d44e106a632613a9fc37e9c117183eada4adc6::consts::LSD_SCALLOP(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T1>(&arg2), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

