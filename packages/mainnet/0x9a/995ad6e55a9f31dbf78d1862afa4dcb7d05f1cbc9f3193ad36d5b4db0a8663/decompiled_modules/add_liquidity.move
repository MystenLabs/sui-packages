module 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::add_liquidity {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts<T0, T1>(&v0);
        assert!(0x2::coin::value<T0>(arg2) >= v1, 13906834517940764673);
        assert!(0x2::coin::value<T1>(arg3) >= v2, 13906834522235731969);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v1, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v2, arg10)), arg8);
    }

    public fun open_position<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v2);
        assert!(0x2::coin::value<T0>(arg1) >= v4, 13906834337552138241);
        assert!(0x2::coin::value<T1>(arg2) >= v5, 13906834341847105537);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg0, &mut v3, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v4, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v5, arg9)), arg7);
        0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v3, 0x2::tx_context::sender(arg9));
    }

    public fun add_liquidity_with_limits<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u128>, arg8: u64, arg9: u64, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        validate_bounds(&arg4, &arg7);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_shares(arg1);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg10, arg11, arg12, arg13);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_cert_fees<T0, T1>(&v1);
        assert!(v2 <= arg8 && v3 <= arg9, 13906834878718410759);
        check_shares(arg1, &arg4, &v0, &arg7);
        let (v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts<T0, T1>(&v1);
        assert!(0x2::coin::value<T0>(arg2) >= v4 && 0x2::coin::value<T1>(arg3) >= v5, 13906834891602919425);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v4, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v5, arg13)), arg11);
    }

    fun check_shares(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg1: &vector<u32>, arg2: &vector<u128>, arg3: &vector<u128>) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::liquidity_shares(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg1)) {
            let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::bin_idx(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(arg1, v1)));
            let v3 = if (0x1::vector::is_empty<u128>(arg2)) {
                0
            } else {
                *0x1::vector::borrow<u128>(arg2, v2)
            };
            assert!(*0x1::vector::borrow<u128>(&v0, v2) >= v3 && *0x1::vector::borrow<u128>(&v0, v2) - v3 >= *0x1::vector::borrow<u128>(arg3, v1), 13906834694034685957);
            v1 = v1 + 1;
        };
    }

    public fun open_position_with_limits<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u128>, arg7: u64, arg8: u64, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        validate_bounds(&arg3, &arg6);
        let (v0, v1) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg0, arg3, arg4, arg5, arg9, arg10, arg11, arg12);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_fees<T0, T1>(&v2);
        assert!(v4 <= arg7 && v5 <= arg8, 13906834775639195655);
        let v6 = vector[];
        check_shares(&v3, &arg3, &v6, &arg6);
        let (v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v2);
        assert!(0x2::coin::value<T0>(arg1) >= v7 && 0x2::coin::value<T1>(arg2) >= v8, 13906834788523704321);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg0, &mut v3, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v7, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v8, arg12)), arg10);
        0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v3, 0x2::tx_context::sender(arg12));
    }

    fun validate_bounds(arg0: &vector<u32>, arg1: &vector<u128>) {
        assert!(0x1::vector::length<u32>(arg0) > 0 && 0x1::vector::length<u32>(arg0) == 0x1::vector::length<u128>(arg1), 13906834625315078147);
        let v0 = 1;
        while (v0 < 0x1::vector::length<u32>(arg0)) {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(arg0, v0 - 1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(arg0, v0))), 13906834646789914627);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

