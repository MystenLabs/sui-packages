module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::momentum {
    fun eval<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: u64, arg3: bool) {
        let v0 = if (arg3) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let v1 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::hop_inputs<T0>(arg0, arg2);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3);
            let v5 = if (v4 == 0) {
                0
            } else {
                let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, T2>(arg1, arg3, true, v0, v4);
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v6) < v4) {
                    0
                } else {
                    0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v6)
                }
            };
            0x1::vector::push_back<u64>(&mut v2, v5);
            v3 = v3 + 1;
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::record_hop<T0>(arg0, arg2, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg1), v2);
    }

    public fun eval_a2b<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: u64) {
        eval<T0, T1, T2>(arg0, arg1, arg2, true);
    }

    public fun eval_b2a<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: u64) {
        eval<T0, T1, T2>(arg0, arg1, arg2, false);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg3)) {
            0x2::balance::destroy_zero<T1>(arg4);
            return 0x2::balance::zero<T2>()
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg1));
        let v0 = 0x2::balance::value<T1>(&arg4);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg1, true, true, v0, 4295048016 + 1, arg5, arg2, arg6);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v5 == v0, 1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg1, v4, arg4, 0x2::balance::zero<T2>(), arg2, arg6);
        v2
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg3)) {
            0x2::balance::destroy_zero<T2>(arg4);
            return 0x2::balance::zero<T1>()
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg1));
        let v0 = 0x2::balance::value<T2>(&arg4);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg1, false, true, v0, 79226673515401279992447579055 - 1, arg5, arg2, arg6);
        let v4 = v3;
        0x2::balance::destroy_zero<T2>(v2);
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg1, v4, 0x2::balance::zero<T1>(), arg4, arg2, arg6);
        v1
    }

    // decompiled from Move bytecode v7
}

