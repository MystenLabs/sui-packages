module 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::balance_sheet {
    struct AdapterBalanceRecord has store {
        adapter_type: 0x1::type_name::TypeName,
        total_deposited: u64,
    }

    struct BalanceSheet has store {
        adapter_records: 0x2::table::Table<0x1::type_name::TypeName, AdapterBalanceRecord>,
        adapter_types: vector<0x1::type_name::TypeName>,
        current_adapter: 0x1::string::String,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : BalanceSheet {
        BalanceSheet{
            adapter_records : 0x2::table::new<0x1::type_name::TypeName, AdapterBalanceRecord>(arg0),
            adapter_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            current_adapter : 0x1::string::utf8(b""),
        }
    }

    public fun adapter_types(arg0: &BalanceSheet) : &vector<0x1::type_name::TypeName> {
        &arg0.adapter_types
    }

    public fun current_adapter(arg0: &BalanceSheet) : &0x1::string::String {
        &arg0.current_adapter
    }

    public(friend) fun destroy(arg0: BalanceSheet) {
        let BalanceSheet {
            adapter_records : v0,
            adapter_types   : v1,
            current_adapter : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v3)) {
            let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&v4, v5)) {
                destroy_adapter_record(0x2::table::remove<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut v4, v5));
            };
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
        0x2::table::destroy_empty<0x1::type_name::TypeName, AdapterBalanceRecord>(v4);
    }

    fun destroy_adapter_record(arg0: AdapterBalanceRecord) {
        let AdapterBalanceRecord {
            adapter_type    : _,
            total_deposited : v1,
        } = arg0;
        assert!(v1 == 0, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::cannot_destroy_record_with_active_deposits());
    }

    public fun get_adapter_deposit(arg0: &BalanceSheet, arg1: 0x1::type_name::TypeName) : u64 {
        total_deposited(arg0, arg1)
    }

    public(friend) fun record_deposit<T0>(arg0: &mut BalanceSheet, arg1: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
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
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, v0)) {
            0x2::table::borrow_mut<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut arg0.adapter_records, v0).total_deposited = 0;
        };
    }

    public(friend) fun set_current_adapter(arg0: &mut BalanceSheet, arg1: 0x1::string::String) {
        arg0.current_adapter = arg1;
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

