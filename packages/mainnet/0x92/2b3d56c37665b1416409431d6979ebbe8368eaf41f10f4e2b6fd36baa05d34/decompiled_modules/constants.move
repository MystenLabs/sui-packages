module 0x922b3d56c37665b1416409431d6979ebbe8368eaf41f10f4e2b6fd36baa05d34::constants {
    public fun apply_dex_fee(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 10000
    }

    public fun calculate_min_profitable_output_with_gas(arg0: u64) : u64 {
        arg0 + arg0 * 1000 / 1000000 + 2200000
    }

    public fun calculate_required_spread_bps(arg0: u64) : u64 {
        1000 + 2200000 * 1000000 / arg0
    }

    public fun calculate_total_fees(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 / 10000 + apply_dex_fee(arg0, arg1) * arg2 / 10000
    }

    public fun get_aftermath_fee_bps() : u64 {
        30
    }

    public fun get_aftermath_package() : address {
        @0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc
    }

    public fun get_basis_points() : u64 {
        10000
    }

    public fun get_basis_points_precision() : u64 {
        1000000
    }

    public fun get_bluefin_fee_bps() : u64 {
        5
    }

    public fun get_bluefin_package() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_bluefin_tick_size() : u64 {
        1
    }

    public fun get_cetus_fee_bps() : u64 {
        50
    }

    public fun get_cetus_integration_package() : address {
        @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3
    }

    public fun get_cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun get_cetus_sqrt_price_limit_max() : u128 {
        4295048016
    }

    public fun get_cetus_sqrt_price_limit_min() : u128 {
        79226673515401279992447579055
    }

    public fun get_deepbook_fee_bps() : u64 {
        25
    }

    public fun get_deepbook_lot_size() : u64 {
        1000
    }

    public fun get_deepbook_package() : address {
        @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244
    }

    public fun get_estimated_gas_cost() : u64 {
        2200000
    }

    public fun get_gas_budget_max() : u64 {
        20000000
    }

    public fun get_gas_budget_target() : u64 {
        2200000
    }

    public fun get_kriya_fee_bps() : u64 {
        30
    }

    public fun get_kriya_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun get_max_input_amount() : u64 {
        1000000000
    }

    public fun get_max_slippage_bps() : u64 {
        100
    }

    public fun get_min_input_amount() : u64 {
        100000000
    }

    public fun get_min_profit_bps() : u64 {
        1000
    }

    public fun get_mist_per_sui() : u64 {
        1000000000
    }

    public fun get_turbos_fee_bps() : u64 {
        30
    }

    public fun get_turbos_package() : address {
        @0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a
    }

    public fun is_profitable_after_gas(arg0: u64, arg1: u64) : bool {
        arg1 >= calculate_min_profitable_output_with_gas(arg0)
    }

    // decompiled from Move bytecode v6
}

