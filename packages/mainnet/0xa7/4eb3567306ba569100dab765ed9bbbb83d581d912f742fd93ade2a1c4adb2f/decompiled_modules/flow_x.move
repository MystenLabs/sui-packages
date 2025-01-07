module 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::flow_x {
    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T1>(arg2, arg4, arg5);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg5);
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T1>(0x2::coin::value<T1>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T1>(arg2, v2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T1>(arg2, arg4, arg5);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, arg1, arg5);
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T1>(0x2::coin::value<T1>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T1>(arg2, v2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T1, T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T1, T0>(arg2, arg4, arg5);
        let v2 = v1;
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut arg1), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, arg1, arg5);
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T1, T0>(0x2::coin::value<T0>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T1, T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T1, T0>(arg2, v2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

