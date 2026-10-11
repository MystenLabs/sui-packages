module 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::flowx {
    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::split<T0>(&mut arg1, arg2);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, true, true, arg2, arg3, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let (v5, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        assert!(0x2::balance::value<T0>(&v0) == 0, 112);
        0x2::balance::destroy_zero<T0>(v0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v4, 0x2::balance::split<T0>(&mut v0, v5), 0x2::balance::zero<T1>(), arg4, arg6);
        assert!(0x2::balance::value<T0>(&arg1) == 0, 112);
        0x2::balance::destroy_zero<T0>(arg1);
        v2
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::split<T1>(&mut arg1, arg2);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, false, true, arg2, arg3, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        assert!(0x2::balance::value<T1>(&v0) == 0, 112);
        0x2::balance::destroy_zero<T1>(v0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v0, v6), arg4, arg6);
        assert!(0x2::balance::value<T1>(&arg1) == 0, 112);
        0x2::balance::destroy_zero<T1>(arg1);
        v1
    }

    // decompiled from Move bytecode v7
}

