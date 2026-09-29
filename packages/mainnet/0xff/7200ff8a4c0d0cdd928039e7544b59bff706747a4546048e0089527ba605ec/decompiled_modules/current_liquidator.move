module 0xff7200ff8a4c0d0cdd928039e7544b59bff706747a4546048e0089527ba605ec::current_liquidator {
    public entry fun flr_generic<T0, T1, T2>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, 0x2::sui::SUI>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T1>(arg2, true, false, arg7, 4295048017, arg10, arg1, arg11);
        let v3 = v2;
        let (v4, v5) = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::liquidate::liquidate_as_coin<T0, T1, T2>(arg4, arg0, arg6, arg5, 0x2::coin::from_balance<T1>(v1, arg11), arg8, arg9, arg10, arg11);
        let v6 = v5;
        let (v7, v8) = sbm_a_b<T2, 0x2::sui::SUI>(arg1, arg3, 0x2::coin::into_balance<T2>(v4), arg10, arg11);
        let v9 = v8;
        if (0x2::coin::value<T1>(&v6) == 0) {
            0x2::coin::destroy_zero<T1>(v6);
        } else {
            let (v10, v11) = sbm_b_a<0x2::sui::SUI, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v6), arg10, arg11);
            0x2::balance::join<0x2::sui::SUI>(&mut v9, v11);
            tb<T1>(v10, arg11);
        };
        tb<T2>(v7, arg11);
        let (v12, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v9) > v12, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T1>(arg2, v3, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v12), 0x2::balance::zero<T1>(), arg1, arg11);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        tb<0x2::sui::SUI>(v9, arg11);
    }

    public entry fun flr_sui_collateral<T0, T1>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T1>(arg2, true, false, arg6, 4295048017, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::liquidate::liquidate_as_coin<T0, T1, 0x2::sui::SUI>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v1, arg10), arg7, arg8, arg9, arg10);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(v4);
        if (0x2::coin::value<T1>(&v6) == 0) {
            0x2::coin::destroy_zero<T1>(v6);
        } else {
            let (v8, v9) = sbm_b_a<0x2::sui::SUI, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v6), arg9, arg10);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v9);
            tb<T1>(v8, arg10);
        };
        let (v10, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v10, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T1>(arg2, v3, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v10), 0x2::balance::zero<T1>(), arg1, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        tb<0x2::sui::SUI>(v7, arg10);
    }

    public entry fun flr_sui_debt<T0, T1>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, 0x2::sui::SUI>(arg2, true, false, arg6, 4295048017, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::liquidate::liquidate_as_coin<T0, 0x2::sui::SUI, T1>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg10), arg7, arg8, arg9, arg10);
        let v6 = v4;
        let (v7, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::coin::value<T1>(&v6) >= v7, 20);
        let v9 = 0x2::coin::into_balance<T1>(v6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, 0x2::sui::SUI>(arg2, v3, 0x2::balance::split<T1>(&mut v9, v7), 0x2::balance::zero<0x2::sui::SUI>(), arg1, arg10);
        0x2::balance::destroy_zero<T1>(v0);
        tb<T1>(v9, arg10);
        tb<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(v5), arg10);
    }

    public entry fun plain_liquidate<T0, T1, T2>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T1>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::liquidate::liquidate_as_coin<T0, T1, T2>(arg1, arg0, arg3, arg2, arg4, arg5, arg6, arg7, arg8);
        tb<T1>(0x2::coin::into_balance<T1>(v1), arg8);
        tb<T2>(0x2::coin::into_balance<T2>(v0), arg8);
    }

    fun sbm_a_b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg3, arg0, arg4);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), arg0, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (arg2, v1)
    }

    fun sbm_b_a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579055, arg3, arg0, arg4);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T1>(&arg2) >= v5, 31);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), arg0, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (arg2, v0)
    }

    fun tb<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun v() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

