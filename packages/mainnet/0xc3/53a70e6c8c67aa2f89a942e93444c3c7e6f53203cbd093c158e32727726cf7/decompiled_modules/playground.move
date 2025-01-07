module 0xc353a70e6c8c67aa2f89a942e93444c3c7e6f53203cbd093c158e32727726cf7::playground {
    public entry fun stake_sui(arg0: &mut 0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::request_stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::staked_sui_vault::sui_to_afsui(arg0, arg1, 0x2::coin::value<0x2::sui::SUI>(&arg4)) == 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0), 9999);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

