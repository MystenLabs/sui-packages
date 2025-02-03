module 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::oracle_utils {
    public fun get_amount(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::KriyaOracle, arg3: &0x44f1677c61a905ae78e245d89b4cb7dffbb8bf4022a89f2b2e55ec18cbc6003c::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0x44f1677c61a905ae78e245d89b4cb7dffbb8bf4022a89f2b2e55ec18cbc6003c::registry::get_coin_decimals(arg3, arg1)) as u256) / (0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::get_price(arg2, arg1, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::KriyaOracle, arg3: &0x44f1677c61a905ae78e245d89b4cb7dffbb8bf4022a89f2b2e55ec18cbc6003c::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::get_price(arg2, arg1, arg4) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0x44f1677c61a905ae78e245d89b4cb7dffbb8bf4022a89f2b2e55ec18cbc6003c::registry::get_coin_decimals(arg3, arg1)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

