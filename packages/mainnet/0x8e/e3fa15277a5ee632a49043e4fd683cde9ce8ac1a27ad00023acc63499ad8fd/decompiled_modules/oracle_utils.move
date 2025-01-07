module 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils {
    public fun get_amount<T0>(arg0: u64, arg1: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg2: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::get_coin_decimals<T0>(arg2)) as u256) / (0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::get_price<T0>(arg1, arg3) as u256)) as u64)
    }

    public fun get_usd_value<T0>(arg0: u64, arg1: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg2: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : u64 {
        (((0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::get_price<T0>(arg1, arg3) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::get_coin_decimals<T0>(arg2)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

