module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg2: &0x2::clock::Clock) {
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::assert_current_version(arg0);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::Version, arg1: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg2: &mut 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

