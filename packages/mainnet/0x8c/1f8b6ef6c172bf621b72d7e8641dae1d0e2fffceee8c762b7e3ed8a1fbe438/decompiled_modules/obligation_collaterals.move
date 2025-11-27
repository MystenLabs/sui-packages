module 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation_collaterals {
    struct ObligationCollaterals has drop {
        dummy_field: bool,
    }

    struct Collateral has copy, drop, store {
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral> {
        let v0 = ObligationCollaterals{dummy_field: false};
        0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::new<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, true, arg0)
    }

    public fun collateral(arg0: &0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) : u64 {
        0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::borrow<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationCollaterals{dummy_field: false};
            0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::remove<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) {
        if (0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::contains<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1)) {
            return
        };
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = Collateral{amount: 0};
        0x185f3c5e7f6677d7e9010b207b712d5649a42ed9b06a01fe3353e24221db5ab3::wit_table::add<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

