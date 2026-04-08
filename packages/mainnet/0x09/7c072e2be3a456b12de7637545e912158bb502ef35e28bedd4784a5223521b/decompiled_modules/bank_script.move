module 0x97c072e2be3a456b12de7637545e912158bb502ef35e28bedd4784a5223521b::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T0, T1>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T2>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) {
        0x97c072e2be3a456b12de7637545e912158bb502ef35e28bedd4784a5223521b::pool_scripts::emit_event<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::NeedsRebalance>(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

