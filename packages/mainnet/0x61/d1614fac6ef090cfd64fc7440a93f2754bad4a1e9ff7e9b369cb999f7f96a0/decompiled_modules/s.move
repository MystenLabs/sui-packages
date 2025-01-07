module 0x61d1614fac6ef090cfd64fc7440a93f2754bad4a1e9ff7e9b369cb999f7f96a0::s {
    struct CetusCalculatedResult has copy, drop {
        data: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>,
    }

    struct TurbosCalculatedResult has copy, drop {
        data: vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>,
    }

    public fun cetus_swap<T0, T1>(arg0: &0x61d1614fac6ef090cfd64fc7440a93f2754bad4a1e9ff7e9b369cb999f7f96a0::c::G, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<bool>, arg3: vector<bool>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        0x61d1614fac6ef090cfd64fc7440a93f2754bad4a1e9ff7e9b369cb999f7f96a0::c::ca1(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(&arg2)) {
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, *0x1::vector::borrow<bool>(&arg2, v1), *0x1::vector::borrow<bool>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1)));
            v1 = v1 + 1;
        };
        let v2 = CetusCalculatedResult{data: v0};
        0x2::event::emit<CetusCalculatedResult>(v2);
    }

    public fun turbos_swap<T0, T1, T2>(arg0: &0x61d1614fac6ef090cfd64fc7440a93f2754bad4a1e9ff7e9b369cb999f7f96a0::c::G, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: vector<bool>, arg3: vector<bool>, arg4: vector<u128>, arg5: vector<u128>, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0x61d1614fac6ef090cfd64fc7440a93f2754bad4a1e9ff7e9b369cb999f7f96a0::c::ca1(arg0, 0x2::tx_context::sender(arg8));
        let v0 = 0x1::vector::empty<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(&arg2)) {
            0x1::vector::push_back<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&mut v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg1, *0x1::vector::borrow<bool>(&arg2, v1), *0x1::vector::borrow<u128>(&arg4, v1), *0x1::vector::borrow<bool>(&arg3, v1), *0x1::vector::borrow<u128>(&arg5, v1), arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        let v2 = TurbosCalculatedResult{data: v0};
        0x2::event::emit<TurbosCalculatedResult>(v2);
    }

    // decompiled from Move bytecode v6
}

