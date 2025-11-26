module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg1: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral_types(arg0);
        let v1 = 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::add(v1, 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::mul(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::value_calculator::usd_value(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::price::get_price(arg3, v3, arg4), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral(arg0, v3), 0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::decimals(arg2, v3)), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::risk_model::collateral_factor(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg1: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg2: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral_types(arg0);
        let v1 = 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::add(v1, 0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::mul(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::value_calculator::usd_value(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::price::get_price(arg3, v3, arg4), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::collateral(arg0, v3), 0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::decimals(arg2, v3)), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::risk_model::liq_factor(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

