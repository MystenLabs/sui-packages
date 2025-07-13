module 0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_aftermath_lsd {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_transaction::SwapTransaction<T0, T1>, arg7: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::state::State, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
        let v1 = 0x2::object::id<0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault>(arg0);
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_event::emit_common_swap<0x2::sui::SUI, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::consts::LSD_AFLTERMATH(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<0x2::sui::SUI>(&arg4), 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg5: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_transaction::SwapTransaction<T0, T1>, arg6: &0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_unstake_atomic(arg0, arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::object::id<0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault>(arg0);
        0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::swap_event::emit_common_swap<0x2::sui::SUI, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0x5b939ce941019fc869540b16d6856ff1cad15db8e4e21c07ec80ea5dd55fb4e2::consts::LSD_AFLTERMATH(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg4), 0x2::coin::value<0x2::sui::SUI>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

