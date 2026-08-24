module 0x188432c11c4a3611d108d805cabfae9a5d88f99273b868531a39ef0be82255e1::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<T0>(arg0, arg3), arg5);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        let (v3, v4) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v2, v1, arg2, arg5);
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<T0>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<T0>(arg0), arg5);
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v4));
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<T1>(arg0, arg3), arg5);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        let (v3, v4) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v2, v1, arg2, arg5);
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<T1>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<T1>(arg0), arg5);
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
    }

    // decompiled from Move bytecode v7
}

