module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet {
    struct AdapterBalanceRecord has store {
        adapter_type: 0x1::type_name::TypeName,
        total_deposited: u64,
    }

    struct LendingSheet has store {
        adapter_records: 0x2::table::Table<0x1::type_name::TypeName, AdapterBalanceRecord>,
        adapter_types: vector<0x1::type_name::TypeName>,
        current_adapter: 0x1::string::String,
    }

    struct AdapterDepositInfo has copy, drop {
        adapter_type: 0x1::type_name::TypeName,
        deposited_amount: u64,
    }

    struct LendingSheetInfo has copy, drop {
        strategy_name: 0x1::string::String,
        current_adapter: 0x1::string::String,
        adapter_deposits: vector<AdapterDepositInfo>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : LendingSheet {
        LendingSheet{
            adapter_records : 0x2::table::new<0x1::type_name::TypeName, AdapterBalanceRecord>(arg0),
            adapter_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            current_adapter : 0x1::string::utf8(b""),
        }
    }

    public fun adapter_total_deposited<T0>(arg0: &LendingSheet) : u64 {
        total_deposited(arg0, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun adapter_types(arg0: &LendingSheet) : &vector<0x1::type_name::TypeName> {
        &arg0.adapter_types
    }

    public fun current_adapter(arg0: &LendingSheet) : 0x1::string::String {
        arg0.current_adapter
    }

    public fun destroy(arg0: LendingSheet) {
        let LendingSheet {
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
        assert!(v1 == 0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::cannot_destroy_record_with_active_deposits());
    }

    public fun get_info(arg0: &LendingSheet, arg1: 0x1::string::String) : LendingSheetInfo {
        let v0 = 0x1::vector::empty<AdapterDepositInfo>();
        let v1 = adapter_types(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2);
            let v4 = AdapterDepositInfo{
                adapter_type     : v3,
                deposited_amount : total_deposited(arg0, v3),
            };
            0x1::vector::push_back<AdapterDepositInfo>(&mut v0, v4);
            v2 = v2 + 1;
        };
        LendingSheetInfo{
            strategy_name    : arg1,
            current_adapter  : current_adapter(arg0),
            adapter_deposits : v0,
        }
    }

    public fun record_deposit_internal<T0>(arg0: &mut LendingSheet, arg1: u64) {
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

    public fun reset_adapter_deposits_internal<T0>(arg0: &mut LendingSheet) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, v0)) {
            0x2::table::borrow_mut<0x1::type_name::TypeName, AdapterBalanceRecord>(&mut arg0.adapter_records, v0).total_deposited = 0;
        };
    }

    public fun set_current_adapter_internal(arg0: &mut LendingSheet, arg1: 0x1::string::String) {
        arg0.current_adapter = arg1;
    }

    public fun total_deposited(arg0: &LendingSheet, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::table::contains<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, arg1)) {
            0x2::table::borrow<0x1::type_name::TypeName, AdapterBalanceRecord>(&arg0.adapter_records, arg1).total_deposited
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

