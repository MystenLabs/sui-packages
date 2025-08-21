module 0x22a98a80becb3da91682676a04bbdc9047a1efa97293bd9133d9989bba3b59f6::add_liquidity {
    public fun add_liquidity<T0, T1>(arg0: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg8: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::add_liquidity<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v1, v2) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::amounts<T0, T1>(&v0);
        assert!(0x2::coin::value<T0>(arg2) >= v1, 13906835011862003713);
        assert!(0x2::coin::value<T1>(arg3) >= v2, 13906835016156971009);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::repay_add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v1, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v2, arg10)), v0, arg8);
    }

    public fun add_liquidity_by_strategy<T0, T1>(arg0: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::Pool<T0, T1>, arg1: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u8, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg10: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::amounts_in_active_bin<T0, T1>(arg0);
        let (v2, v3, v4) = 0x22a98a80becb3da91682676a04bbdc9047a1efa97293bd9133d9989bba3b59f6::strategy::strategy_to_amounts(0x22a98a80becb3da91682676a04bbdc9047a1efa97293bd9133d9989bba3b59f6::strategy::new_add_liquidity_by_strategy_params(arg4, arg5, arg6, arg7, arg8), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::active_id<T0, T1>(arg0), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::bin_step<T0, T1>(arg0), v0, v1);
        let v5 = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::add_liquidity<T0, T1>(arg0, arg1, v2, v3, v4, arg9, arg10, arg11, arg12);
        let (v6, v7) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::amounts<T0, T1>(&v5);
        assert!(0x2::coin::value<T0>(arg2) >= v6, 13906834444926320641);
        assert!(0x2::coin::value<T1>(arg3) >= v7, 13906834449221287937);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::repay_add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v6, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v7, arg12)), v5, arg10);
    }

    public fun open_position<T0, T1>(arg0: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u32, arg4: u16, arg5: vector<u64>, arg6: vector<u64>, arg7: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg8: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < (arg4 as u32)) {
            0x1::vector::push_back<u32>(&mut v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v1))));
            v1 = v1 + 1;
        };
        assert!(0x1::vector::length<u64>(&arg5) == (arg4 as u64), 13906834805703704579);
        assert!(0x1::vector::length<u64>(&arg6) == (arg4 as u64), 13906834809998671875);
        let (v2, v3) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::open_position<T0, T1>(arg0, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v4 = v3;
        let (v5, v6) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::amounts<T0, T1>(&v4);
        assert!(0x2::coin::value<T0>(arg1) >= v5, 13906834861538148353);
        assert!(0x2::coin::value<T1>(arg2) >= v6, 13906834865833115649);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::repay_add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v5, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v6, arg10)), v4, arg8);
        v2
    }

    public fun open_position_by_strategy<T0, T1>(arg0: &mut 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u8, arg4: u32, arg5: u16, arg6: u64, arg7: u64, arg8: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::config::GlobalConfig, arg9: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let (v1, v2) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::amounts_in_active_bin<T0, T1>(arg0);
        let (v3, v4, v5) = 0x22a98a80becb3da91682676a04bbdc9047a1efa97293bd9133d9989bba3b59f6::strategy::strategy_to_amounts(0x22a98a80becb3da91682676a04bbdc9047a1efa97293bd9133d9989bba3b59f6::strategy::new_add_liquidity_by_strategy_params(arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg5 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))), arg6, arg7), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::active_id<T0, T1>(arg0), 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::bin_step<T0, T1>(arg0), v1, v2);
        let (v6, v7) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::open_position<T0, T1>(arg0, v3, v4, v5, arg8, arg9, arg10, arg11);
        let v8 = v7;
        let (v9, v10) = 0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::amounts<T0, T1>(&v8);
        assert!(0x2::coin::value<T0>(arg1) >= v9, 13906834672559587329);
        assert!(0x2::coin::value<T1>(arg2) >= v10, 13906834676854554625);
        0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::repay_add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v9, arg11)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v10, arg11)), v8, arg9);
        0x2::transfer::public_transfer<0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::position::Position>(v6, 0x2::tx_context::sender(arg11));
    }

    public fun validate_active_id_slippage<T0, T1>(arg0: &0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::pool::active_id<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)))) <= arg2, 13906835084876709893);
    }

    // decompiled from Move bytecode v6
}

