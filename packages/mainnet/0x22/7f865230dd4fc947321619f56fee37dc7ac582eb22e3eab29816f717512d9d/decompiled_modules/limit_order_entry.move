module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order_entry {
    public entry fun cancel_swap_order<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::cancel_swap_order<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg3));
        };
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun execute_swap_order<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::ExecutorCap, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::GlobalStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::execute_swap_order<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun place_swap_order_from_x_to_y<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::place_swap_order_from_x_to_y<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun place_swap_order_from_y_to_x<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order::place_swap_order_from_y_to_x<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

