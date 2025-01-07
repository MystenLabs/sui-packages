module 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::calculations {
    public fun leverage_ratio(arg0: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64, arg3: u64) : u64 {
        normalized_leverage_ratio(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui(arg0, arg1, arg2), arg3)
    }

    public fun loan_to_value(arg0: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: u64, arg3: u64) : u64 {
        normalized_loan_to_value(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui(arg0, arg1, arg2), arg3)
    }

    public(friend) fun normalized_leverage_ratio(arg0: u64, arg1: u64) : u64 {
        ((1000000000000000000 / (1000000000000000000 - (normalized_loan_to_value(arg0, arg1) as u128))) as u64)
    }

    public(friend) fun normalized_loan_to_value(arg0: u64, arg1: u64) : u64 {
        ((1000000000000000000 * (arg1 as u128) / (arg0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

