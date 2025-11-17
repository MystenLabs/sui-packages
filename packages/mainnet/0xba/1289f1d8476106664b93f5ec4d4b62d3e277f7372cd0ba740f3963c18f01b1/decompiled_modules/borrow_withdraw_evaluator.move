module 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg1: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg2: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::gt(v0, v1)) {
            0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::sub(v0, v1)
        } else {
            0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg1: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg2: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::gt(v0, 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::decimals(arg2, v2)), 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::div(v0, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::Obligation, arg1: &0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::Market, arg2: &0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x95fd973aea15879e75407f4e4c66a8d1026ad10a25360275a73b0ce44c7b09e8::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::risk_model::collateral_factor(0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd2340f9ef1088b9fdc4d02d2628fcca4b4552f71ffdb03049425fc0a3b19ce41::coin_decimals_registry::decimals(arg2, v0)), 0xdb2f245331502370e5518886b9ef2ea52293df6d1238baa0a25de1341297feb0::fixed_point32_empower::div(v1, 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::price::get_price(arg3, v0, arg4))), v2), 0xba1289f1d8476106664b93f5ec4d4b62d3e277f7372cd0ba740f3963c18f01b1::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

