module 0x7c164c838025f39cac2f37dadaa1baf5884f3ea2fb026f52b0dba2d958686c3c::bank_script {
    public fun needs_rebalance<T0, T1>(arg0: &0x7bdb343641cb78ce811e4dc66216dd9939b2491a7312fb3d02eae99b0c930a97::bank::Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) {
        0x7c164c838025f39cac2f37dadaa1baf5884f3ea2fb026f52b0dba2d958686c3c::pool_scripts::emit_event<0x7bdb343641cb78ce811e4dc66216dd9939b2491a7312fb3d02eae99b0c930a97::bank::NeedsRebalance>(0x7bdb343641cb78ce811e4dc66216dd9939b2491a7312fb3d02eae99b0c930a97::bank::needs_rebalance<T0, T1>(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

