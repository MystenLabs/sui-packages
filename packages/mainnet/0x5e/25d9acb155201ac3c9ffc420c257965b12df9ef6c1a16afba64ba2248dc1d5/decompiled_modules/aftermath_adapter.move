module 0x5e25d9acb155201ac3c9ffc420c257965b12df9ef6c1a16afba64ba2248dc1d5::aftermath_adapter {
    public fun calculate_afsui_price(arg0: u256, arg1: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u256 {
        0x5e25d9acb155201ac3c9ffc420c257965b12df9ef6c1a16afba64ba2248dc1d5::utils::ray_mul((0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui_exchange_rate(arg1, arg2) as u256), arg0)
    }

    public fun try_get_afsui_ratio(arg0: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u128 {
        0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui_exchange_rate(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

