module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::collateral_stats {
    struct CollateralStats has drop {
        dummy_field: bool,
    }

    struct CollateralStat has copy, store {
        amount: u64,
    }

    public fun collateral_amount(arg0: &0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) : u64 {
        0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::borrow<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        assert!(v1.amount >= arg2, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::collateral_not_enough());
        v1.amount = v1.amount - arg2;
    }

    public(friend) fun increase(arg0: &mut 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) {
        if (0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::contains<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1)) {
            return
        };
        let v0 = CollateralStats{dummy_field: false};
        let v1 = CollateralStat{amount: 0};
        0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::add<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat> {
        let v0 = CollateralStats{dummy_field: false};
        0x256911e365386c7ae85208df4ae9077bae5edc93a306577c7e4e855183f0005c::wit_table::new<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

