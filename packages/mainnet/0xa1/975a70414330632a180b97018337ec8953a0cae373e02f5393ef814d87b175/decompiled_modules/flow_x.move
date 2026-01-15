module 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::flow_x {
    public entry fun swap_exact_input<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config::FeeTracker, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::DCA<T0, T1>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == 0, 1);
        assert!(arg5 == 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T1>(arg7), 2);
        let (v0, v1) = 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::init_trade<T0, T1>(arg7, arg0, arg9);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v0);
        0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::assert_max_price_via_output<T0, T1>(arg4, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input<T0, T1>(arg0, arg1, arg3, arg4, 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T1>(arg7), arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::resolve_trade<T0, T1>(arg7, arg2, v2, arg4, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_input_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config::FeeTracker, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::DCA<T0, T2>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == 0, 1);
        assert!(arg5 == 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T2>(arg7), 2);
        let (v0, v1) = 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::init_trade<T0, T2>(arg7, arg0, arg9);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v0);
        0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::assert_max_price_via_output<T0, T2>(arg4, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_doublehop<T0, T1, T2>(arg0, arg1, arg3, arg4, 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T2>(arg7), arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::resolve_trade<T0, T2>(arg7, arg2, v2, arg4, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_input_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config::FeeTracker, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::DCA<T0, T3>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == 0, 1);
        assert!(arg5 == 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T3>(arg7), 2);
        let (v0, v1) = 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::init_trade<T0, T3>(arg7, arg0, arg9);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v0);
        0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::assert_max_price_via_output<T0, T3>(arg4, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_triplehop<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T3>(arg7), arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::resolve_trade<T0, T3>(arg7, arg2, v2, arg4, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config::FeeTracker, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::DCA<T0, T1>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == 0, 1);
        assert!(arg6 == 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T1>(arg8), 2);
        let (v0, v1) = 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::init_trade<T0, T1>(arg8, arg0, arg10);
        let v2 = v1;
        let v3 = v0;
        assert!(arg4 == 0x2::balance::value<T0>(&v3), 0);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::assert_max_price_via_output<T0, T1>(arg5, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output<T0, T1>(arg0, arg1, arg3, arg4, arg5, 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T1>(arg8), arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::resolve_trade<T0, T1>(arg8, arg2, v2, arg5, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun swap_exact_output_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config::FeeTracker, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::DCA<T0, T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == 0, 1);
        assert!(arg6 == 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T2>(arg8), 2);
        let (v0, v1) = 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::init_trade<T0, T2>(arg8, arg0, arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(arg4 == v4, 0);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::assert_max_price_via_output<T0, T2>(arg5, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_doublehop<T0, T1, T2>(arg0, arg1, arg3, v4, arg5, 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T2>(arg8), arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::resolve_trade<T0, T2>(arg8, arg2, v2, arg5, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public entry fun swap_exact_output_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config::FeeTracker, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::DCA<T0, T3>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) == 0, 1);
        assert!(arg6 == 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T3>(arg8), 2);
        let (v0, v1) = 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::init_trade<T0, T3>(arg8, arg0, arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(arg4 == v4, 0);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::assert_max_price_via_output<T0, T3>(arg5, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_triplehop<T0, T1, T2, T3>(arg0, arg1, arg3, v4, arg5, 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::owner<T0, T3>(arg8), arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::dca::resolve_trade<T0, T3>(arg8, arg2, v2, arg5, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

