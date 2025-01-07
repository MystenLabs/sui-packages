module 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter {
    public fun try_get_oracle_price(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) : u256 {
        let (_, v1, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, 0);
        v1
    }

    public fun update_aftermath_price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg4: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 6, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_aftermath::calculate_afsui_price(try_get_oracle_price(arg1, arg2), arg3, arg4));
    }

    public fun update_haedal_price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 5, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_haedal::calculate_haedal_price(try_get_oracle_price(arg1, arg2), arg3));
    }

    public fun update_lst_price1(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg7: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) {
        let v0 = try_get_oracle_price(arg1, arg2);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 4, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_volo::calculate_volo_price(v0, arg3, arg4));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 5, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_haedal::calculate_haedal_price(v0, arg5));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 6, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_aftermath::calculate_afsui_price(v0, arg6, arg7));
    }

    public fun update_volo_price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 4, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_volo::calculate_volo_price(try_get_oracle_price(arg1, arg2), arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

