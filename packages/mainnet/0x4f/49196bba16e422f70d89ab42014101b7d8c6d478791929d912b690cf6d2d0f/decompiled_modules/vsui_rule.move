module 0x4f49196bba16e422f70d89ab42014101b7d8c6d478791929d912b690cf6d2d0f::vsui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun update_price(arg0: &mut 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::stingray_oracle::StingrayOracle, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>());
        let v1 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::stingray_oracle::get_price(arg0, arg3, v0);
        let v2 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::stingray_oracle::borrow_oracle_aggregator_mut(arg0, v0);
        let v3 = 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::oracle_aggregator::price_info(v2);
        let v4 = Rule{dummy_field: false};
        0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::oracle_aggregator::update_oracle_price_with_rule<Rule>(v2, v4, arg3, (((0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::oracle_aggregator::decimals(&v3) as u128) * (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, 0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::oracle_aggregator::price(&v1)) as u128) / (0x68a2b9560dfb57fa605b5ef94acd0b0be0a05730ba332d03530dce21ab613bc9::oracle_aggregator::decimals(&v1) as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

