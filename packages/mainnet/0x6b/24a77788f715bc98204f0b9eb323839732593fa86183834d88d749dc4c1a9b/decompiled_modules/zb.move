module 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::zb {
    public fun dC<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            dD<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        };
    }

    public fun dD<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gO<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T0>(v0, arg6);
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::fG<T0>(arg0, v2, 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::zx(arg1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::fG<T1>(arg1, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v2, v1, 0, arg6));
    }

    public fun eF<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gO<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T1>(v0, arg6);
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::fG<T1>(arg0, v2, 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::zx(arg1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::fG<T0>(arg1, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg2, arg5, arg3, arg4, &mut v2, v1, 0, arg6));
    }

    // decompiled from Move bytecode v6
}

