module 0x3cabfd74570a33b5685dc12ac617566fa6403c104a90ec3c16af1fd0c9beead8::afsui_agg {
    struct AfsuiAgg has drop {
        dummy_field: bool,
    }

    public fun swap(arg0: &0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::router::Router, arg1: &mut 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::SwapContext, arg2: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg3: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg6: address, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7, 0);
        let v0 = AfsuiAgg{dummy_field: false};
        let v1 = swap_a2b(arg2, arg3, arg4, arg5, arg6, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::take_balance<AfsuiAgg, 0x2::sui::SUI>(arg1, arg0, v0, arg8), arg9);
        if (0x2::balance::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v1) > 0) {
            0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap::put_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg1, v1);
        } else {
            0x2::balance::destroy_zero<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(v1);
        };
    }

    fun swap_a2b(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: address, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg5) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg5);
            return 0x2::balance::zero<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>()
        };
        0x2::coin::into_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(arg5, arg6), arg4, arg6))
    }

    // decompiled from Move bytecode v6
}

