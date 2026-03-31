module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation_collaterals {
    struct ObligationCollaterals has drop {
        dummy_field: bool,
    }

    struct Collateral has copy, drop, store {
        amount: u64,
    }

    public fun collateral(arg0: &0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) : u64 {
        0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::borrow<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationCollaterals{dummy_field: false};
            0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::remove<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) {
        if (0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::contains<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1)) {
            return
        };
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = Collateral{amount: 0};
        0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::add<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral> {
        let v0 = ObligationCollaterals{dummy_field: false};
        0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::new<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

