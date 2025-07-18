module 0xf5c482e658cf12781edb0472f73114c4668f212f77ec6e576b452a647b1b69be::vsui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun update_price(arg0: &mut 0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::stingray_oracle::StingrayOracle, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>());
        let v1 = 0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::stingray_oracle::get_price(arg0, arg3, v0);
        let v2 = 0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::stingray_oracle::borrow_oracle_aggregator_mut(arg0, v0);
        let v3 = 0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::oracle_aggregator::price_info(v2);
        let v4 = Rule{dummy_field: false};
        0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::oracle_aggregator::update_oracle_price_with_rule<Rule>(v2, v4, arg3, (((0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::oracle_aggregator::decimals(&v3) as u128) * (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, 0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::oracle_aggregator::price(&v1)) as u128) / (0x9f83dbb1597aeee026abf87aaf7f00f95a2aeddad6fab2aabebfd6f9787ca21e::oracle_aggregator::decimals(&v1) as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

