module 0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::balance_sheet {
    struct AdapterBalanceRecord has store {
        adapter_type: 0x1::type_name::TypeName,
        total_deposited: u64,
    }

    struct BalanceSheet has store {
        adapter_records: 0x2::table::Table<0x1::type_name::TypeName, AdapterBalanceRecord>,
        adapter_types: vector<0x1::type_name::TypeName>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : BalanceSheet {
        BalanceSheet{
            adapter_records : 0x2::table::new<0x1::type_name::TypeName, AdapterBalanceRecord>(arg0),
            adapter_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun destroy(arg0: BalanceSheet) {
        let BalanceSheet {
            adapter_records : v0,
            adapter_types   : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&v3, v4)) {
                destroy_adapter_record(0x2::table::remove<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut v3, v4));
            };
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v2);
        0x2::table::destroy_empty<0x1::type_name::TypeName, AdapterBalanceRecord>(v3);
    }

    fun destroy_adapter_record(arg0: AdapterBalanceRecord) {
        let AdapterBalanceRecord {
            adapter_type    : _,
            total_deposited : _,
        } = arg0;
    }

    public fun has_adapter_record(arg0: &BalanceSheet, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, arg1)
    }

    public(friend) fun record_deposit<T0>(arg0: &mut BalanceSheet, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut arg0.adapter_records, v0);
            v1.total_deposited = v1.total_deposited + arg1;
        } else {
            let v2 = AdapterBalanceRecord{
                adapter_type    : v0,
                total_deposited : arg1,
            };
            0x2::table::add<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut arg0.adapter_records, v0, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.adapter_types, v0);
        };
    }

    public(friend) fun reset_adapter_deposits<T0>(arg0: &mut BalanceSheet) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, v0)) {
            0x2::table::borrow_mut<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut arg0.adapter_records, v0).total_deposited = 0;
        };
    }

    public fun total_deposited(arg0: &BalanceSheet, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, arg1)) {
            0x2::table::borrow<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, arg1).total_deposited
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

