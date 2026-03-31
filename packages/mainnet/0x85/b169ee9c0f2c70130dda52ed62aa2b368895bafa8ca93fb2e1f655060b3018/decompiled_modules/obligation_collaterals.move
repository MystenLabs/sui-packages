module 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation_collaterals {
    struct ObligationCollaterals has drop {
        dummy_field: bool,
    }

    struct Collateral has copy, drop, store {
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral> {
        let v0 = ObligationCollaterals{dummy_field: false};
        0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::new<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, true, arg0)
    }

    public fun collateral(arg0: &0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) : u64 {
        0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::borrow<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationCollaterals{dummy_field: false};
            0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::remove<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) {
        if (0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::contains<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1)) {
            return
        };
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = Collateral{amount: 0};
        0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::wit_table::add<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

