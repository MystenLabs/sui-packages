module 0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::s {
    struct CetusOnePoolCalculatedResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        is_exceed: bool,
        by_amount_in: bool,
        a2b: bool,
    }

    struct CetusCalculatedResult has copy, drop {
        data: vector<CetusOnePoolCalculatedResult>,
    }

    struct TurbosCalculatedResult has copy, drop {
        data: vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>,
    }

    public fun cetus_swap<T0, T1>(arg0: &0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::G, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<bool>, arg3: vector<bool>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::ca1(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::vector::empty<CetusOnePoolCalculatedResult>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(&arg2)) {
            let v2 = *0x1::vector::borrow<bool>(&arg2, v1);
            let v3 = *0x1::vector::borrow<bool>(&arg3, v1);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, v2, v3, *0x1::vector::borrow<u64>(&arg4, v1));
            let v5 = CetusOnePoolCalculatedResult{
                amount_in    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v4),
                amount_out   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4),
                is_exceed    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v4),
                by_amount_in : v3,
                a2b          : v2,
            };
            0x1::vector::push_back<CetusOnePoolCalculatedResult>(&mut v0, v5);
            v1 = v1 + 1;
        };
        let v6 = CetusCalculatedResult{data: v0};
        0x2::event::emit<CetusCalculatedResult>(v6);
    }

    public fun turbos_swap<T0, T1, T2>(arg0: &0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::G, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: vector<bool>, arg3: vector<bool>, arg4: vector<u128>, arg5: vector<u128>, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::ca1(arg0, 0x2::tx_context::sender(arg8));
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

