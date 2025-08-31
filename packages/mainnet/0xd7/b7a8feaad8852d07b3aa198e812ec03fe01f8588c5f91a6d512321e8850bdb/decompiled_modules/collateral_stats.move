module 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::collateral_stats {
    struct CollateralStats has drop {
        dummy_field: bool,
    }

    struct CollateralStat has copy, store {
        amount: u64,
    }

    public fun collateral_amount(arg0: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) : u64 {
        0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::borrow<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
    }

    public(friend) fun increase(arg0: &mut 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) {
        if (0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::contains<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1)) {
            return
        };
        let v0 = CollateralStats{dummy_field: false};
        let v1 = CollateralStat{amount: 0};
        0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::add<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat> {
        let v0 = CollateralStats{dummy_field: false};
        0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::wit_table::new<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

