module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_route_quotes {
    public fun bluefin<T0, T1>(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::Session, arg1: u8, arg2: u8, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg3, arg4, true, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::quote_in(arg0, arg2), sqrt_limit(arg4));
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::record_quote(arg0, arg1, arg2, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::quote_decode::bluefin_amount_out(&v0));
    }

    public fun cetus<T0, T1>(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::Session, arg1: u8, arg2: u8, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, arg4, true, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::quote_in(arg0, arg2));
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::record_quote(arg0, arg1, arg2, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::quote_decode::cetus_amount_out(&v0));
    }

    public fun magma<T0, T1>(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::Session, arg1: u8, arg2: u8, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: bool) {
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::record_quote(arg0, arg1, arg2, magma_exact_in<T0, T1>(arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::quote_in(arg0, arg2)));
    }

    public fun magma_exact_in<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0 || 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg0)) {
            return 0
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v3 = 0;
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        while (arg2 > 0) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v4)) {
                return 0
            };
            let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v4), arg1);
            v4 = v6;
            let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v5);
            let (v8, v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v1, v7, v2, arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            if (v8 != 0 || v11 != 0) {
                let v12 = arg2 - v8;
                arg2 = v12 - v11;
                v3 = v3 + v9;
            };
            if (v10 == v7) {
                v1 = v7;
                let v13 = if (arg1) {
                    0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v5))
                } else {
                    0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v5)
                };
                let v14 = if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v13)) {
                    v2 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v13)
                } else {
                    v2 + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v13)
                };
                v2 = v14;
                continue
            };
            v1 = v10;
        };
        v3
    }

    public fun momentum<T0, T1>(arg0: &mut 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::Session, arg1: u8, arg2: u8, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: bool) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg3, arg4, true, sqrt_limit(arg4), 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::quote_in(arg0, arg2));
        0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session::record_quote(arg0, arg1, arg2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0));
    }

    fun sqrt_limit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    // decompiled from Move bytecode v7
}

