module 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation_collaterals {
    struct Collateral has copy, drop, store {
        amount: u64,
    }

    struct ObligationCollaterals has drop {
        dummy_field: bool,
    }

    public fun collateral(arg0: &0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) : u64 {
        0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::borrow<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationCollaterals{dummy_field: false};
            0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::remove<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) {
        if (0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::contains<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1)) {
            return
        };
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = Collateral{amount: 0};
        0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::add<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral> {
        let v0 = ObligationCollaterals{dummy_field: false};
        0xf227811e2cfcdae5330164fb7bfa743e108c5d10845e2728a8c9a22482b52657::wit_table::new<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

