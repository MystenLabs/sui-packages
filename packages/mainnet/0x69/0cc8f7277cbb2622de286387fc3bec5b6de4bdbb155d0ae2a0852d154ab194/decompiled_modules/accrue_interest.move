module 0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::version::Version, arg1: &mut 0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::market::Market, arg2: &0x2::clock::Clock) {
        0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::version::assert_current_version(arg0);
        0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::version::Version, arg1: &mut 0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::market::Market, arg2: &mut 0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0x690cc8f7277cbb2622de286387fc3bec5b6de4bdbb155d0ae2a0852d154ab194::obligation::accrue_interests_and_rewards(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

