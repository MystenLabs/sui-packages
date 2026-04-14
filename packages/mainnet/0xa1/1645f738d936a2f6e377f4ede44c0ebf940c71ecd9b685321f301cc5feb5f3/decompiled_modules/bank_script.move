module 0xa11645f738d936a2f6e377f4ede44c0ebf940c71ecd9b685321f301cc5feb5f3::bank_script {
    public fun needs_rebalance<T0, T1>(arg0: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::Bank<T0>, arg1: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x2::clock::Clock) {
        0xa11645f738d936a2f6e377f4ede44c0ebf940c71ecd9b685321f301cc5feb5f3::pool_scripts::emit_event<0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::NeedsRebalance>(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::bank::needs_rebalance<T0, T1>(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

