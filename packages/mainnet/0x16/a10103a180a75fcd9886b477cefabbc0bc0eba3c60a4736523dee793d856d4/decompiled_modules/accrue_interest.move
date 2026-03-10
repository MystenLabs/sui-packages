module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::accrue_interest {
    public fun accrue_interest_for_market(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0x2::clock::Clock) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun accrue_interest_for_market_and_obligation(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        accrue_interest_for_market(arg0, arg1, arg3);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::accrue_interests(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

