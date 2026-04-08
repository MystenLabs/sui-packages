module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fee_crank {
    public fun crank_fees<T0, T1, T2: store, T3: drop, T4, T5>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T4, T5, T2, T3>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T0, T4>, arg3: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T1, T5>, arg4: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        let (v0, v1) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::collect_protocol_fees<T4, T5, T2, T3>(arg0);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::move_fees<T0, T4>(arg2, v0);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::move_fees<T1, T5>(arg3, v1);
    }

    // decompiled from Move bytecode v6
}

