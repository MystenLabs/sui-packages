module 0xac4b3436bd7a032d416a3ce06462d767f8f1869bebcf7959fa4e59f7c4d89b65::execution {
    public fun maybe_deposit<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0x2::coin::Coin<T1>>, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg5)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg5);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg0, arg1, 0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::create_deposit_cap_v2<T0, T1>(arg2, arg0, arg3, arg4), 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg5), 0, arg6))
    }

    public fun maybe_deposit_afsui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::MetaVaultAfSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, 0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::create_deposit_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(arg4), 0, arg5))
    }

    public fun maybe_deposit_denominated<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::MetaVaultPythIntegrationDenominatedFeed, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<0x2::coin::Coin<T1>>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg0, arg1, 0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::create_deposit_cap_v2<T0, T1>(arg2, arg0, arg3, arg4, arg5), 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg6), 0, arg7))
    }

    public fun maybe_deposit_hasui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x7375c056f15ebf6c393b9cc2dad3bb25e445ae071dc80bf4c7ec728cefe2852::exchange_rate::MetaVaultHaSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, 0x7375c056f15ebf6c393b9cc2dad3bb25e445ae071dc80bf4c7ec728cefe2852::exchange_rate::create_deposit_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(arg4), 0, arg5))
    }

    public fun maybe_deposit_spring<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::MetaVaultSpringSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg0, arg1, 0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::create_deposit_cap<T0, T1>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg4), 0, arg5))
    }

    public fun maybe_deposit_stsui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x506e1ca2bff0682708d416fa0aa8e2bed98eb46c5e7a17849511e8eb0aa4f040::exchange_rate::MetaVaultStSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, arg1, 0x506e1ca2bff0682708d416fa0aa8e2bed98eb46c5e7a17849511e8eb0aa4f040::exchange_rate::create_deposit_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(arg4), 0, arg5))
    }

    public fun maybe_deposit_sui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x8e9aa615cd18d263cfea43d68e2519a2de2d39075756a05f67ae6cee2794ff06::exchange_rate::MetaVaultSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0x2::sui::SUI>(arg0, arg1, 0x8e9aa615cd18d263cfea43d68e2519a2de2d39075756a05f67ae6cee2794ff06::exchange_rate::create_deposit_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg4), 0, arg5))
    }

    public fun maybe_deposit_vsui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0xf9b2124c650ce066963a5fa3a5d632f4680ce5ff24cdb0ec4e38fe6fdedf797f::exchange_rate::MetaVaultVSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg1, 0xf9b2124c650ce066963a5fa3a5d632f4680ce5ff24cdb0ec4e38fe6fdedf797f::exchange_rate::create_deposit_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg4), 0, arg5))
    }

    public fun maybe_deposit_vsui_registry<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0xa01948eec945f7a5525d2726537ab1e395553a6e8df519e4f314f6eb4eae3c49::exchange_rate::MetaVaultVSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg1, 0xa01948eec945f7a5525d2726537ab1e395553a6e8df519e4f314f6eb4eae3c49::exchange_rate::create_deposit_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0x2::coin::Coin<T0>>, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg5)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg5);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg0, arg1, 0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::create_withdraw_cap_v2<T0, T1>(arg2, arg0, arg3, arg4), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg5), 0, arg6))
    }

    public fun maybe_withdraw_afsui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::MetaVaultAfSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, 0x36304ba033b2929f7664f20264dd4df782c19331d04207904f840064a87a7608::exchange_rate::create_withdraw_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw_denominated<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::MetaVaultPythIntegrationDenominatedFeed, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<0x2::coin::Coin<T0>>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg0, arg1, 0x834394c96ffa45c135a8c1459207ca3282c2db63875da63f46d5fb083eb3d921::pyth::create_withdraw_cap_v2<T0, T1>(arg2, arg0, arg3, arg4, arg5), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg6), 0, arg7))
    }

    public fun maybe_withdraw_hasui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x7375c056f15ebf6c393b9cc2dad3bb25e445ae071dc80bf4c7ec728cefe2852::exchange_rate::MetaVaultHaSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, 0x7375c056f15ebf6c393b9cc2dad3bb25e445ae071dc80bf4c7ec728cefe2852::exchange_rate::create_withdraw_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw_spring<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::MetaVaultSpringSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg0, arg1, 0xfd12517a9fc87c6a1f2357ad13b3421fb27a8bd7ca07d5fd5934ac35733baa47::exchange_rate::create_withdraw_cap<T0, T1>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw_stsui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x506e1ca2bff0682708d416fa0aa8e2bed98eb46c5e7a17849511e8eb0aa4f040::exchange_rate::MetaVaultStSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, arg1, 0x506e1ca2bff0682708d416fa0aa8e2bed98eb46c5e7a17849511e8eb0aa4f040::exchange_rate::create_withdraw_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw_sui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0x8e9aa615cd18d263cfea43d68e2519a2de2d39075756a05f67ae6cee2794ff06::exchange_rate::MetaVaultSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0x2::sui::SUI>(arg0, arg1, 0x8e9aa615cd18d263cfea43d68e2519a2de2d39075756a05f67ae6cee2794ff06::exchange_rate::create_withdraw_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw_vsui<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0xf9b2124c650ce066963a5fa3a5d632f4680ce5ff24cdb0ec4e38fe6fdedf797f::exchange_rate::MetaVaultVSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>()
        };
        0x1::option::some<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg1, 0xf9b2124c650ce066963a5fa3a5d632f4680ce5ff24cdb0ec4e38fe6fdedf797f::exchange_rate::create_withdraw_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    public fun maybe_withdraw_vsui_registry<T0>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &0xa01948eec945f7a5525d2726537ab1e395553a6e8df519e4f314f6eb4eae3c49::exchange_rate::MetaVaultVSuiIntegration, arg3: &mut 0x546b4c792de9744e08cb89f8f52b25cf5384db0af44f613db6d383234f009bb9::registry::Registry, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>()
        };
        0x1::option::some<0x2::coin::Coin<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg1, 0xa01948eec945f7a5525d2726537ab1e395553a6e8df519e4f314f6eb4eae3c49::exchange_rate::create_withdraw_cap<T0>(arg2, arg0, arg3), 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, arg5))
    }

    // decompiled from Move bytecode v7
}

