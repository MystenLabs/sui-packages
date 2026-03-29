module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service {
    struct AccountData has store, key {
        id: 0x2::object::UID,
    }

    struct AccountKey has copy, drop, store {
        account: 0x1::ascii::String,
        dapp_key: 0x1::ascii::String,
    }

    struct DappHub has store, key {
        id: 0x2::object::UID,
        accounts: 0x2::object_table::ObjectTable<AccountKey, AccountData>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DappHub {
        DappHub{
            id       : 0x2::object::new(arg0),
            accounts : 0x2::object_table::new<AccountKey, AccountData>(arg0),
        }
    }

    public(friend) fun delete_record<T0: copy + drop>(arg0: &mut DappHub, arg1: T0, arg2: vector<vector<u8>>, arg3: 0x1::ascii::String) : vector<vector<u8>> {
        let v0 = new_account_key<T0>(arg3);
        assert!(0x2::object_table::contains<AccountKey, AccountData>(&arg0.accounts, v0), 2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_events::emit_store_delete_record(0x1::type_name::into_string(0x1::type_name::get<T0>()), arg3, arg2);
        0x2::dynamic_field::remove<vector<vector<u8>>, vector<vector<u8>>>(&mut 0x2::object_table::borrow_mut<AccountKey, AccountData>(&mut arg0.accounts, v0).id, arg2)
    }

    public fun ensure_has_not_record<T0: copy + drop>(arg0: &DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) {
        assert!(!has_record<T0>(arg0, arg1, arg2), 2);
    }

    public fun ensure_has_record<T0: copy + drop>(arg0: &DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) {
        assert!(has_record<T0>(arg0, arg1, arg2), 2);
    }

    public fun get_field<T0: copy + drop>(arg0: &DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: u8) : vector<u8> {
        let v0 = new_account_key<T0>(arg1);
        assert!(0x2::object_table::contains<AccountKey, AccountData>(&arg0.accounts, v0), 2);
        let v1 = 0x2::object_table::borrow<AccountKey, AccountData>(&arg0.accounts, v0);
        assert!(0x2::dynamic_field::exists_<vector<vector<u8>>>(&v1.id, arg2), 2);
        let v2 = 0x2::dynamic_field::borrow<vector<vector<u8>>, vector<vector<u8>>>(&v1.id, arg2);
        assert!((arg3 as u64) < 0x1::vector::length<vector<u8>>(v2), 3);
        *0x1::vector::borrow<vector<u8>>(v2, (arg3 as u64))
    }

    public fun get_record<T0: copy + drop>(arg0: &DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) : vector<u8> {
        let v0 = new_account_key<T0>(arg1);
        assert!(0x2::object_table::contains<AccountKey, AccountData>(&arg0.accounts, v0), 2);
        let v1 = 0x2::object_table::borrow<AccountKey, AccountData>(&arg0.accounts, v0);
        assert!(0x2::dynamic_field::exists_<vector<vector<u8>>>(&v1.id, arg2), 2);
        let v2 = 0x2::dynamic_field::borrow<vector<vector<u8>>, vector<vector<u8>>>(&v1.id, arg2);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(v2)) {
            0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(v2, v4));
            v4 = v4 + 1;
        };
        v3
    }

    public fun has_record<T0: copy + drop>(arg0: &DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) : bool {
        let v0 = new_account_key<T0>(arg1);
        if (!0x2::object_table::contains<AccountKey, AccountData>(&arg0.accounts, v0)) {
            return false
        };
        0x2::dynamic_field::exists_<vector<vector<u8>>>(&0x2::object_table::borrow<AccountKey, AccountData>(&arg0.accounts, v0).id, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<DappHub>(new(arg0));
    }

    public(friend) fun new_account_data(arg0: &mut 0x2::tx_context::TxContext) : AccountData {
        AccountData{id: 0x2::object::new(arg0)}
    }

    public(friend) fun new_account_key<T0: copy + drop>(arg0: 0x1::ascii::String) : AccountKey {
        AccountKey{
            account  : arg0,
            dapp_key : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        }
    }

    public(friend) fun set_field<T0: copy + drop>(arg0: &mut DappHub, arg1: T0, arg2: 0x1::ascii::String, arg3: vector<vector<u8>>, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<vector<u8>>, vector<vector<u8>>>(&mut 0x2::object_table::borrow_mut<AccountKey, AccountData>(&mut arg0.accounts, new_account_key<T0>(arg2)).id, arg3);
        assert!((arg4 as u64) < 0x1::vector::length<vector<u8>>(v0), 3);
        *0x1::vector::borrow_mut<vector<u8>>(v0, (arg4 as u64)) = arg5;
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_events::emit_store_set_record(0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2, arg3, *v0);
    }

    public(friend) fun set_record<T0: copy + drop>(arg0: &mut DappHub, arg1: T0, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: 0x1::ascii::String, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_events::emit_store_set_record(0x1::type_name::into_string(0x1::type_name::get<T0>()), arg4, arg2, arg3);
            return
        };
        let v0 = new_account_key<T0>(arg4);
        if (!0x2::object_table::contains<AccountKey, AccountData>(&arg0.accounts, v0)) {
            let v1 = new_account_data(arg6);
            0x2::dynamic_field::add<vector<vector<u8>>, vector<vector<u8>>>(&mut v1.id, arg2, arg3);
            0x2::object_table::add<AccountKey, AccountData>(&mut arg0.accounts, v0, v1);
        } else {
            let v2 = 0x2::object_table::borrow_mut<AccountKey, AccountData>(&mut arg0.accounts, v0);
            if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&v2.id, arg2)) {
                *0x2::dynamic_field::borrow_mut<vector<vector<u8>>, vector<vector<u8>>>(&mut v2.id, arg2) = arg3;
            } else {
                0x2::dynamic_field::add<vector<vector<u8>>, vector<vector<u8>>>(&mut v2.id, arg2, arg3);
            };
        };
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_events::emit_store_set_record(0x1::type_name::into_string(0x1::type_name::get<T0>()), arg4, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

