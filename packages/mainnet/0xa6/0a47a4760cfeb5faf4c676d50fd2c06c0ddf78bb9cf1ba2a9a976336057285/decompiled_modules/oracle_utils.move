module 0xa60a47a4760cfeb5faf4c676d50fd2c06c0ddf78bb9cf1ba2a9a976336057285::oracle_utils {
    public fun get_amount<T0>(arg0: u64, arg1: &0xa60a47a4760cfeb5faf4c676d50fd2c06c0ddf78bb9cf1ba2a9a976336057285::oracle::KriyaOracle, arg2: &0xc86cb3dd47296617d4da2480ea8c3c0c454041cf1ff955a35fb6383c8cf5b010::registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0xc86cb3dd47296617d4da2480ea8c3c0c454041cf1ff955a35fb6383c8cf5b010::registry::get_coin_decimals<T0>(arg2)) as u256) / (0xa60a47a4760cfeb5faf4c676d50fd2c06c0ddf78bb9cf1ba2a9a976336057285::oracle::get_price<T0>(arg1, arg3) as u256)) as u64)
    }

    public fun get_usd_value<T0>(arg0: u64, arg1: &0xa60a47a4760cfeb5faf4c676d50fd2c06c0ddf78bb9cf1ba2a9a976336057285::oracle::KriyaOracle, arg2: &0xc86cb3dd47296617d4da2480ea8c3c0c454041cf1ff955a35fb6383c8cf5b010::registry::CoinDecimalsRegistry, arg3: &0x2::clock::Clock) : u64 {
        (((0xa60a47a4760cfeb5faf4c676d50fd2c06c0ddf78bb9cf1ba2a9a976336057285::oracle::get_price<T0>(arg1, arg3) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0xc86cb3dd47296617d4da2480ea8c3c0c454041cf1ff955a35fb6383c8cf5b010::registry::get_coin_decimals<T0>(arg2)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

