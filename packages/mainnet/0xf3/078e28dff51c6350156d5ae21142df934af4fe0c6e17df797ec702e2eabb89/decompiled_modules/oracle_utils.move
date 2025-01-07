module 0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle_utils {
    public fun get_amount(arg0: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::version::Version, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::KriyaOracle, arg4: &0x88281f55d899a49554673c7a36838985be4a64934e65e2aa7bd9ba325cc61d76::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) : u64 {
        (((arg2 as u256) * (0x2::math::pow(10, 0x88281f55d899a49554673c7a36838985be4a64934e65e2aa7bd9ba325cc61d76::registry::get_coin_decimals(arg4, arg1)) as u256) / (0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::get_price(arg0, arg3, arg1, arg5) as u256)) as u64)
    }

    public fun get_usd_value(arg0: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::version::Version, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::KriyaOracle, arg4: &0x88281f55d899a49554673c7a36838985be4a64934e65e2aa7bd9ba325cc61d76::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) : u64 {
        (((0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::get_price(arg0, arg3, arg1, arg5) as u256) * (arg2 as u256) / (0x2::math::pow(10, 0x88281f55d899a49554673c7a36838985be4a64934e65e2aa7bd9ba325cc61d76::registry::get_coin_decimals(arg4, arg1)) as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

