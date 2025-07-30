module 0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle_utils {
    public fun get_amount(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::MmtOracle, arg3: &0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, 0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::registry::get_coin_decimals(arg3, arg0)) as u256) / (0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_amount_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::MmtOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((arg1 as u256) * (0x2::math::pow(10, arg3) as u256) / (0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::get_price(arg2, arg0, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::MmtOracle, arg3: &0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, 0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::registry::get_coin_decimals(arg3, arg0)) as u256)) as u64)
    }

    public fun get_usd_value_with_decimals(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::MmtOracle, arg3: u8, arg4: &0x2::clock::Clock) : u64 {
        (((0x897afe272a24226c5d8cf276f1e757e1043b554135d5bc8ecc8aee232f170821::oracle::get_price(arg2, arg0, arg4) as u256) * (arg1 as u256) / (0x2::math::pow(10, arg3) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

