module 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::fee_crank {
    public fun crank_fees<T0, T1, T2: store>(arg0: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::BToken<T0>, 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::BToken<T1>, T2>, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::Bank<T0>, arg3: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::Bank<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_package_version(arg1);
        let (v0, v1) = 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::collect_protocol_fees<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::BToken<T0>, 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::BToken<T1>, T2>(arg0);
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::move_fees<T0>(arg2, v0);
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::move_fees<T1>(arg3, v1);
    }

    // decompiled from Move bytecode v6
}

