module 0xfda12d6f008d547b1badd6024dc4fcede4a4a8ddeb24dc186a36e55f8da7a4ca::hasui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun update_price(arg0: &mut 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::StingrayOracle, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock) {
        let v0 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::get_price(arg0, arg2, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>()));
        let v1 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()));
        let v2 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg2, ((0x1::u128::pow(10, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::decimals(&v2)) * ((0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::price(&v0) * 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) / 1000000) as u128) / 0x1::u128::pow(10, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::decimals(&v0))) as u64));
    }

    // decompiled from Move bytecode v6
}

