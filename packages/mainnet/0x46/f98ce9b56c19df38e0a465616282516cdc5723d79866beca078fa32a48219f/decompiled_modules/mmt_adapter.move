module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::mmt_adapter {
    public fun swap_in_vault<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg3: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg11);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg4, arg5, arg6, arg8, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v8 = if (arg4) {
            v6
        } else {
            v7
        };
        if (arg5) {
            assert!(v8 <= arg6, 103);
            let v9 = if (arg4) {
                0x2::balance::value<T1>(&v4)
            } else {
                0x2::balance::value<T0>(&v5)
            };
            assert!(v9 >= arg7, 102);
        } else {
            assert!(v8 <= arg7, 101);
        };
        let (v10, v11) = if (arg4) {
            (0x2::balance::split<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg2), v8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg3), v8))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, v10, v11, arg10, arg11);
        0x2::balance::join<T0>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T0>(arg2), v5);
        0x2::balance::join<T1>(0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::borrow_balance_mut<T1>(arg3), v4);
    }

    // decompiled from Move bytecode v6
}

