module 0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle_utils {
    public fun get_amount(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg3: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, 0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::get_coin_decimals(arg3, arg0)) as u256) / (0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg3: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, 0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::get_coin_decimals(arg3, arg0)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

