module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::record {
    struct SaleRecord has store {
        record: 0x2::table::Table<address, u64>,
    }

    public fun check(arg0: &SaleRecord, arg1: u64, arg2: u64, arg3: address) {
        let v0 = &arg0.record;
        if (0x2::table::contains<address, u64>(v0, arg3)) {
            assert!(arg2 >= *0x2::table::borrow<address, u64>(v0, arg3) + arg1, 0);
        };
    }

    public fun create_sale_record(arg0: &mut 0x2::tx_context::TxContext) : SaleRecord {
        SaleRecord{record: 0x2::table::new<address, u64>(arg0)}
    }

    public(friend) fun get_sale_number(arg0: &SaleRecord, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.record, arg1), 9);
        *0x2::table::borrow<address, u64>(&arg0.record, arg1)
    }

    public(friend) fun increase_record(arg0: &mut SaleRecord, arg1: u64, arg2: address) {
        if (!0x2::table::contains<address, u64>(&arg0.record, arg2)) {
            0x2::table::add<address, u64>(&mut arg0.record, arg2, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.record, arg2);
        *v0 = *v0 + arg1;
    }

    // decompiled from Move bytecode v6
}

