module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::aftermath_adapter {
    public fun open_perp<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultOperatorCap<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg3: 0x2::object::ID, arg4: u64, arg5: bool) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_operator<T0>(arg0, arg1);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::dex_adapter::assert_dex_allowed<T0>(arg0, arg2, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::dex_aftermath());
        abort 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::adapter_not_implemented()
    }

    public fun swap_exact_in<T0, T1>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultOperatorCap<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg3: u64, arg4: u64) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_operator<T0>(arg0, arg1);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::dex_adapter::assert_dex_allowed<T0>(arg0, arg2, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::dex_aftermath());
        abort 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::adapter_not_implemented()
    }

    // decompiled from Move bytecode v7
}

