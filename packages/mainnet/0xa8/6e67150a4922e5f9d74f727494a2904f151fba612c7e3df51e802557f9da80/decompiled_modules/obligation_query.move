module 0xa86e67150a4922e5f9d74f727494a2904f151fba612c7e3df51e802557f9da80::obligation_query {
    struct CollateralData has copy, drop, store {
        type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct DebtData has copy, drop, store {
        type: 0x1::type_name::TypeName,
        amount: u64,
        borrowIndex: u64,
        accrued_interest: u64,
    }

    struct ObligationData has copy, drop, store {
        collaterals: vector<CollateralData>,
        debts: vector<DebtData>,
    }

    public fun collateral_data(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation) : vector<CollateralData> {
        let v0 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::collaterals(arg0);
        let v1 = 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::keys<0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation_collaterals::Collateral>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<CollateralData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v5 = CollateralData{
                type   : v4,
                amount : 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation_collaterals::collateral(v0, v4),
            };
            0x1::vector::push_back<CollateralData>(&mut v3, v5);
            v2 = v2 + 1;
        };
        v3
    }

    public fun debt_data(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation) : vector<DebtData> {
        let v0 = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::debts(arg0);
        let v1 = 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::keys<0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation_debts::Debt>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<DebtData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let (v5, v6, v7) = 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation_debts::debt(v0, v4);
            let v8 = DebtData{
                type             : v4,
                amount           : v5,
                borrowIndex      : v6,
                accrued_interest : v7,
            };
            0x1::vector::push_back<DebtData>(&mut v3, v8);
            v2 = v2 + 1;
        };
        v3
    }

    public fun obligation_data(arg0: &0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::version::Version, arg1: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::market::Market, arg2: &mut 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg1, arg2, arg3);
        let v0 = ObligationData{
            collaterals : collateral_data(arg2),
            debts       : debt_data(arg2),
        };
        0x2::event::emit<ObligationData>(v0);
    }

    // decompiled from Move bytecode v6
}

