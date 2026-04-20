module 0xfea3cf503dd65c9bfb4315db858cd5b8a212e0c77117adae30df01c8680b6953::bank_script {
    public fun needs_rebalance<T0, T1>(arg0: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) {
        0xfea3cf503dd65c9bfb4315db858cd5b8a212e0c77117adae30df01c8680b6953::pool_scripts::emit_event<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::NeedsRebalance>(0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::bank::needs_rebalance<T0, T1>(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

