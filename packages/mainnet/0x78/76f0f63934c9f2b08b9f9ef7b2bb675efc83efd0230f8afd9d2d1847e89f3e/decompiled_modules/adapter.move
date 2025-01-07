module 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::adapter {
    public fun try_get_oracle_price(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle) : u256 {
        let (_, v1, _) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::get_token_price(arg0, arg1, 0);
        v1
    }

    public fun update_haedal_price(arg0: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::update_token_price(arg0, arg1, arg2, 6, 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::adapter_haedal::calculate_haedal_price(try_get_oracle_price(arg1, arg2), arg3));
    }

    public fun update_volo_and_haedal_prices(arg0: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        let v0 = try_get_oracle_price(arg1, arg2);
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::update_token_price(arg0, arg1, arg2, 4, 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::adapter_volo::calculate_volo_price(v0, arg3, arg4));
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::update_token_price(arg0, arg1, arg2, 6, 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::adapter_haedal::calculate_haedal_price(v0, arg5));
    }

    public fun update_volo_price(arg0: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::update_token_price(arg0, arg1, arg2, 4, 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::adapter_volo::calculate_volo_price(try_get_oracle_price(arg1, arg2), arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

