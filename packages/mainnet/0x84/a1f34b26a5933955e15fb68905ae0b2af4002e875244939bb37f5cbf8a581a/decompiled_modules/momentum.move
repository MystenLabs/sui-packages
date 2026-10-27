module 0x84a1f34b26a5933955e15fb68905ae0b2af4002e875244939bb37f5cbf8a581a::momentum {
    public fun flash_x2y<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T0>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), true, 0);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T0>(arg0), limit<T0, T1>(arg1, true), arg3, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v2)
    }

    public fun flash_y2x<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T1>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), false, 0);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T1>(arg0), limit<T0, T1>(arg1, false), arg3, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, v2)
    }

    fun limit<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool) : u128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        if (arg1) {
            0x1::u128::max(v0 - v0 / 9, 4295048016)
        } else {
            0x1::u128::min(v0 + v0 / 8, 79226673515401279992447579055)
        }
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = vector[];
        let v1 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T2>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v1);
            let v4 = if (v3 == 0) {
                0
            } else {
                let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, limit<T0, T1>(arg1, arg2), v3);
                if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v5) != 0) {
                    0
                } else {
                    0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v5)
                }
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        let v6 = &v0;
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(v6)) {
            0x1::vector::push_back<u64>(&mut v7, 0);
            v8 = v8 + 1;
        };
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_quote<T2>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), arg2, v0, v7);
    }

    fun refund<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun repay_x2y<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        let (v0, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, arg2, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T0>(arg0, v0), 0x2::balance::zero<T1>(), arg3, arg4);
    }

    public fun repay_y2x<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        let (_, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T1>(arg0, v1), arg3, arg4);
    }

    public fun swap_x2y<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), true, 0);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), limit<T0, T1>(arg1, true), arg4, arg3, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), arg3, arg5);
        refund<T0>(arg2, arg5);
        v1
    }

    public fun swap_y2x<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), false, 0);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), limit<T0, T1>(arg1, false), arg4, arg3, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), arg3, arg5);
        refund<T1>(arg2, arg5);
        v0
    }

    // decompiled from Move bytecode v7
}

