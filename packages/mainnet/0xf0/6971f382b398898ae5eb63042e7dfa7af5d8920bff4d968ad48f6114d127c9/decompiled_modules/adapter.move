module 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter {
    public fun try_get_oracle_price(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) : u256 {
        let (_, v1, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, 0);
        v1
    }

    public fun update_volo_price(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::update_token_price(arg0, arg1, arg2, 5, 0xf06971f382b398898ae5eb63042e7dfa7af5d8920bff4d968ad48f6114d127c9::adapter_volo::calculate_volo_price(try_get_oracle_price(arg1, arg2), arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

