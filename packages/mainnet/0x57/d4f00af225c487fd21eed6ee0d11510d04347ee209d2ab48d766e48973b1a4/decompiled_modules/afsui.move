module 0x57d4f00af225c487fd21eed6ee0d11510d04347ee209d2ab48d766e48973b1a4::afsui {
    struct AfsuiSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b(arg0: &mut 0x57d4f00af225c487fd21eed6ee0d11510d04347ee209d2ab48d766e48973b1a4::config::Config, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg5: address, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg1, arg2, arg3, arg4, arg6, arg5, arg7);
        let (v1, v2) = 0x57d4f00af225c487fd21eed6ee0d11510d04347ee209d2ab48d766e48973b1a4::config::pay_fee<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, v0, arg7);
        let v3 = AfsuiSwapEvent{
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg6),
            amount_out : 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0) - v2,
            coin_a     : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_b     : 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(),
        };
        0x2::event::emit<AfsuiSwapEvent>(v3);
        v1
    }

    // decompiled from Move bytecode v6
}

