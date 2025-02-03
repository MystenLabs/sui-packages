module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation_collaterals {
    struct Collateral has copy, drop, store {
        amount: u64,
    }

    struct ObligationCollaterals has drop {
        dummy_field: bool,
    }

    public fun collateral(arg0: &0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) : u64 {
        0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::borrow<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
        if (v1.amount == 0) {
            let v2 = ObligationCollaterals{dummy_field: false};
            0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::remove<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v2, arg0, arg1);
        };
    }

    public(friend) fun increase(arg0: &mut 0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = 0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::borrow_mut<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>, arg1: 0x1::type_name::TypeName) {
        if (0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::contains<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(arg0, arg1)) {
            return
        };
        let v0 = ObligationCollaterals{dummy_field: false};
        let v1 = Collateral{amount: 0};
        0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::add<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::WitTable<ObligationCollaterals, 0x1::type_name::TypeName, Collateral> {
        let v0 = ObligationCollaterals{dummy_field: false};
        0xcfd595a530ce4fa5e35a69a526fb0aba65b64f41ffcac94fc58bed17013eb8c9::wit_table::new<ObligationCollaterals, 0x1::type_name::TypeName, Collateral>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

