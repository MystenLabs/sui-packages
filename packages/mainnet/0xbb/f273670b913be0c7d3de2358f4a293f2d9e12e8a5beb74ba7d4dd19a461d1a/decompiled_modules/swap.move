module 0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::VaultCap, arg1: &mut 0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::version::Version) {
        0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::version::assert_current_version(arg3);
        0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::VaultCap, arg1: &mut 0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::Vault<T0, T1, T2>, arg2: &0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::version::Version) {
        0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::version::assert_current_version(arg2);
        0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

