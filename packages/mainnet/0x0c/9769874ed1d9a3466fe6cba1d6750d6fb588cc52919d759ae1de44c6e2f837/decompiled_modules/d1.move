module 0x999cce25f35deece2ad4414832cf2ba75f436677ef553664fa352cead152553c::d1 {
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
        cc: u64,
        dc: u64,
        ald: vector<Ld>,
    }

    public fun gold_d(arg0: &0x999cce25f35deece2ad4414832cf2ba75f436677ef553664fa352cead152553c::admin::AdminCap, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) : OldD {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg1, arg2, arg3, arg4, arg5);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg1, arg3, arg2, arg4, arg5);
        let v2 = 0x1::vector::empty<Ld>();
        let v3 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::Debt>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debts(arg1));
        let v4 = 0x1::vector::length<0x1::type_name::TypeName>(&v3);
        let v5 = 0;
        let v6 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::Collateral>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collaterals(arg1));
        let v7 = 0x1::vector::length<0x1::type_name::TypeName>(&v6);
        let v8 = 0;
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v1, v0)) {
            while (v5 < v4) {
                let v9 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v5);
                let v10 = 0x1::u64::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v9));
                let v11 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v9, arg5);
                while (v8 < v7) {
                    let v12 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v8);
                    let v13 = 0x1::u64::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg3, v12));
                    let v14 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg4, v12, arg5);
                    let v15 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::risk_model(arg2, v12);
                    let v16 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_discount(v15);
                    let v17 = 0x1::u64::min(0x1::fixed_point32::multiply_u64(v13, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v1, v0), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::borrow_weight(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg2, v9)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_penalty(v15))), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::liq_factor(v15))), v14)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg1, v12));
                    let v18 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v13, v10), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v11, v14)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), v16));
                    let v19 = 0x1::fixed_point32::divide_u64(v17, v18);
                    let (v20, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg1, v9);
                    let (v22, v23) = if (v19 <= v20) {
                        (v19, v17)
                    } else {
                        (v20, 0x1::fixed_point32::multiply_u64(v20, v18))
                    };
                    let v24 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v22, v10), v11);
                    let v25 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(v23, v13), v14);
                    let v26 = if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v25, v24)) {
                        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v25, v24)
                    } else {
                        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1)
                    };
                    let v27 = Ld{
                        mra : v22,
                        mla : v23,
                        mrv : v24,
                        mlv : v25,
                        miv : v26,
                        dt  : v9,
                        ct  : v12,
                    };
                    0x1::vector::push_back<Ld>(&mut v2, v27);
                    v8 = v8 + 1;
                };
                v5 = v5 + 1;
            };
        };
        OldD{
            cvufl : v0,
            dvuww : v1,
            cc    : v7,
            dc    : v4,
            ald   : v2,
        }
    }

    public fun v(arg0: &0x999cce25f35deece2ad4414832cf2ba75f436677ef553664fa352cead152553c::admin::AdminCap) : u64 {
        10
    }

    // decompiled from Move bytecode v6
}

