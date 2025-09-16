module 0x70d4b731a598e728d97bf0d855da02e337d6923579c02884750253547dd71868::tlp_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun update_price(arg0: &mut 0x711bf347f4f82b6786194da3f150f72be76fa0d38d0fbe76abc8f7376207d205::stingray_oracle::StingrayOracle, arg1: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1, _, _, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_pool_liquidity(arg1, arg2, arg3);
        let v5 = Rule{dummy_field: false};
        0x711bf347f4f82b6786194da3f150f72be76fa0d38d0fbe76abc8f7376207d205::oracle_aggregator::update_oracle_price_with_rule<Rule>(0x711bf347f4f82b6786194da3f150f72be76fa0d38d0fbe76abc8f7376207d205::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp::TLP>())), v5, arg4, (((v1 as u128) * (1000000 as u128) / (v0 as u128)) as u64));
    }

    // decompiled from Move bytecode v6
}

