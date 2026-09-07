module 0xc9432ba03b31d6eac024dea04618f6ff87f9d0977f0c599eccb69743c427608a::m3450421dc9932aadd7cf6813 {
    public fun f85e608c74cefb20bdcff536e(arg0: &0x2::clock::Clock, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg6: address) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v3(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

