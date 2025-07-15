module 0x91f2a14f443900c80e072c27ad4a3a11159b36e5c2ee84f1c80c434b62656c8c::constants {
    public fun aftermath_fee_rate() : u64 {
        30
    }

    public fun aftermath_package() : address {
        @0xc4049b2d1cc0f6e017fda8260e4377cecd236bd7f56a54fee120816e72e2e0dd
    }

    public fun bluefin_fee_rate() : u64 {
        30
    }

    public fun bluefin_package() : address {
        @0xb104ecc75397f3a65735ef26c85a037da1d197e26f4f275a9990a577ba0e6c4c
    }

    public fun cetus_fee_rate() : u64 {
        30
    }

    public fun cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun circuit_breaker_threshold() : u64 {
        1000000000000
    }

    public fun deepbook_fee_rate() : u64 {
        5
    }

    public fun deepbook_package() : address {
        @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809
    }

    public fun default_input_amount() : u64 {
        10000000
    }

    public fun default_slippage_bp() : u64 {
        100
    }

    public fun emergency_stop() : bool {
        false
    }

    public fun estimated_gas_cost() : u64 {
        5000000
    }

    public fun get_dex_fee_rate(arg0: address) : u64 {
        if (arg0 == aftermath_package()) {
            aftermath_fee_rate()
        } else if (arg0 == cetus_package()) {
            cetus_fee_rate()
        } else if (arg0 == bluefin_package()) {
            bluefin_fee_rate()
        } else if (arg0 == turbos_package()) {
            turbos_fee_rate()
        } else if (arg0 == kriya_package()) {
            kriya_fee_rate()
        } else {
            assert!(arg0 == deepbook_package(), 1);
            deepbook_fee_rate()
        }
    }

    public fun get_dex_priority(arg0: address) : u64 {
        if (arg0 == aftermath_package()) {
            1
        } else if (arg0 == cetus_package()) {
            2
        } else if (arg0 == kriya_package()) {
            3
        } else if (arg0 == bluefin_package()) {
            4
        } else if (arg0 == turbos_package()) {
            5
        } else if (arg0 == deepbook_package()) {
            6
        } else {
            999
        }
    }

    public fun is_approved_dex(arg0: address) : bool {
        if (arg0 == aftermath_package()) {
            true
        } else if (arg0 == cetus_package()) {
            true
        } else if (arg0 == bluefin_package()) {
            true
        } else if (arg0 == turbos_package()) {
            true
        } else if (arg0 == kriya_package()) {
            true
        } else {
            arg0 == deepbook_package()
        }
    }

    public fun is_supported_token(arg0: vector<u8>) : bool {
        if (arg0 == sui_type()) {
            true
        } else if (arg0 == wusdc_type()) {
            true
        } else if (arg0 == usdc_type()) {
            true
        } else {
            arg0 == usdt_type()
        }
    }

    public fun is_valid_amount(arg0: u64) : bool {
        arg0 >= min_arbitrage_amount() && arg0 <= max_arbitrage_amount()
    }

    public fun is_valid_slippage(arg0: u64) : bool {
        arg0 <= max_slippage_bp()
    }

    public fun kriya_fee_rate() : u64 {
        30
    }

    public fun kriya_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun max_arbitrage_amount() : u64 {
        100000000
    }

    public fun max_concurrent_swaps() : u64 {
        5
    }

    public fun max_gas_budget() : u64 {
        50000000
    }

    public fun max_gas_smashing_coins() : u64 {
        10
    }

    public fun max_price_impact_bp() : u64 {
        500
    }

    public fun max_route_hops() : u64 {
        3
    }

    public fun max_slippage_bp() : u64 {
        1000
    }

    public fun max_transactions_per_window() : u64 {
        100
    }

    public fun micro_input_amounts() : vector<u64> {
        vector[500000, 1000000, 1500000, 2000000]
    }

    public fun min_arbitrage_amount() : u64 {
        1000000
    }

    public fun min_pool_liquidity() : u64 {
        1000000000
    }

    public fun min_profit_margin_bp() : u64 {
        10
    }

    public fun rate_limit_window() : u64 {
        60
    }

    public fun required_confirmations() : u64 {
        1
    }

    public fun single_protocol_routing() : bool {
        true
    }

    public fun stable_tick_spacing() : u64 {
        10
    }

    public fun standard_tick_spacing() : u64 {
        60
    }

    public fun std_lib() : address {
        @0x1
    }

    public fun sui_framework() : address {
        @0x2
    }

    public fun sui_type() : vector<u8> {
        b"0x2::sui::SUI"
    }

    public fun target_gas_usage() : u64 {
        2000000
    }

    public fun transaction_deadline() : u64 {
        300
    }

    public fun turbos_fee_rate() : u64 {
        30
    }

    public fun turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun ultra_precision_slippages() : vector<u64> {
        vector[1, 2, 5]
    }

    public fun usdc_type() : vector<u8> {
        b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"
    }

    public fun usdt_type() : vector<u8> {
        b"0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN"
    }

    public fun wusdc_type() : vector<u8> {
        b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN"
    }

    // decompiled from Move bytecode v6
}

