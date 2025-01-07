module 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::Version, arg1: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &0x2::clock::Clock) {
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::assert_current_version(arg0);
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::Version, arg1: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::market::Market, arg2: &mut 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

