module 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter {
    public fun try_get_oracle_price(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) : u256 {
        let (_, v1, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, 0);
        v1
    }

    public fun update_haedal_price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 6, 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter_haedal::calculate_haedal_price(try_get_oracle_price(arg1, arg2), arg3));
    }

    public fun update_volo_and_haedal_prices(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        let v0 = try_get_oracle_price(arg1, arg2);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 5, 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter_volo::calculate_volo_price(v0, arg3, arg4));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 6, 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter_haedal::calculate_haedal_price(v0, arg5));
    }

    public fun update_volo_price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 5, 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter_volo::calculate_volo_price(try_get_oracle_price(arg1, arg2), arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

