module 0x170fece09f519e982f5c9b17a18293efe7328dd685818b3082d12912b89ff490::r {
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

