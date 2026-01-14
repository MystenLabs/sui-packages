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

    // decompiled from Move bytecode v6
}

