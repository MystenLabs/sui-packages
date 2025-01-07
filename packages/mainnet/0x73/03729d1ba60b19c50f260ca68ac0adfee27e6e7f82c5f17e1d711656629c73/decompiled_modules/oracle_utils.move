module 0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::oracle_utils {
    public fun get_amount(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::oracle::KriyaOracle, arg3: &0x13a75d33b6121a2bcd660f64beb0941fcf6da762eb8f71a8ec6128e9c5f6c32e::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((arg0 as u256) * (0x2::math::pow(10, 0x13a75d33b6121a2bcd660f64beb0941fcf6da762eb8f71a8ec6128e9c5f6c32e::registry::get_coin_decimals(arg3, arg1)) as u256) / (0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::oracle::get_price(arg2, arg1, arg4) as u256)) as u64)
    }

    public fun get_usd_value(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: &0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::oracle::KriyaOracle, arg3: &0x13a75d33b6121a2bcd660f64beb0941fcf6da762eb8f71a8ec6128e9c5f6c32e::registry::CoinDecimalsRegistry, arg4: &0x2::clock::Clock) : u64 {
        (((0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::oracle::get_price(arg2, arg1, arg4) as u256) * (arg0 as u256) / (0x2::math::pow(10, 0x13a75d33b6121a2bcd660f64beb0941fcf6da762eb8f71a8ec6128e9c5f6c32e::registry::get_coin_decimals(arg3, arg1)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

