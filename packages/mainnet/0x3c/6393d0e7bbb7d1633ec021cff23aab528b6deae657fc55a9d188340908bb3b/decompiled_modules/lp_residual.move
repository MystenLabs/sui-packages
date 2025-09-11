module 0x3c6393d0e7bbb7d1633ec021cff23aab528b6deae657fc55a9d188340908bb3b::lp_residual {
    public fun lp_residual<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x3c6393d0e7bbb7d1633ec021cff23aab528b6deae657fc55a9d188340908bb3b::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x3c6393d0e7bbb7d1633ec021cff23aab528b6deae657fc55a9d188340908bb3b::version::Version, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x3c6393d0e7bbb7d1633ec021cff23aab528b6deae657fc55a9d188340908bb3b::utils::lp_residual_amount<T0, T1, T2, T3>(arg0, arg1, arg4, true, 0, arg2, arg3, arg5);
        let (_, _) = 0x3c6393d0e7bbb7d1633ec021cff23aab528b6deae657fc55a9d188340908bb3b::utils::lp_residual_amount<T0, T1, T2, T3>(arg0, arg1, arg4, false, 0, arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

