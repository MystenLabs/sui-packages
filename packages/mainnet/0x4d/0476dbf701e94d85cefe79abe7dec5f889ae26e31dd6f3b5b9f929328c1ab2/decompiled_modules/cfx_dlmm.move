module 0x4d0476dbf701e94d85cefe79abe7dec5f889ae26e31dd6f3b5b9f929328c1ab2::cfx_dlmm {
    struct BSE has copy, drop {
        bs: u64,
        ss: u64,
        bi: u64,
        bo: u64,
        si: u64,
        so: u64,
    }

    struct EE has copy, drop {
        EE: u64,
    }

    public fun bt<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg7), 4);
        assert!(0x1::vector::length<u128>(&arg6) == 0x1::vector::length<u64>(&arg8), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg11), 4);
        assert!(0x1::vector::length<u128>(&arg10) == 0x1::vector::length<u64>(&arg12), 4);
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v1 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u128>(&arg6)) {
            let v9 = *0x1::vector::borrow<u64>(&arg7, v8);
            let v10 = if (v9 > v0) {
                v0
            } else {
                v9
            };
            if (v10 < arg9) {
                break
            };
            let (v11, v12) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<u128>(&arg6, v8), true, arg9, v10, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v8), arg16);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v2 = v2 + 1;
            v4 = v4 + v11;
            v5 = v5 + v12;
            v0 = v0 - v11;
            v1 = v1 + v12;
            v8 = v8 + 1;
        };
        v8 = 0;
        while (v8 < 0x1::vector::length<u128>(&arg10)) {
            let v13 = *0x1::vector::borrow<u64>(&arg11, v8);
            let v14 = if (v13 > v1) {
                v1
            } else {
                v13
            };
            if (v14 < arg13) {
                break
            };
            let (v15, v16) = sw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, *0x1::vector::borrow<u128>(&arg10, v8), false, arg13, v14, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v8), arg16);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v3 = v3 + 1;
            v6 = v6 + v15;
            v7 = v7 + v16;
            v1 = v1 - v15;
            v0 = v0 + v16;
            v8 = v8 + 1;
        };
        if (v2 > 0 || v3 > 0) {
            let v17 = BSE{
                bs : v2,
                ss : v3,
                bi : v4,
                bo : v5,
                si : v6,
                so : v7,
            };
            0x2::event::emit<BSE>(v17);
        } else {
            let v18 = EE{EE: 999};
            0x2::event::emit<EE>(v18);
        };
    }

    fun imo(arg0: u64, arg1: u128, arg2: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            (arg0 as u128) * 1000000000000 / arg1
        } else {
            (arg0 as u128) * arg1 / 1000000000000
        };
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    fun pk(arg0: u128, arg1: u128, arg2: bool) : bool {
        let v0 = tq(arg1);
        arg2 && arg0 >= v0 || !arg2 && arg0 <= v0
    }

    fun pk_guard1<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: u128, arg2: bool) : bool {
        arg2 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(spot_ab_x12<T0, T1>(arg0), r1_x12<T0, T1>(arg0)) <= 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg1, 1000000000000) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(spot_ab_x12<T0, T1>(arg0), 1000000000000) >= 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg1, r1_x12<T0, T1>(arg0))
    }

    fun r1_x12<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : u128 {
        1000000000000 + 1000000000000 * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0) as u128) / 10000
    }

    fun spot_ab_x12<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : u128 {
        spot_ab_x12_from_q64(sq<T0, T1>(arg0))
    }

    fun spot_ab_x12_from_q64(arg0: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(18446744073709551616, 1000000000000, arg0)
    }

    fun spq(arg0: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil(18446744073709551616, 1000000000000, arg0)
    }

    fun sq<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : u128 {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0))
    }

    fun sw<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg8 > 0, 1);
        assert!(arg8 <= arg9, 2);
        assert!(arg12 > 0 && arg12 <= arg9, 3);
        if (!pk(sq<T0, T1>(arg0), arg6, arg7)) {
            return (0, 0)
        };
        if (!pk_guard1<T0, T1>(arg0, arg6, arg7)) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        loop {
            let v2 = arg9 - v0;
            if (v2 < arg8) {
                break
            };
            if (!pk(sq<T0, T1>(arg0), arg6, arg7)) {
                break
            };
            if (!pk_guard1<T0, T1>(arg0, arg6, arg7)) {
                break
            };
            let v3 = if (v2 > arg12) {
                arg12
            } else {
                v2
            };
            let (v4, v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, arg7, true, v3, arg3, arg4, arg5, arg13);
            let v7 = v6;
            let v8 = v5;
            let v9 = v4;
            let v10 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v7);
            if (v10 == 0) {
                let v11 = 0x2::coin::from_balance<T0>(v9, arg13);
                if (0x2::coin::value<T0>(&v11) > 0) {
                    0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v11);
                } else {
                    0x2::coin::destroy_zero<T0>(v11);
                };
                let v12 = 0x2::coin::from_balance<T1>(v8, arg13);
                if (0x2::coin::value<T1>(&v12) > 0) {
                    0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v12);
                } else {
                    0x2::coin::destroy_zero<T1>(v12);
                };
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), v7, arg4);
                break
            };
            assert!(v10 <= v2, 5);
            let v13 = if (arg7) {
                0x2::balance::value<T1>(&v8)
            } else {
                0x2::balance::value<T0>(&v9)
            };
            assert!(v13 >= imo(v10, arg6, arg7), 6);
            let (v14, v15) = if (arg7) {
                (0x2::coin::into_balance<T0>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg1, v10, arg13)), 0x2::balance::zero<T1>())
            } else {
                (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg2, v10, arg13)))
            };
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, v14, v15, v7, arg4);
            let v16 = 0x2::coin::from_balance<T0>(v9, arg13);
            if (0x2::coin::value<T0>(&v16) > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v16);
            } else {
                0x2::coin::destroy_zero<T0>(v16);
            };
            let v17 = 0x2::coin::from_balance<T1>(v8, arg13);
            if (0x2::coin::value<T1>(&v17) > 0) {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v17);
            } else {
                0x2::coin::destroy_zero<T1>(v17);
            };
            v0 = v0 + v10;
            v1 = v1 + v13;
            if (v10 < v3) {
                break
            };
        };
        (v0, v1)
    }

    fun tq(arg0: u128) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil(18446744073709551616, 1000000000000, arg0)
    }

    // decompiled from Move bytecode v6
}

