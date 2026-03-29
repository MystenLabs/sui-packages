module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_events {
    struct Dubhe_Store_SetRecord has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: 0x1::ascii::String,
        key: vector<vector<u8>>,
        value: vector<vector<u8>>,
    }

    struct Dubhe_Store_DeleteRecord has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: 0x1::ascii::String,
        key: vector<vector<u8>>,
    }

    public(friend) fun emit_store_delete_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) {
        0x2::event::emit<Dubhe_Store_DeleteRecord>(new_store_delete_record(arg0, arg1, arg2));
    }

    public(friend) fun emit_store_set_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) {
        0x2::event::emit<Dubhe_Store_SetRecord>(new_store_set_record(arg0, arg1, arg2, arg3));
    }

    public(friend) fun new_store_delete_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) : Dubhe_Store_DeleteRecord {
        Dubhe_Store_DeleteRecord{
            dapp_key : arg0,
            account  : arg1,
            key      : arg2,
        }
    }

    public(friend) fun new_store_set_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) : Dubhe_Store_SetRecord {
        Dubhe_Store_SetRecord{
            dapp_key : arg0,
            account  : arg1,
            key      : arg2,
            value    : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

