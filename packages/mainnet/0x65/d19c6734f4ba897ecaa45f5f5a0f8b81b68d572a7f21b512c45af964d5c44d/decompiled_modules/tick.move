module 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::skip_list::SkipList<Tick>,
    }

    struct Tick has copy, drop, store {
        index: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::i128::I128,
        liquidity_gross: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        points_growth_outside: u128,
        rewards_growth_outside: vector<u128>,
    }

    // decompiled from Move bytecode v6
}

