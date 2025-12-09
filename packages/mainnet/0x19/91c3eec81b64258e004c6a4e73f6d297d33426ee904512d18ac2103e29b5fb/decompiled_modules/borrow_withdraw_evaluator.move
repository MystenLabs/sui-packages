module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg1: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg2: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v0, v1)) {
            0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::sub(v0, v1)
        } else {
            0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg1: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg2: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v0, 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::decimals(arg2, v2)), 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::div(v0, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg1: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg2: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::risk_model::collateral_factor(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::decimals(arg2, v0)), 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::div(v1, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::price::get_price(arg3, v0, arg4))), v2), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

