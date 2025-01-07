module 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::flow_x {
    public entry fun swap_exact_input<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T1>(arg6, arg0, arg8);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v0);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T1>(arg3, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input<T0, T1>(arg0, arg1, arg2, arg3, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T1>(arg6), arg5, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T1>(arg6, v2, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T1>(arg2, arg4, arg5);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg5);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T1>(0x2::coin::value<T1>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T1>(arg2, v2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun swap_exact_input_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T2>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T2>(arg6, arg0, arg8);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v0);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T2>(arg3, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_doublehop<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T2>(arg6), arg5, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T2>(arg6, v2, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun swap_exact_input_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T3>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T3>(arg6, arg0, arg8);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v0);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T3>(arg3, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_triplehop<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T3>(arg6), arg5, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T3>(arg6, v2, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun swap_exact_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T1>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T1>(arg7, arg0, arg9);
        let v2 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v2);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price<T0, T1>(arg3, arg4, arg7);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output<T0, T1>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v2), arg4, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T1>(arg7), arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T1>(arg7, v1, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_output_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T2>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T2>(arg7, arg0, arg9);
        let v2 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v2);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price<T0, T2>(arg3, arg4, arg7);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_doublehop<T0, T1, T2>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v2), arg4, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T2>(arg7), arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T2>(arg7, v1, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun swap_exact_output_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T3>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T3>(arg7, arg0, arg9);
        let v2 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v2);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price<T0, T3>(arg3, arg4, arg7);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_triplehop<T0, T1, T2, T3>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v2), arg4, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T3>(arg7), arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T3>(arg7, v1, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T1>(arg2, arg4, arg5);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, arg1, arg5);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T1>(0x2::coin::value<T1>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T1>(arg2, v2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T1, T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg1) == 0, 0);
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T1, T0>(arg2, arg4, arg5);
        let v2 = v1;
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut arg1), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, arg1, arg5);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T1, T0>(0x2::coin::value<T0>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T1, T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T1, T0>(arg2, v2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

