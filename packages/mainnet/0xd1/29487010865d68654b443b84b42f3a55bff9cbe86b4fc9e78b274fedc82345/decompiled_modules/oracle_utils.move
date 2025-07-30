module 0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle_utils {
    public fun get_amount(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::MmtOracle, arg3: &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, 0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::get_coin_decimals(arg3, arg0)) as u256) / (0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_amount_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::MmtOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, arg3) as u256) / (0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::MmtOracle, arg3: &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, 0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::get_coin_decimals(arg3, arg0)) as u256)) as u64)
    }

    public fun get_usd_value_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::MmtOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, arg3) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

