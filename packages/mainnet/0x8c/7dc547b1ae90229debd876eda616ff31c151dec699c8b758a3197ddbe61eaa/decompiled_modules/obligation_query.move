module 0x8c7dc547b1ae90229debd876eda616ff31c151dec699c8b758a3197ddbe61eaa::obligation_query {
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

    public fun collateral_data(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation) : vector<CollateralData> {
        let v0 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::collaterals(arg0);
        let v1 = 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::keys<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_collaterals::Collateral>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<CollateralData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v5 = CollateralData{
                type   : v4,
                amount : 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_collaterals::collateral(v0, v4),
            };
            0x1::vector::push_back<CollateralData>(&mut v3, v5);
            v2 = v2 + 1;
        };
        v3
    }

    public fun debt_data(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation) : vector<DebtData> {
        let v0 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::debts(arg0);
        let v1 = 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::keys<0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_debts::Debt>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<DebtData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let (v5, v6) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_debts::debt(v0, v4);
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

    public fun obligation_data(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation) {
        let v0 = ObligationData{
            collaterals : collateral_data(arg0),
            debts       : debt_data(arg0),
        };
        0x2::event::emit<ObligationData>(v0);
    }

    // decompiled from Move bytecode v6
}

