module 0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::mm {
    public fun sab<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg1), 4295048017, arg3, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::split<T0>(&mut v6, v4), 0x2::balance::zero<T1>(), arg4, arg5);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<T0>(0x2::coin::from_balance<T0>(v6, arg5), 0x2::tx_context::sender(arg5));
        let v7 = 0x2::coin::from_balance<T1>(v1, arg5);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::check_min<T1>(&v7, arg2);
        v7
    }

    public fun sba<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg1), 79226673515401279992447579050, arg3, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v6 = 0x2::coin::into_balance<T1>(arg1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v6, v5), arg4, arg5);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<T1>(0x2::coin::from_balance<T1>(v6, arg5), 0x2::tx_context::sender(arg5));
        let v7 = 0x2::coin::from_balance<T0>(v0, arg5);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::check_min<T0>(&v7, arg2);
        v7
    }

    // decompiled from Move bytecode v7
}

