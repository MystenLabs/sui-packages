module 0x1c063819c4cc8eb8c3c63a6eed0d2f282204001b1560ffd618c7a3a0641bc0cc::obligation_query {
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

    public fun collateral_data(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation) : vector<CollateralData> {
        let v0 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::collaterals(arg0);
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation_collaterals::Collateral>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<CollateralData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v5 = CollateralData{
                type   : v4,
                amount : 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation_collaterals::collateral(v0, v4),
            };
            0x1::vector::push_back<CollateralData>(&mut v3, v5);
            v2 = v2 + 1;
        };
        v3
    }

    public fun debt_data(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation) : vector<DebtData> {
        let v0 = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::debts(arg0);
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::keys<0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation_debts::Debt>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<DebtData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let (v5, v6) = 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation_debts::debt(v0, v4);
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

    public fun obligation_data(arg0: &0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::obligation::Obligation) {
        let v0 = ObligationData{
            collaterals : collateral_data(arg0),
            debts       : debt_data(arg0),
        };
        0x2::event::emit<ObligationData>(v0);
    }

    // decompiled from Move bytecode v6
}

