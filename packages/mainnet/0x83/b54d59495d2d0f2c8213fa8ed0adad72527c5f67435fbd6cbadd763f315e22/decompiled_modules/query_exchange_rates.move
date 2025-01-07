module 0x83b54d59495d2d0f2c8213fa8ed0adad72527c5f67435fbd6cbadd763f315e22::query_exchange_rates {
    struct ExchangeRatesInfo has copy, drop {
        vsui_rate: u64,
        afsui_rate: u64,
        hasui_rate: u64,
    }

    public fun query_exchange_rates(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg3: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        let v0 = ExchangeRatesInfo{
            vsui_rate  : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg0, arg1, 1000000000),
            afsui_rate : (0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui_exchange_rate(arg2, arg3) as u64),
            hasui_rate : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg4),
        };
        0x2::event::emit<ExchangeRatesInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

