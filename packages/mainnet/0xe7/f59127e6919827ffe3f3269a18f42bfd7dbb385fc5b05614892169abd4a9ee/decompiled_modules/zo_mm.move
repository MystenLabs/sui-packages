module 0xe7f59127e6919827ffe3f3269a18f42bfd7dbb385fc5b05614892169abd4a9ee::zo_mm {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        order_size: u64,
        profit_threshold_bps: u64,
        enabled: bool,
    }

    struct DeepBookQuote has copy, drop, store {
        bid_price: u64,
        bid_quantity: u64,
        ask_price: u64,
        ask_quantity: u64,
        timestamp: u64,
    }

    struct ZOQuote has copy, drop, store {
        price: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
        confidence: u64,
        timestamp: u64,
        expo: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
    }

    struct ArbitrageOpportunity has copy, drop {
        direction: u8,
        profit_bps: u64,
        db_price: u64,
        zo_price: u64,
        quantity: u64,
        timestamp: u64,
    }

    struct TradeExecuted has copy, drop {
        direction: u8,
        quantity: u64,
        db_price: u64,
        zo_price: u64,
        profit: u64,
        timestamp: u64,
    }

    public fun create_config(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            order_size           : arg0,
            profit_threshold_bps : arg1,
            enabled              : true,
        }
    }

    public fun create_db_balance_manager(arg0: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0)
    }

    public fun deposit_to_db_bm<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, arg1, arg2);
    }

    public fun get_quotes_from_zo(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) {
    }

    // decompiled from Move bytecode v6
}

