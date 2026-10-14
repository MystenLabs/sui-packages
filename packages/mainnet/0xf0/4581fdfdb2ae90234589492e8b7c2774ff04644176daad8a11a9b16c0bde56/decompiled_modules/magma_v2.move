module 0xf04581fdfdb2ae90234589492e8b7c2774ff04644176daad8a11a9b16c0bde56::magma_v2 {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, 0x2::balance::value<T0>(&arg1), arg1, arg2, arg3);
        let v2 = v0;
        assert!(0x2::balance::value<T0>(&v2) == 0, 1);
        0x2::balance::destroy_zero<T0>(v2);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, 0x2::balance::value<T1>(&arg1), arg1, arg2, arg3);
        let v2 = v1;
        assert!(0x2::balance::value<T1>(&v2) == 0, 1);
        0x2::balance::destroy_zero<T1>(v2);
        v0
    }

    // decompiled from Move bytecode v7
}

