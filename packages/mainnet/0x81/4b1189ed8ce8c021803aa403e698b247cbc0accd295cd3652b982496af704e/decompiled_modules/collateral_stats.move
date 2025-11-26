module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::collateral_stats {
    struct CollateralStats has drop {
        dummy_field: bool,
    }

    struct CollateralStat has copy, store {
        amount: u64,
    }

    public fun collateral_amount(arg0: &0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) : u64 {
        0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::borrow<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        assert!(v1.amount >= arg2, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::collateral_not_enough());
        v1.amount = v1.amount - arg2;
    }

    public(friend) fun increase(arg0: &mut 0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) {
        if (0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::contains<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1)) {
            return
        };
        let v0 = CollateralStats{dummy_field: false};
        let v1 = CollateralStat{amount: 0};
        0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::add<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat> {
        let v0 = CollateralStats{dummy_field: false};
        0xd24c9ef07bc5b61caae54b8a6e9f2b2cdeaf23e585262e79f92084de7d5021aa::wit_table::new<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

