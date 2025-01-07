module 0x999cce25f35deece2ad4414832cf2ba75f436677ef553664fa352cead152553c::d {
    struct Ld has drop {
        mra: u64,
        mla: u64,
        mrv: 0x1::fixed_point32::FixedPoint32,
        mlv: 0x1::fixed_point32::FixedPoint32,
        miv: 0x1::fixed_point32::FixedPoint32,
        dt: 0x1::type_name::TypeName,
        ct: 0x1::type_name::TypeName,
    }

    struct OldD {
        cvufl: 0x1::fixed_point32::FixedPoint32,
        dvuww: 0x1::fixed_point32::FixedPoint32,
        ald: vector<Ld>,
    }

    public fun gold_d(arg0: &0x999cce25f35deece2ad4414832cf2ba75f436677ef553664fa352cead152553c::admin::AdminCap, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : OldD {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg1, arg2, arg3, arg4, arg5);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg1, arg3, arg2, arg4, arg5);
        let v2 = 0x1::vector::empty<Ld>();
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v1, v0)) {
            let v3 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::Debt>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debts(arg1));
            let v4 = 0;
            let v5 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::Collateral>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collaterals(arg1));
            let v6 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v8 = 0x1::u64::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v7));
                let v9 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v7, arg5);
                while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
                    let v10 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v6);
                    let v11 = 0x1::u64::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v10));
                    let v12 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v10, arg5);
                    let v13 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::risk_model(arg2, v10);
                    let v14 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_discount(v13);
                    let v15 = 0x1::u64::min(0x1::fixed_point32::multiply_u64(v11, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v1, v0), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::borrow_weight(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg2, v7)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_penalty(v13))), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_factor(v13))), v12)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg1, v10));
                    let v16 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v11, v8), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v9, v12)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), v14));
                    let v17 = 0x1::fixed_point32::divide_u64(v15, v16);
                    let (v18, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg1, v7);
                    let (v20, v21) = if (v17 <= v18) {
                        (v17, v15)
                    } else {
                        (v18, 0x1::fixed_point32::multiply_u64(v18, v16))
                    };
                    let v22 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v20, v8), v9);
                    let v23 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v21, v11), v12);
                    let v24 = if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v23, v22)) {
                        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v23, v22)
                    } else {
                        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1)
                    };
                    let v25 = Ld{
                        mra : v20,
                        mla : v21,
                        mrv : v22,
                        mlv : v23,
                        miv : v24,
                        dt  : v7,
                        ct  : v10,
                    };
                    0x1::vector::push_back<Ld>(&mut v2, v25);
                    v6 = v6 + 1;
                };
                v4 = v4 + 1;
            };
        };
        OldD{
            cvufl : v0,
            dvuww : v1,
            ald   : v2,
        }
    }

    public fun v(arg0: &0x999cce25f35deece2ad4414832cf2ba75f436677ef553664fa352cead152553c::admin::AdminCap) : u64 {
        11
    }

    // decompiled from Move bytecode v6
}

