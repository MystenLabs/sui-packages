module 0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle_utils {
    public fun get_amount<T0>(arg0: u64, arg1: &0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::KriyaOracle, arg2: &0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::get_coin_decimals<T0>(arg2)) as u256) / (0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::get_price<T0>(arg1, arg3) as u256)) as u64)
    }

    public fun get_usd_value<T0>(arg0: u64, arg1: &0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::KriyaOracle, arg2: &0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : u64 {
        (((0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::get_price<T0>(arg1, arg3) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::get_coin_decimals<T0>(arg2)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

