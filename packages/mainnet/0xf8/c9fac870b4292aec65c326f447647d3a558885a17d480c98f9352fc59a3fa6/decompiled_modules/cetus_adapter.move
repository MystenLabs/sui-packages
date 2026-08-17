module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::cetus_adapter {
    public fun swap_exact_in<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T0>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultOperatorCap<T0>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg3: u64, arg4: u64) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_operator<T0>(arg0, arg1);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::dex_adapter::assert_dex_allowed<T0>(arg0, arg2, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::dex_cetus());
        abort 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::adapter_not_implemented()
    }

    // decompiled from Move bytecode v7
}

