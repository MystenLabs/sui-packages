module 0x774bba43dd675958d5b6a4f9aa0c9631100db18c46c0754424f6574060dc7b4e::vsui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun update_price(arg0: &mut 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::stingray_oracle::StingrayOracle, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x2::clock::Clock) {
        let v0 = 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::stingray_oracle::get_price(arg0, arg3, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()));
        let v1 = 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()));
        let v2 = 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg3, (((0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::decimals(&v2) as u128) * (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::price(&v0)) as u128) / (0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::decimals(&v0) as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

