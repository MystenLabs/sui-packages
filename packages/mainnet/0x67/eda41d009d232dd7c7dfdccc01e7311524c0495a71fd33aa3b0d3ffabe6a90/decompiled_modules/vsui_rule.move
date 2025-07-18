module 0x67eda41d009d232dd7c7dfdccc01e7311524c0495a71fd33aa3b0d3ffabe6a90::vsui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun check_share(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        abort 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::lst_amount_to_sui_amount(arg0, arg1, 1000000000)
    }

    public fun update_price(arg0: &mut 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::stingray_oracle::StingrayOracle, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x2::clock::Clock) {
        let v0 = 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::stingray_oracle::get_price(arg0, arg3, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()));
        let v1 = 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()));
        let v2 = 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg3, ((0x1::u128::pow(10, 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::decimals(&v2)) * (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::lst_amount_to_sui_amount(arg1, arg2, 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::price(&v0)) as u128) / 0x1::u128::pow(10, 0x8c088e5b87f1dd7f01afb89325714d93292bc2310b40221cf7802296983db12::oracle_aggregator::decimals(&v0))) as u64));
    }

    // decompiled from Move bytecode v6
}

