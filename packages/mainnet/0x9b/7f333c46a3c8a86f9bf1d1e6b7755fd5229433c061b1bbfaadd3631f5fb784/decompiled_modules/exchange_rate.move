module 0xa80c97559a9d274c2c7b0b97aaeeab89f7a5640aae5237f42c96c0f1467d2bfa::exchange_rate {
    struct MetaVaultSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::authorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0>(arg0: &MetaVaultSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &mut 0xb2b5014d37dbcb5aff29d74cf356f29f200876b352c30d43d0abc54b978c088f::registry::Registry) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T0, 0x2::sui::SUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_deposit_cap<T0, 0x2::sui::SUI>(&arg0.id, arg1, 0xb2b5014d37dbcb5aff29d74cf356f29f200876b352c30d43d0abc54b978c088f::registry::coin_to_meta_coin_exchange_rate<T0, 0x2::sui::SUI>(arg2, arg1))
    }

    public fun create_withdraw_cap<T0>(arg0: &MetaVaultSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &mut 0xb2b5014d37dbcb5aff29d74cf356f29f200876b352c30d43d0abc54b978c088f::registry::Registry) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T0, 0x2::sui::SUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_withdraw_cap<T0, 0x2::sui::SUI>(&arg0.id, arg1, 0xb2b5014d37dbcb5aff29d74cf356f29f200876b352c30d43d0abc54b978c088f::registry::coin_to_meta_coin_exchange_rate<T0, 0x2::sui::SUI>(arg2, arg1))
    }

    public fun deauthorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultSuiIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

