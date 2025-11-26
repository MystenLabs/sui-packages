module 0xb78109a6bb238208ce4b7fcad7765b966349ca83580ac3bfbfbb615095d2aa2d::obligation_query {
    struct CollateralData has copy, drop, store {
        type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct DebtData has copy, drop, store {
        type: 0x1::type_name::TypeName,
        amount: u64,
        borrowIndex: u64,
    }

    struct ObligationData has copy, drop, store {
        collaterals: vector<CollateralData>,
        debts: vector<DebtData>,
    }

    public fun collateral_data(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation) : vector<CollateralData> {
        let v0 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::collaterals(arg0);
        let v1 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::keys<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation_collaterals::Collateral>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<CollateralData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v5 = CollateralData{
                type   : v4,
                amount : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation_collaterals::collateral(v0, v4),
            };
            0x1::vector::push_back<CollateralData>(&mut v3, v5);
            v2 = v2 + 1;
        };
        v3
    }

    public fun debt_data(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation) : vector<DebtData> {
        let v0 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::debts(arg0);
        let v1 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::keys<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation_debts::Debt>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<DebtData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let (v5, v6) = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation_debts::debt(v0, v4);
            let v7 = DebtData{
                type        : v4,
                amount      : v5,
                borrowIndex : v6,
            };
            0x1::vector::push_back<DebtData>(&mut v3, v7);
            v2 = v2 + 1;
        };
        v3
    }

    public fun obligation_data(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::version::Version, arg1: &mut 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market, arg2: &mut 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg1, arg2, arg3);
        let v0 = ObligationData{
            collaterals : collateral_data(arg2),
            debts       : debt_data(arg2),
        };
        0x2::event::emit<ObligationData>(v0);
    }

    // decompiled from Move bytecode v6
}

