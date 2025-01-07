module 0x658faaa4c750d1a96533dac26d0dd6d525271dfbbd1d74f6ded66eb38d22c99b::cetus_clmm_interaction {
    struct PreSwapResult has copy, drop {
        fee_rate: u64,
    }

    public entry fun pre_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PreSwapResult{fee_rate: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0)};
        0x2::event::emit<PreSwapResult>(v0);
    }

    // decompiled from Move bytecode v6
}

