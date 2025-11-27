module 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::version::Version, arg1: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x2::clock::Clock) {
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::version::assert_current_version(arg0);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::version::Version, arg1: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

