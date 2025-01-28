module 0x85d58f12dbc32ce47df656d36ee5a18524bdb181e3eb606bb0d5b1f406cb60cb::exchange_rate {
    struct MetaVaultAfSuiIntegration has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultAfSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::authorize(arg0, &mut arg1.id);
    }

    public fun create_deposit_cap<T0, T1>(arg0: &MetaVaultAfSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::DepositCap<T0, T1> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_deposit_cap<T0, T1>(&arg0.id, arg1, lsd_to_sui_exchange_rate<T1>(arg2))
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &MetaVaultAfSuiIntegration, arg1: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::Vault<T0>, arg2: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>) : 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::WithdrawCap<T0, T1> {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault::create_withdraw_cap<T0, T1>(&arg0.id, arg1, lsd_to_sui_exchange_rate<T1>(arg2))
    }

    public fun deauthorize(arg0: &0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::AdminCap, arg1: &mut MetaVaultAfSuiIntegration) {
        0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaVaultAfSuiIntegration{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MetaVaultAfSuiIntegration>(v0);
    }

    fun lsd_to_sui_exchange_rate<T0>(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>) : u128 {
        let v0 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg0) as u128);
        let v1 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg0) as u128);
        if (v0 == 0 || v1 == 0) {
            return (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() as u128)
        };
        v0 * (0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::math::exchange_rate_one_to_one() as u128) / v1
    }

    // decompiled from Move bytecode v6
}

