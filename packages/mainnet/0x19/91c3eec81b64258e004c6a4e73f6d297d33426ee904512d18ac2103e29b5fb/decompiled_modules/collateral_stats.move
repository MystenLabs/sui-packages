module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::collateral_stats {
    struct CollateralStats has drop {
        dummy_field: bool,
    }

    struct CollateralStat has copy, store {
        amount: u64,
    }

    public fun collateral_amount(arg0: &0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) : u64 {
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1).amount
    }

    public(friend) fun decrease(arg0: &mut 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        assert!(v1.amount >= arg2, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::collateral_not_enough());
        v1.amount = v1.amount - arg2;
    }

    public(friend) fun increase(arg0: &mut 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        init_collateral_if_none(arg0, arg1);
        let v0 = CollateralStats{dummy_field: false};
        let v1 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::borrow_mut<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1);
        v1.amount = v1.amount + arg2;
    }

    public(friend) fun init_collateral_if_none(arg0: &mut 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat>, arg1: 0x1::type_name::TypeName) {
        if (0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::contains<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(arg0, arg1)) {
            return
        };
        let v0 = CollateralStats{dummy_field: false};
        let v1 = CollateralStat{amount: 0};
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::add<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, arg0, arg1, v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::WitTable<CollateralStats, 0x1::type_name::TypeName, CollateralStat> {
        let v0 = CollateralStats{dummy_field: false};
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::wit_table::new<CollateralStats, 0x1::type_name::TypeName, CollateralStat>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

