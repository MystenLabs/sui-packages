module 0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::VaultCap, arg1: &mut 0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::version::Version) {
        0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::version::assert_current_version(arg3);
        0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::VaultCap, arg1: &mut 0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::Vault<T0, T1, T2>, arg2: &0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::version::Version) {
        0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::version::assert_current_version(arg2);
        0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

