module 0x705c1faf17387229cdef78956c2aec57189e8b80a7fce7e641abb534ad954c6::xsui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun lst_amount_to_sui_amount(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>, arg1: u64) : u64 {
        (((0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(arg0) as u128) * (arg1 as u128) / (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(arg0) as u128)) as u64)
    }

    public fun update_price(arg0: &mut 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::StingrayOracle, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>, arg2: &0x2::clock::Clock) {
        let v0 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::get_price(arg0, arg2, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>()));
        let v1 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>()));
        let v2 = 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg2, ((0x1::u128::pow(10, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::decimals(&v2)) * (lst_amount_to_sui_amount(arg1, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::price(&v0)) as u128) / 0x1::u128::pow(10, 0x49e7d33a8df46c0f450fd0219cd19b471bf42ce4f307197c61b45609a59c22d8::oracle_aggregator::decimals(&v0))) as u64));
    }

    // decompiled from Move bytecode v6
}

