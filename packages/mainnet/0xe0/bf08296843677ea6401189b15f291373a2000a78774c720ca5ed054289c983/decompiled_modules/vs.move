module 0xe0bf08296843677ea6401189b15f291373a2000a78774c720ca5ed054289c983::vs {
    public fun qo<T0, T1>(arg0: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (arg1) {
            let (v1, _) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::quote_x_2_y<T0, T1>(arg0, arg2);
            v1
        } else {
            let (v3, _) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::quote_y_2_x<T0, T1>(arg0, arg2);
            v3
        }
    }

    public fun qs<T0, T1>(arg0: &mut 0xe0bf08296843677ea6401189b15f291373a2000a78774c720ca5ed054289c983::p::P, arg1: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: bool) {
        0xe0bf08296843677ea6401189b15f291373a2000a78774c720ca5ed054289c983::p::fd(arg0, qo<T0, T1>(arg1, arg2, 0xe0bf08296843677ea6401189b15f291373a2000a78774c720ca5ed054289c983::p::cy(arg0)));
    }

    public fun sa<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, 0, arg1, arg2, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun sb<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, 0, arg1, arg2, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

