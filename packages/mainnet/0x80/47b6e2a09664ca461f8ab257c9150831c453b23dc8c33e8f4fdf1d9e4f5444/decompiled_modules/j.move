module 0x8047b6e2a09664ca461f8ab257c9150831c453b23dc8c33e8f4fdf1d9e4f5444::j {
    public fun sx(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        assert!(0x2::tx_context::sender(arg5) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
        0x2::coin::into_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(arg4, arg5), @0xd30018ec3f5ff1a3c75656abf927a87d7f0529e6dc89c7ddd1bd27ecb05e3db2, arg5))
    }

    public fun xs(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: 0x2::balance::Balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg5) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
        0x2::coin::into_balance<0x2::sui::SUI>(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_unstake_atomic(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg4, arg5), arg5))
    }

    // decompiled from Move bytecode v7
}

