module 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::collateral_stats {
    struct CollateralStats has drop {
        dummy_field: bool,
    }

    struct CollateralStat has copy, store {
        amount: u64,
    }

    public fun collateral_amount(arg0: &0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) : u64 {
        0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::borrow<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount - arg2;
    }

    public(friend) fun increase(arg0: &mut 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) {
        if (0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::contains<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1)) {
            return
        };
        let v0 = CollateralStats{dummy_field: false};
        let v1 = CollateralStat{amount: 0};
        0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::add<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat> {
        let v0 = CollateralStats{dummy_field: false};
        0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::wit_table::new<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

