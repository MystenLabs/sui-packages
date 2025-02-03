module 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::tick {
    struct TickManager has store {
        tick_spacing: u32,
        ticks: 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::skip_list::SkipList<Tick>,
    }

    struct Tick has copy, drop, store {
        index: 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0x38013d6396a05b7009854a7ce95f23aabd91ba5d888c92908e527f8b5a51cb70::i128::I128,
        liquidity_gross: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        points_growth_outside: u128,
        rewards_growth_outside: vector<u128>,
    }

    // decompiled from Move bytecode v6
}

