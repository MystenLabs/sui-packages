module 0x1a53c854f255869ee3a7614efe2381cc571495aaa25e0426a194b9dc2cfefbc8::vsui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun check_share(arg0: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        abort 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::lst_amount_to_sui_amount(arg0, arg1, 1000000000)
    }

    public fun update_price(arg0: &mut 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::stingray_oracle::StingrayOracle, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0x2::clock::Clock) {
        let v0 = 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::stingray_oracle::get_price(arg0, arg3, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()));
        let v1 = 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()));
        let v2 = 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg3, ((0x1::u128::pow(10, 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v2)) * (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::lst_amount_to_sui_amount(arg1, arg2, 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::price(&v0)) as u128) / 0x1::u128::pow(10, 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v0))) as u64));
    }

    // decompiled from Move bytecode v6
}

