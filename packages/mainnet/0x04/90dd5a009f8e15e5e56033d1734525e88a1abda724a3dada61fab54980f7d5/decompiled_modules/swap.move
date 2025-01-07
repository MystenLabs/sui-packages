module 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::VaultCap, arg1: &mut 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::Version) {
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::assert_current_version(arg3);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::VaultCap, arg1: &mut 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::Vault<T0, T1, T2>, arg2: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::Version) {
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::assert_current_version(arg2);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

