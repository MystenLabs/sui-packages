module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::Version, arg1: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x2::clock::Clock) {
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::assert_current_version(arg0);
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::Version, arg1: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

