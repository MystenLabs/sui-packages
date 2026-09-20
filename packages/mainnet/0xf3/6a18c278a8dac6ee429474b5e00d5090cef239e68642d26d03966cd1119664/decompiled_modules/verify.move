module 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::verify {
    public fun bluefin<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, v0, v1);
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, v0 - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2), arg3);
    }

    public fun cetus<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0));
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun ferra<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0));
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_in(&v0) + 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_fee_amount(&v0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun fullsail<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg4, arg1, arg2, true, 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0));
        let (v1, _, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_fees_amount(&v0);
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_in(&v0) + v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun magma<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg4, arg1, arg2, true, 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0));
        let (v1, _, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_fees_amount(&v0);
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_in(&v0) + v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun momentum<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v1, v0);
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, v0 - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2), arg3);
    }

    public fun suidex_v3<T0, T1>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v1, v0);
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, v0 - 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_specified(&v2), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v2), arg3);
    }

    public fun turbos<T0, T1, T2>(arg0: &mut 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::Probe, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::checking(arg0)) {
            return
        };
        let v0 = 0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg1, arg2, (v0 as u128), true, v1, arg4, arg5, arg6);
        let v3 = 0x2::bcs::new(0x2::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v2));
        0x2::bcs::peel_u128(&mut v3);
        0x2::bcs::peel_u128(&mut v3);
        0xf36a18c278a8dac6ee429474b5e00d5090cef239e68642d26d03966cd1119664::probe::check_step(arg0, v0 - (0x2::bcs::peel_u128(&mut v3) as u64), (0x2::bcs::peel_u128(&mut v3) as u64), arg3);
    }

    // decompiled from Move bytecode v7
}

