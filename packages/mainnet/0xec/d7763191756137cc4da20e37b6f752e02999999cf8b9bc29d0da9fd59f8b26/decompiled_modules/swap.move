module 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::VaultCap, arg1: &mut 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::Version) {
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::assert_current_version(arg3);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::VaultCap, arg1: &mut 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::Vault<T0, T1, T2>, arg2: &0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::Version) {
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::version::assert_current_version(arg2);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

