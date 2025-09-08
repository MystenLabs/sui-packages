module 0x6403815dbfc46f683b66006229c662dfed4664ec2be440c74c276cf9c32507c9::ssui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun lst_amount_to_sui_amount(arg0: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>, arg1: u64) : u64 {
        (((0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>(arg0) as u128) * (arg1 as u128) / (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>(arg0) as u128)) as u64)
    }

    public fun update_price(arg0: &mut 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle::StingrayOracle, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>, arg2: &0x2::clock::Clock) {
        let v0 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle::get_price(arg0, arg2, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>()));
        let v1 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>()));
        let v2 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg2, ((0x1::u128::pow(10, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::decimals(&v2)) * (lst_amount_to_sui_amount(arg1, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::price(&v0)) as u128) / 0x1::u128::pow(10, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::decimals(&v0))) as u64));
    }

    // decompiled from Move bytecode v6
}

