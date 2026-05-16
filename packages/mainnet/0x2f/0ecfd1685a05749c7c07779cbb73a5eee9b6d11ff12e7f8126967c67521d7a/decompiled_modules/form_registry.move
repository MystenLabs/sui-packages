module 0x2f0ecfd1685a05749c7c07779cbb73a5eee9b6d11ff12e7f8126967c67521d7a::form_registry {
    struct FormRecord has drop, store {
        creator: address,
        schema_blob_id: 0x1::string::String,
        is_private: bool,
        submission_count: u64,
        submission_index_blob_id: 0x1::string::String,
        created_at: u64,
    }

    struct FormRegistry has key {
        id: 0x2::object::UID,
        forms: 0x2::table::Table<0x1::string::String, FormRecord>,
    }

    public entry fun create_form(arg0: &mut FormRegistry, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = FormRecord{
            creator                  : 0x2::tx_context::sender(arg5),
            schema_blob_id           : arg3,
            is_private               : arg4,
            submission_count         : 0,
            submission_index_blob_id : 0x1::string::utf8(b""),
            created_at               : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<0x1::string::String, FormRecord>(&mut arg0.forms, arg2, v0);
    }

    public fun get_form_meta(arg0: &FormRegistry, arg1: 0x1::string::String) : (address, 0x1::string::String, bool, u64, 0x1::string::String, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, FormRecord>(&arg0.forms, arg1);
        (v0.creator, v0.schema_blob_id, v0.is_private, v0.submission_count, v0.submission_index_blob_id, v0.created_at)
    }

    public entry fun increment_submission_count(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, FormRecord>(&mut arg0.forms, arg1);
        v0.submission_count = v0.submission_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FormRegistry{
            id    : 0x2::object::new(arg0),
            forms : 0x2::table::new<0x1::string::String, FormRecord>(arg0),
        };
        0x2::transfer::share_object<FormRegistry>(v0);
    }

    public entry fun update_submission_index(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, FormRecord>(&mut arg0.forms, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 0);
        v0.submission_index_blob_id = arg2;
    }

    // decompiled from Move bytecode v7
}

