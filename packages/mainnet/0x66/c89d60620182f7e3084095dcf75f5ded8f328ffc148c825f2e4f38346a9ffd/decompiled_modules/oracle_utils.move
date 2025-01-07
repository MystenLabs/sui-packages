module 0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle_utils {
    public fun get_amount(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::KriyaOracle, arg3: &0xab1dc9e395f2be7ea69ffba49c451da8e841911fe532a6ed5bd4cf0af1dbd680::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, 0xab1dc9e395f2be7ea69ffba49c451da8e841911fe532a6ed5bd4cf0af1dbd680::registry::get_coin_decimals(arg3, arg0)) as u256) / (0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::KriyaOracle, arg3: &0xab1dc9e395f2be7ea69ffba49c451da8e841911fe532a6ed5bd4cf0af1dbd680::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x66c89d60620182f7e3084095dcf75f5ded8f328ffc148c825f2e4f38346a9ffd::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, 0xab1dc9e395f2be7ea69ffba49c451da8e841911fe532a6ed5bd4cf0af1dbd680::registry::get_coin_decimals(arg3, arg0)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

