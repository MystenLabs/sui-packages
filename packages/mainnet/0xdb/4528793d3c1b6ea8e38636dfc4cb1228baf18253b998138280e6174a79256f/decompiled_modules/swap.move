module 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::VaultCap, arg1: &mut 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::Version) {
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::assert_current_version(arg3);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::VaultCap, arg1: &mut 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::Vault<T0, T1, T2>, arg2: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::Version) {
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::assert_current_version(arg2);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

