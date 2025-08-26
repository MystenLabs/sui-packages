module 0x448291ac4b402359b969747871efca5f80db113949189a8f6626353da40798e7::add_liquidity {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg8: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::add_liquidity<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v1, v2) = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::amounts<T0, T1>(&v0);
        assert!(0x2::coin::value<T0>(arg2) >= v1, 13906834556595470337);
        assert!(0x2::coin::value<T1>(arg3) >= v2, 13906834560890437633);
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::repay_add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v1, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v2, arg10)), v0, arg8);
    }

    public fun open_position<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u32, arg4: u16, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg8: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::position::Position {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < (arg4 as u32)) {
            0x1::vector::push_back<u32>(&mut v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v1))));
            v1 = v1 + 1;
        };
        assert!(0x1::vector::length<u64>(&arg5) == (arg4 as u64), 13906834350437171203);
        assert!(0x1::vector::length<u64>(&arg6) == (arg4 as u64), 13906834354732138499);
        let (v2, v3) = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::open_position<T0, T1>(arg0, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v4 = v3;
        let (v5, v6) = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::amounts<T0, T1>(&v4);
        assert!(0x2::coin::value<T0>(arg1) >= v5, 13906834406271614977);
        assert!(0x2::coin::value<T1>(arg2) >= v6, 13906834410566582273);
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::repay_add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v5, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v6, arg10)), v4, arg8);
        v2
    }

    public fun validate_active_id_slippage<T0, T1>(arg0: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::active_id<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)))) <= arg2, 13906834629610176517);
    }

    // decompiled from Move bytecode v6
}

