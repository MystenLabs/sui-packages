module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::pricing {
    struct Pricing has store {
        base_spread: u64,
    }

    fun calculate_binary_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : u64 {
        500000000
    }

    public fun get_mint_cost<T0>(arg0: &Pricing, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let (_, v1) = get_quote<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(v1, arg3)
    }

    public fun get_quote<T0>(arg0: &Pricing, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::strike(&arg2);
        if (0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::is_settled<T0>(arg1)) {
            let v1 = if (0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::is_up(&arg2) && 0x1::option::destroy_some<u64>(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::settlement_price<T0>(arg1)) > v0 || !(0x1::option::destroy_some<u64>(0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::settlement_price<T0>(arg1)) > v0)) {
                0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::constants::float_scaling()
            } else {
                0
            };
            return (v1, v1)
        };
        let (v2, v3, v4, v5) = 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::get_pricing_data<T0>(arg1, v0, arg5);
        let v6 = calculate_binary_price(v2, v0, v3, v4, v5, 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::is_up(&arg2));
        let v7 = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(v6, arg0.base_spread);
        let v8 = if (v6 > v7) {
            v6 - v7
        } else {
            0
        };
        (v8, v6 + v7)
    }

    public fun get_redeem_payout<T0>(arg0: &Pricing, arg1: &0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes::OracleSVI<T0>, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let (v0, _) = get_quote<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(v0, arg3)
    }

    public(friend) fun new() : Pricing {
        Pricing{base_spread: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::constants::default_base_spread()}
    }

    // decompiled from Move bytecode v6
}

