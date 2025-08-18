module 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::lp_residual {
    public fun lp_residual<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::version::Version, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::utils::lp_residual_amount<T0, T1, T2, T3>(arg0, arg1, arg4, true, 0, arg2, arg3, arg5);
        let (_, _) = 0x66700d9baba5fc63f641123845f9a843a43ab8bb322ca3ca1f5dfd91e9cde828::utils::lp_residual_amount<T0, T1, T2, T3>(arg0, arg1, arg4, false, 0, arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

