module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::dex_adapter {
    public fun assert_dex_allowed<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg2: u8) {
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::is_dex_allowed(arg1, arg2), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::dex_not_allowed());
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::is_dex_allowed<T0>(arg0, arg2), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::dex_not_allowed());
    }

    public fun assert_pool_allowed<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: 0x2::object::ID) {
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::is_pool_allowed<T0>(arg0, arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::pool_not_allowed());
    }

    // decompiled from Move bytecode v7
}

