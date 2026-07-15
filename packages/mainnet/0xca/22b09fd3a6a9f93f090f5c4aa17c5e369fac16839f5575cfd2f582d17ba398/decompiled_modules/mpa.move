module 0xca22b09fd3a6a9f93f090f5c4aa17c5e369fac16839f5575cfd2f582d17ba398::mpa {
    public fun sxy<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, 0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
        0xca22b09fd3a6a9f93f090f5c4aa17c5e369fac16839f5575cfd2f582d17ba398::u::tod<T0>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T1>(v1, arg3)
    }

    public fun syx<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, 0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3);
        0xca22b09fd3a6a9f93f090f5c4aa17c5e369fac16839f5575cfd2f582d17ba398::u::tod<T1>(0x2::coin::from_balance<T1>(v1, arg3), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

