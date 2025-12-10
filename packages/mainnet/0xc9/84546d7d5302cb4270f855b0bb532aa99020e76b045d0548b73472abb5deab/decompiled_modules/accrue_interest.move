module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::version::Version, arg1: &mut 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &0x2::clock::Clock) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::version::assert_current_version(arg0);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::version::Version, arg1: &mut 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &mut 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

