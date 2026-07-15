module 0xee726987f46e38b368b2742379d290ec1828d176372eb7ec0d268b6939cfca30::lsd {
    public fun swap(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg5: address, arg6: bool, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::not_support_b2a());
        swap_a2b(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
    }

    fun swap_a2b(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg5: address, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<0x2::sui::SUI>(arg0, arg6);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, 0x2::coin::into_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg1, arg2, arg3, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg8), arg5, arg8)));
        if (arg7) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<0x2::sui::SUI>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<0x2::sui::SUI>(arg0), arg8);
        };
    }

    // decompiled from Move bytecode v7
}

