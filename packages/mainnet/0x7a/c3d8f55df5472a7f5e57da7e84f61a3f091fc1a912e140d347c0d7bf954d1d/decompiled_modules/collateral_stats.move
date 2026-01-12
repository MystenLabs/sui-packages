module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::collateral_stats {
    struct CollateralStats has drop {
        dummy_field: bool,
    }

    struct CollateralStat has copy, store {
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat> {
        let v0 = CollateralStats{dummy_field: false};
        0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::new<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, true, arg0)
    }

    public fun collateral_amount(arg0: &0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) : u64 {
        0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::borrow<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        assert!(v1.amount >= arg2, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::collateral_not_enough());
        v1.amount = v1.amount - arg2;
    }

    public(friend) fun increase(arg0: &mut 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) {
        if (0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::contains<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1)) {
            return
        };
        let v0 = CollateralStats{dummy_field: false};
        let v1 = CollateralStat{amount: 0};
        0x568976c5d1d15026da6591e7c763d9c48ab9cd82dc27ff6491c0f5835cf82277::wit_table::add<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

