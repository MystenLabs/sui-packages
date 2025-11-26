module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation_debts {
    struct ObligationDebts has drop {
        dummy_field: bool,
    }

    struct Debt has copy, drop, store {
        amount: u64,
        borrow_index: u64,
    }

    public(friend) fun accrue_interest(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, arg0, arg1);
        if (v1.borrow_index == arg2) {
            return 0
        };
        v1.amount = 0x1::fixed_point32::multiply_u64(v1.amount, 0x1::fixed_point32::create_from_rational(arg2, v1.borrow_index));
        v1.borrow_index = arg2;
        v1.amount - v1.amount
    }

    public fun debt(arg0: &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName) : (u64, u64) {
        let v0 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow<ObligationDebts, 0x1::type_name::TypeName, Debt>(arg0, arg1);
        (v0.amount, v0.borrow_index)
    }

    public(friend) fun decrease(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationDebts{dummy_field: false};
            0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::remove<ObligationDebts, 0x1::type_name::TypeName, Debt>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_debt(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::contains<ObligationDebts, 0x1::type_name::TypeName, Debt>(arg0, arg1)) {
            return
        };
        let v0 = Debt{
            amount       : 0,
            borrow_index : arg2,
        };
        let v1 = ObligationDebts{dummy_field: false};
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::add<ObligationDebts, 0x1::type_name::TypeName, Debt>(v1, arg0, arg1, v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, Debt> {
        let v0 = ObligationDebts{dummy_field: false};
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::new<ObligationDebts, 0x1::type_name::TypeName, Debt>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

