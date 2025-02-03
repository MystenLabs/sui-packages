module 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::oracle_utils {
    public fun get_amount(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::KriyaOracle, arg3: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::get_coin_decimals(arg3, arg1)) as u256) / (0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::get_price(arg2, arg1, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::KriyaOracle, arg3: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::get_price(arg2, arg1, arg4) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::get_coin_decimals(arg3, arg1)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

