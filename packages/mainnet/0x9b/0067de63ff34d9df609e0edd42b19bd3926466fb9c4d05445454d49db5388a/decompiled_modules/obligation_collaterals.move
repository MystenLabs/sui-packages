module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation_collaterals {
    struct ObligationCollaterals has drop {
        dummy_field: bool,
    }

    struct Collateral has copy, drop, store {
        amount: u64,
    }

    public fun collateral(arg0: &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) : u64 {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationCollaterals{dummy_field: false};
            0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::remove<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) {
        if (0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::contains<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1)) {
            return
        };
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = Collateral{amount: 0};
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::add<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral> {
        let v0 = ObligationCollaterals{dummy_field: false};
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::new<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

