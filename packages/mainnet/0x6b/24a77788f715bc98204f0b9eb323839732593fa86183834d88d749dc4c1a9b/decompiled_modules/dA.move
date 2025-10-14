module 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dA {
    public fun dC<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6);
        if (arg4) {
            dD<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6);
        };
    }

    public fun dD<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gO<T0>(arg1);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg6);
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2, v3) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_a2b_<T0, T1>(arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg6), arg4, arg5, arg6);
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::fG<T0>(arg0, v1, 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::zx(arg1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::eA<T1>(arg1, 0x2::coin::into_balance<T1>(v2));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg6);
    }

    public fun eF<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::AC, arg2: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gO<T1>(arg1);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg6);
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2, v3) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3::swap_b2a_<T0, T1>(arg2, arg3, 0x2::coin::from_balance<T1>(v0, arg6), arg4, arg5, arg6);
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::fG<T1>(arg0, v2, 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::zx(arg1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::eA<T0>(arg1, 0x2::coin::into_balance<T0>(v1));
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB::gD<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg6);
    }

    // decompiled from Move bytecode v6
}

