module 0x5ac179bc1c4cbb3751a55774123089b17cf6af65104e03fba8f6ef90d8069e56::m5ef07f83c81ff3a353731164 {
    public fun f0305a2ea1219146e777eb115<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun fd4489600e54f25387ddd0fb8<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

