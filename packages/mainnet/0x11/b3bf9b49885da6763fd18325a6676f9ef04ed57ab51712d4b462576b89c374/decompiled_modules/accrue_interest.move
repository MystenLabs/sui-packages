module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: &0x2::clock::Clock) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::assert_current_version(arg0);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::Version, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

