module 0x1e0049bb286ba23462760df4468f1f878f600ca2fbdc75fb2ffe21a316023ccf::obligation_query {
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

    public fun collateral_data(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::Obligation) : vector<CollateralData> {
        let v0 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::collaterals(arg0);
        let v1 = 0x3399efb6f5452ad03013db442f233efeae9df438e4edde34b7bdff9e767e1ffc::wit_table::keys<0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation_collaterals::Collateral>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<CollateralData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v5 = CollateralData{
                type   : v4,
                amount : 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation_collaterals::collateral(v0, v4),
            };
            0x1::vector::push_back<CollateralData>(&mut v3, v5);
            v2 = v2 + 1;
        };
        v3
    }

    public fun debt_data(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::Obligation) : vector<DebtData> {
        let v0 = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::debts(arg0);
        let v1 = 0x3399efb6f5452ad03013db442f233efeae9df438e4edde34b7bdff9e767e1ffc::wit_table::keys<0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation_debts::Debt>(v0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<DebtData>();
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let (v5, v6, v7) = 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation_debts::debt(v0, v4);
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

    public fun obligation_data(arg0: &0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::version::Version, arg1: &mut 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::market::Market, arg2: &mut 0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0xa0816d57df47db94f0022b4862bed94c0bc57b269f598fccc06ac2bbfe26cf67::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg1, arg2, arg3);
        let v0 = ObligationData{
            collaterals : collateral_data(arg2),
            debts       : debt_data(arg2),
        };
        0x2::event::emit<ObligationData>(v0);
    }

    // decompiled from Move bytecode v6
}

