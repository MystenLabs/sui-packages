module 0x12cba441805e8d874f9c0c4fccfc3afe3fb6dc6c89e67d5051e2200fba69ae41::arbitrage_check {
    struct TradeInfoHotPotato {
        threshold_in_usd: u64,
        profit_in_usd: u64,
    }

    fun calculate_into_usd(arg0: u64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = get_pyth_price(arg2, arg1, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg0, v0, v1)
    }

    public fun end_evaluation(arg0: TradeInfoHotPotato) {
        let TradeInfoHotPotato {
            threshold_in_usd : v0,
            profit_in_usd    : v1,
        } = arg0;
        assert!(v1 >= v0, 2);
    }

    fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 1);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), v3)
    }

    public fun is_trade_profitable<T0>(arg0: &mut TradeInfoHotPotato, arg1: &0x2::coin::Coin<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        arg0.profit_in_usd = arg0.profit_in_usd + calculate_into_usd(0x2::coin::value<T0>(arg1), arg3, arg2, arg4);
    }

    public fun start_evaluation(arg0: u64) : TradeInfoHotPotato {
        assert!(arg0 > 0, 2);
        TradeInfoHotPotato{
            threshold_in_usd : arg0,
            profit_in_usd    : 0,
        }
    }

    // decompiled from Move bytecode v6
}

