module 0x6237f3c186d548158a3a6f0d7e5d6052120b66d76b59361364dc5869f1b69f19::swap {
    struct CoinType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct HopGuard<phantom T0, phantom T1> {
        hid: 0x2::object::UID,
        nextCoin: CoinType<T0>,
        nextAmount: u64,
        finalCoinType: CoinType<T1>,
    }

    public fun after_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<HopGuard<T0, T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::string::utf8(b"swap::after_swap");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0;
        0x1::vector::reverse<HopGuard<T0, T0>>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<HopGuard<T0, T0>>(&arg1)) {
            let HopGuard {
                hid           : v3,
                nextCoin      : _,
                nextAmount    : v5,
                finalCoinType : _,
            } = 0x1::vector::pop_back<HopGuard<T0, T0>>(&mut arg1);
            v1 = v1 + v5;
            0x2::object::delete(v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<HopGuard<T0, T0>>(arg1);
        arg0
    }

    public fun before_swap<T0, T1>(arg0: vector<u64>, arg1: &mut 0x2::tx_context::TxContext) : vector<HopGuard<T0, T1>> {
        let v0 = 0x1::string::utf8(b"swap::before_swap");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0x1::vector::empty<HopGuard<T0, T1>>();
        0x1::vector::reverse<u64>(&mut arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0)) {
            let v3 = CoinType<T0>{dummy_field: false};
            let v4 = CoinType<T1>{dummy_field: false};
            let v5 = HopGuard<T0, T1>{
                hid           : 0x2::object::new(arg1),
                nextCoin      : v3,
                nextAmount    : 0x1::vector::pop_back<u64>(&mut arg0),
                finalCoinType : v4,
            };
            0x1::vector::push_back<HopGuard<T0, T1>>(&mut v1, v5);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        v1
    }

    public fun cetus_swap_b2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: HopGuard<T0, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, HopGuard<T1, T2>) {
        let v0 = 0x1::string::utf8(b"swap::cetus_swap_b2a");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T1, T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        let HopGuard {
            hid           : v2,
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : v5,
        } = arg4;
        let v6 = CoinType<T1>{dummy_field: false};
        let v7 = HopGuard<T1, T2>{
            hid           : v2,
            nextCoin      : v6,
            nextAmount    : 0x2::coin::value<T1>(&v1),
            finalCoinType : v5,
        };
        (v1, v7)
    }

    public fun hop_guard_id<T0, T1>(arg0: &HopGuard<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.hid)
    }

    public fun mock_swap<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: HopGuard<T0, T2>) : (0x2::coin::Coin<T1>, HopGuard<T1, T2>) {
        let v0 = 0x1::string::utf8(b"swap::mock_swap");
        0x1::debug::print<0x1::string::String>(&v0);
        let HopGuard {
            hid           : v1,
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : v4,
        } = arg1;
        let v5 = CoinType<T1>{dummy_field: false};
        let v6 = HopGuard<T1, T2>{
            hid           : v1,
            nextCoin      : v5,
            nextAmount    : 0x2::coin::value<T1>(&arg0),
            finalCoinType : v4,
        };
        (arg0, v6)
    }

    // decompiled from Move bytecode v6
}

