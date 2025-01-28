module 0xa3df4cb7b904b254871f165a0d3c5c3187e45b7e97e1c6902453026164ebdb56::exchange_rate {
    struct MetaVaultAfSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultAfSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::authorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0>(arg0: &MetaVaultAfSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_deposit_cap<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg0.id, arg1, stsui_to_sui_exchange_rate(arg2))
    }

    public fun create_withdraw_cap<T0>(arg0: &MetaVaultAfSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_withdraw_cap<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg0.id, arg1, stsui_to_sui_exchange_rate(arg2))
    }

    public fun deauthorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultAfSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultAfSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultAfSuiIntegration>(v0);
    }

    fun stsui_to_sui_exchange_rate(arg0: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>) : u128 {
        let v0 = (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0) as u128);
        let v1 = (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0) as u128);
        if (v1 == 0 || v0 == 0) {
            return (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() as u128)
        };
        v1 * (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() as u128) / v0
    }

    // decompiled from Move bytecode v6
}

