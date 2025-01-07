module 0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::s {
    struct CetusCalculatedResult has copy, drop {
        data: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>,
    }

    public fun cetus_swap<T0, T1>(arg0: &0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::c::G, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<bool>, arg3: vector<bool>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) {
        0xd619df97291202ee2595dfba1d556de725a9709b3bd99dca415f623e819a911a::c::ca1(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(&arg2)) {
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, *0x1::vector::borrow<bool>(&arg2, v1), *0x1::vector::borrow<bool>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1)));
            v1 = v1 + 1;
        };
        let v2 = CetusCalculatedResult{data: v0};
        0x2::event::emit<CetusCalculatedResult>(v2);
    }

    // decompiled from Move bytecode v6
}

