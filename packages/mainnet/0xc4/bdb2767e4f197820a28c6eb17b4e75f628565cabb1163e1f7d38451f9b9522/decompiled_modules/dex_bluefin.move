module 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::dex_bluefin {
    public fun calculate_swap_output(arg0: u64, arg1: bool) : u64 {
        arg0 * 9998 / 10000
    }

    public fun check_token_compatibility() : bool {
        true
    }

    public fun get_bluefin_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun get_min_trade_amount() : u64 {
        1
    }

    public fun get_performance_specs() : (u64, u64) {
        (30, 550)
    }

    public fun get_sui_wusdc_pool() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun get_trading_fee() : u64 {
        2
    }

    public fun supports_aggregator() : bool {
        true
    }

    public fun supports_high_performance() : bool {
        true
    }

    public fun supports_wusdc() : bool {
        true
    }

    public entry fun swap_sui_to_wusdc<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun swap_wusdc_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        abort 3
    }

    public entry fun swap_wusdc_to_sui_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(swap_wusdc_to_sui<T0>(arg0, arg1, arg2, arg3), v0);
    }

    public fun validate_pool(arg0: address) : bool {
        arg0 != @0x0
    }

    // decompiled from Move bytecode v6
}

