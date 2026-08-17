module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T0>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg2: u8) {
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::is_dex_allowed(arg1, arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::dex_not_allowed());
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::is_dex_allowed<T0>(arg0, arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::is_pool_allowed<T0>(arg0, arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::pool_not_allowed());
    }

    // decompiled from Move bytecode v7
}

