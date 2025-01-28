module 0x7382f77f6e0090f8e71d7a02debdb358d1deffdcb74b70d808ad9a77b098f6b8::exchange_rate {
    struct MetaVaultAfSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultAfSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::authorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0>(arg0: &MetaVaultAfSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_deposit_cap<T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.id, arg1, hasui_to_sui_exchange_rate(arg2))
    }

    public fun create_withdraw_cap<T0>(arg0: &MetaVaultAfSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_withdraw_cap<T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.id, arg1, hasui_to_sui_exchange_rate(arg2))
    }

    public fun deauthorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultAfSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun hasui_to_sui_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        let v0 = (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_supply(arg0) as u128);
        let v1 = (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_total_sui(arg0) as u128);
        if (v1 == 0 || v0 == 0) {
            return (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() as u128)
        };
        v1 * (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() as u128) / v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultAfSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultAfSuiIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

