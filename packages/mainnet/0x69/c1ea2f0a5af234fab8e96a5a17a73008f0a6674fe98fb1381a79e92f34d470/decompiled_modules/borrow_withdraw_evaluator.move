module 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg1: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg2: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::gt(v0, v1)) {
            0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::sub(v0, v1)
        } else {
            0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg1: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg2: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::gt(v0, 0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::decimals(arg2, v2)), 0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::div(v0, 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg1: &0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg2: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::risk_model::collateral_factor(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::decimals(arg2, v0)), 0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::div(v1, 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::price::get_price(arg3, v0, arg4))), v2), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

