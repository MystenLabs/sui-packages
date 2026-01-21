module 0xa3f338d7658d21d892fd1e9e457ce9a0803e27fc9524594d021dee08040a7c87::smt {
    fun tt(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u128, arg6: u128, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg7 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) <= arg5 || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) >= arg5;
        if (!v0) {
            return (0, 0)
        };
        let v1 = !arg7;
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v1, true, arg8, arg5, arg4, arg3, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v5);
        let v10 = if (v1) {
            v8
        } else {
            v9
        };
        let v11 = if (v1) {
            0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6)
        } else {
            0x2::balance::value<0x2::sui::SUI>(&v7)
        };
        let v12 = if (arg7) {
            (((v10 as u128) * 1000000000000 / arg6) as u64)
        } else {
            (((v10 as u128) * arg6 / 1000000000000) as u64)
        };
        assert!(v11 >= v12, 13906834487876059138);
        let (v13, v14) = if (v1) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<0x2::sui::SUI>(arg1, arg2, v8, arg9), 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg9))
        } else {
            (0x2::coin::zero<0x2::sui::SUI>(arg9), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v9, arg9))
        };
        let v15 = v14;
        let v16 = v13;
        let (v17, v18) = if (v1) {
            (0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v16, v8, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>())
        } else {
            (0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v15, v9, arg9)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v5, v17, v18, arg3, arg9);
        0x2::coin::join<0x2::sui::SUI>(&mut v16, 0x2::coin::from_balance<0x2::sui::SUI>(v7, arg9));
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v15, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6, arg9));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<0x2::sui::SUI>(arg1, arg2, v16, arg9);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v15, arg9);
        (v10, v11)
    }

    public fun ttb(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u128>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u128>, arg11: vector<u64>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg5)) {
            let v3 = *0x1::vector::borrow<u64>(&arg7, v2);
            let v4 = if (v3 > v0) {
                v0
            } else {
                v3
            };
            if (v4 < arg8) {
                break
            };
            let (v5, v6) = tt(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v2), *0x1::vector::borrow<u128>(&arg6, v2), true, v4, arg13);
            if (v5 == 0 || v6 == 0) {
                break
            };
            v0 = v0 - v5;
            v1 = v1 + v6;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg9)) {
            let v7 = *0x1::vector::borrow<u64>(&arg11, v2);
            let v8 = if (v7 > v1) {
                v1
            } else {
                v7
            };
            if (v8 < arg12) {
                break
            };
            let (v9, v10) = tt(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v2), *0x1::vector::borrow<u128>(&arg10, v2), false, v8, arg13);
            if (v9 == 0 || v10 == 0) {
                break
            };
            v1 = v1 - v9;
            v0 = v0 + v10;
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

