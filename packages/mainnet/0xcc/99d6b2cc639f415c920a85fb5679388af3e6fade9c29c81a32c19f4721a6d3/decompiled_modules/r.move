module 0x170fece09f519e982f5c9b17a18293efe7328dd685818b3082d12912b89ff490::r {
    public fun afsui_stake(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg5, 0x2::coin::into_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg1, arg2, arg3, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<0x2::sui::SUI>(arg0, arg5), arg7), @0xd30018ec3f5ff1a3c75656abf927a87d7f0529e6dc89c7ddd1bd27ecb05e3db2, arg7)), arg6);
    }

    public fun afsui_unstake_atomic(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<0x2::sui::SUI>(arg0, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_unstake_atomic(arg1, arg2, arg3, arg4, 0x2::coin::from_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg5), arg7), arg7)), arg6);
    }

    public fun metastable_afsui_deposit<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::MetaVaultAfSuiIntegration, arg2: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg3: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg4: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, arg5, 0x2::coin::into_balance<T0>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg2, arg3, 0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::create_deposit_cap<T0>(arg1, arg2, arg4), 0x2::coin::from_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg5), arg7), arg6, arg7)), arg6);
    }

    public fun metastable_afsui_withdraw<T0>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::MetaVaultAfSuiIntegration, arg2: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg3: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg4: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg5, 0x2::coin::into_balance<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg2, arg3, 0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::create_withdraw_cap<T0>(arg1, arg2, arg4), 0x2::coin::from_balance<T0>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T0>(arg0, arg5), arg7), arg6, arg7)), arg6);
    }

    public fun metastable_deposit<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::MetaVaultSpringSuiIntegration, arg2: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg3: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg4: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, arg5, 0x2::coin::into_balance<T0>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg2, arg3, 0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::create_deposit_cap<T0, T1>(arg1, arg2, arg4), 0x2::coin::from_balance<T1>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T1>(arg0, arg5), arg7), arg6, arg7)), arg6);
    }

    public fun metastable_withdraw<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::MetaVaultSpringSuiIntegration, arg2: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg3: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg4: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, arg5, 0x2::coin::into_balance<T1>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg2, arg3, 0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::create_withdraw_cap<T0, T1>(arg1, arg2, arg4), 0x2::coin::from_balance<T0>(0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T0>(arg0, arg5), arg7), arg6, arg7)), arg6);
    }

    // decompiled from Move bytecode v7
}

