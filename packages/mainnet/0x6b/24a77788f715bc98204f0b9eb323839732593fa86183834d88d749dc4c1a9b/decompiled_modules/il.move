module 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::il {
    public fun dC<T0, T1, T2>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            dD<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            eF<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    fun dD<T0, T1, T2>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gO<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(v0, arg5));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg3, v2, v1, 0, 4295048017, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4) + 18000, arg4, arg2, arg5);
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::fG<T0>(arg0, v4, 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::zx(arg1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::eA<T1>(arg1, 0x2::coin::into_balance<T1>(v3));
    }

    fun eF<T0, T1, T2>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gO<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, 0x2::coin::from_balance<T1>(v0, arg5));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg3, v2, v1, 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4) + 18000, arg4, arg2, arg5);
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::fG<T1>(arg0, v4, 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::zx(arg1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::eA<T0>(arg1, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v6
}

