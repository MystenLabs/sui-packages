module 0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle_utils {
    public fun get_amount(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::MmtOracle, arg3: &0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, 0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::registry::get_coin_decimals(arg3, arg0)) as u256) / (0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_amount_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::MmtOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, arg3) as u256) / (0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::MmtOracle, arg3: &0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, 0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::registry::get_coin_decimals(arg3, arg0)) as u256)) as u64)
    }

    public fun get_usd_value_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::MmtOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, arg3) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

