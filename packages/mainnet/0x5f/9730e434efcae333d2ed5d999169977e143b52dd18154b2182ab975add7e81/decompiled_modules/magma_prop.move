module 0x5f9730e434efcae333d2ed5d999169977e143b52dd18154b2182ab975add7e81::magma_prop {
    fun destroy_or_transfer<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg0, 0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
        destroy_or_transfer<T0>(v0, arg3);
        0x2::coin::from_balance<T1>(v1, arg3)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg0, 0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3);
        destroy_or_transfer<T1>(v1, arg3);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

