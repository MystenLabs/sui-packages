module 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::verify {
    public fun bluefin<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, v0, v1);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0 - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2), arg3);
    }

    public fun cetus<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun ferra<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_in(&v0) + 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_fee_amount(&v0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun fullsail<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg4, arg1, arg2, true, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        let (v1, _, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_fees_amount(&v0);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_in(&v0) + v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun magma<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = magma_quote<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0, v1, arg3);
    }

    public fun magma_quote<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : (u64, u64) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v4 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v5 = arg2;
        let v6 = 0;
        while (v5 > 0 && v2 != v4) {
            assert!(!0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v1), 20);
            let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), arg1);
            v1 = v8;
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v7);
            let v10 = if (arg1) {
                if (v9 < v4) {
                    v4
                } else {
                    v9
                }
            } else if (v9 > v4) {
                v4
            } else {
                v9
            };
            let (v11, v12, v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v2, v10, v3, v5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            let v15 = v5 - v11;
            v5 = v15 - v14;
            v6 = v6 + v12;
            v2 = v13;
            if (v13 == v9) {
                let v16 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7);
                let v17 = if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v16) == arg1) {
                    v3 + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v16)
                } else {
                    v3 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v16)
                };
                v3 = v17;
                continue
            };
        };
        (arg2 - v5, v6)
    }

    public fun momentum<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v1, v0);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0 - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2), arg3);
    }

    public fun suidex_v3<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v1, v0);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0 - 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_specified(&v2), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v2), arg3);
    }

    public fun turbos<T0, T1, T2>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg1, arg2, (v0 as u128), true, v1, arg4, arg5, arg6);
        let v3 = 0x2::bcs::new(0x2::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v2));
        0x2::bcs::peel_u128(&mut v3);
        0x2::bcs::peel_u128(&mut v3);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, v0 - (0x2::bcs::peel_u128(&mut v3) as u64), (0x2::bcs::peel_u128(&mut v3) as u64), arg3);
    }

    // decompiled from Move bytecode v7
}

