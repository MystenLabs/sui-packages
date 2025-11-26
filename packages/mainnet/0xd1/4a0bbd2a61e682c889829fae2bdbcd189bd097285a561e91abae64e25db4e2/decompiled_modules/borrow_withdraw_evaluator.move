module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg1: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::gt(v0, v1)) {
            0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::sub(v0, v1)
        } else {
            0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg1: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::gt(v0, 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::decimals(arg2, v2)), 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::div(v0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg1: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::risk_model::collateral_factor(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::decimals(arg2, v0)), 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::div(v1, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::price::get_price(arg3, v0, arg4))), v2), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

