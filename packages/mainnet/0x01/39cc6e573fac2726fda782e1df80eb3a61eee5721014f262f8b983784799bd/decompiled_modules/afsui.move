module 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::afsui {
    public fun s_a(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, u64) {
        let v0 = 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help::merge_all<0x2::sui::SUI>(arg4, arg7);
        0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help::transfer<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg7));
        let v1 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg0, arg1, arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut v0, arg5, arg7), arg6, arg7);
        (v1, 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v1))
    }

    public fun s_a1(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, u64) {
        let (v0, v1) = s_a(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

