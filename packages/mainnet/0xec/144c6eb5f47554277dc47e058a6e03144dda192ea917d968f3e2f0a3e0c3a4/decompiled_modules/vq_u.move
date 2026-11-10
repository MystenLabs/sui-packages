module 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::vq_u {
    public fun u<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: bool, arg7: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::cn(arg0)) {
            let v1 = 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ra(arg0, v0);
            if (v1 > 0) {
                let v2 = if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::is_pause<T0, T1>(arg2)) {
                    0
                } else {
                    let v3 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg1, arg2, arg6, true, v1);
                    if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_is_exceed(&v3)) {
                        0
                    } else {
                        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v3)
                    }
                };
                0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::sr(arg0, v0, v2);
            };
            v0 = v0 + 1;
        };
        0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::np(arg0, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg2), arg6);
    }

    // decompiled from Move bytecode v7
}

