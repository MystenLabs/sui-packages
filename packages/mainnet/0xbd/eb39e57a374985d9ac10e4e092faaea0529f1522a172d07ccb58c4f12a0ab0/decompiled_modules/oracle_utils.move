module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::oracle_utils {
    public fun get_amount(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x3044608c4c51724de685e38002d4d4f3a2e26f598c8f4200a40ae269b6a771bf::oracle::KriyaOracle, arg3: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::get_coin_decimals(arg3, arg1)) as u256) / (0x3044608c4c51724de685e38002d4d4f3a2e26f598c8f4200a40ae269b6a771bf::oracle::get_price(arg2, arg1, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x3044608c4c51724de685e38002d4d4f3a2e26f598c8f4200a40ae269b6a771bf::oracle::KriyaOracle, arg3: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x3044608c4c51724de685e38002d4d4f3a2e26f598c8f4200a40ae269b6a771bf::oracle::get_price(arg2, arg1, arg4) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::get_coin_decimals(arg3, arg1)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

