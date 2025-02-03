module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::skip_list::SkipList<Tick>,
    }

    struct Tick has copy, drop, store {
        index: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::i128::I128,
        liquidity_gross: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        points_growth_outside: u128,
        rewards_growth_outside: vector<u128>,
    }

    // decompiled from Move bytecode v6
}

