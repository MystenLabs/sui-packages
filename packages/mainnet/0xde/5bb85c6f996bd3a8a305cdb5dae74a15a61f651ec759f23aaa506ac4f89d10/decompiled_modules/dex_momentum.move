module 0xd207c083a803c74137d98ba7363799f30db860c7ae4c6278e21a1b95396f6710::dex_momentum {
    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg1), arg2, arg3, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::split<T0>(&mut arg1, v4), 0x2::balance::zero<T1>(), arg4, arg5);
        0xd207c083a803c74137d98ba7363799f30db860c7ae4c6278e21a1b95396f6710::sweep::to_bank<T0>(arg1, arg5);
        v1
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg1), arg2, arg3, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1, v5), arg4, arg5);
        0xd207c083a803c74137d98ba7363799f30db860c7ae4c6278e21a1b95396f6710::sweep::to_bank<T1>(arg1, arg5);
        v0
    }

    // decompiled from Move bytecode v7
}

