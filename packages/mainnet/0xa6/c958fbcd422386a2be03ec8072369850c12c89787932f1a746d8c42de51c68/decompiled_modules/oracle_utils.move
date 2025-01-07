module 0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle_utils {
    public fun get_amount(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::KriyaOracle, arg3: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, 0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::get_coin_decimals(arg3, arg0)) as u256) / (0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_amount_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::KriyaOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, arg3) as u256) / (0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::KriyaOracle, arg3: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, 0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::get_coin_decimals(arg3, arg0)) as u256)) as u64)
    }

    public fun get_usd_value_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::KriyaOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((0xa6c958fbcd422386a2be03ec8072369850c12c89787932f1a746d8c42de51c68::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, arg3) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

