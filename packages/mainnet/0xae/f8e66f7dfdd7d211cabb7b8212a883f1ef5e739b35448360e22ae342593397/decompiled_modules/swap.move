module 0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::VaultCap, arg1: &mut 0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::version::Version) {
        0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::version::assert_current_version(arg3);
        0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::VaultCap, arg1: &mut 0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::Vault<T0, T1, T2>, arg2: &0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::version::Version) {
        0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::version::assert_current_version(arg2);
        0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

