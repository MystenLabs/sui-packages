module 0xb48b47b9b6a4aad5a83aacf4fc402914ab502762f9c51fd5b09bf0d0bba9d426::m72fa7fdcd14f37cd5052f305 {
    public fun f611bfb901eb825005087f148<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun fac46a30d82c89e7e5e7e4868<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

