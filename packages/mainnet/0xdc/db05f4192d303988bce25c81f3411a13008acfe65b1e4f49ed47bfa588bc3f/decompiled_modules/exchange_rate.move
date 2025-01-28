module 0xdcdb05f4192d303988bce25c81f3411a13008acfe65b1e4f49ed47bfa588bc3f::exchange_rate {
    struct MetaVaultSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0>(arg0: &MetaVaultSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T0, 0x2::sui::SUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_deposit_cap<T0, 0x2::sui::SUI>(&arg0.id, arg1, sui_to_sui_exchange_rate())
    }

    public fun create_withdraw_cap<T0>(arg0: &MetaVaultSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T0, 0x2::sui::SUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_withdraw_cap<T0, 0x2::sui::SUI>(&arg0.id, arg1, sui_to_sui_exchange_rate())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultSuiIntegration>(v0);
    }

    fun sui_to_sui_exchange_rate() : u128 {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one()
    }

    // decompiled from Move bytecode v6
}

