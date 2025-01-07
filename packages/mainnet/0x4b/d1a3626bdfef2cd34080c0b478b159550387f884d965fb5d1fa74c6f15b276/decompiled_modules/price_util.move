module 0x4bd1a3626bdfef2cd34080c0b478b159550387f884d965fb5d1fa74c6f15b276::price_util {
    public fun evaluate_usd_value<T0>(arg0: &0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg1: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg2: u64, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T0>();
        0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::mul(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::price::get_price(arg0, v0, arg3), 0x1::fixed_point32::create_from_rational(arg2, 0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg1, v0))))
    }

    public fun is_liquidation_profitable<T0>(arg0: &0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg1: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x2::clock::Clock) : bool {
        0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::gt(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::mul(evaluate_usd_value<T0>(arg0, arg2, arg3, arg4), 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::sub(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::risk_model::liq_discount(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::risk_model(arg1, 0x1::type_name::get<T0>())), 0x1::fixed_point32::create_from_rational(225, 10000))), 0x1::fixed_point32::create_from_rational(1, 10))
    }

    // decompiled from Move bytecode v6
}

