module 0x9f164a07ee0ac985dd9dc5df5ca572701a4496cdced651d6bb12fcbe3e51409f::walrusform {
    struct FormRegistry has key {
        id: 0x2::object::UID,
        forms: 0x2::table::Table<0x1::string::String, FormEntry>,
        total_forms: u64,
    }

    struct FormEntry has store {
        form_id: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        owner: address,
        created_at: u64,
        is_published: bool,
        submission_index_blob_id: 0x1::string::String,
    }

    struct FormCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        owner: address,
    }

    entry fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FormRegistry{
            id          : 0x2::object::new(arg0),
            forms       : 0x2::table::new<0x1::string::String, FormEntry>(arg0),
            total_forms : 0,
        };
        0x2::transfer::share_object<FormRegistry>(v0);
    }

    public fun get_form(arg0: &FormRegistry, arg1: vector<u8>) : (0x1::string::String, 0x1::string::String, address, bool) {
        let v0 = 0x2::table::borrow<0x1::string::String, FormEntry>(&arg0.forms, 0x1::string::utf8(arg1));
        (v0.schema_blob_id, v0.submission_index_blob_id, v0.owner, v0.is_published)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_registry(arg0);
    }

    entry fun publish_form(arg0: &mut FormRegistry, arg1: &FormCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        assert!(arg1.form_id == v0, 0);
        0x2::table::borrow_mut<0x1::string::String, FormEntry>(&mut arg0.forms, v0).is_published = true;
    }

    entry fun register_form(arg0: &mut FormRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = FormEntry{
            form_id                  : v0,
            schema_blob_id           : 0x1::string::utf8(arg2),
            owner                    : v1,
            created_at               : 0x2::clock::timestamp_ms(arg3),
            is_published             : false,
            submission_index_blob_id : 0x1::string::utf8(b""),
        };
        0x2::table::add<0x1::string::String, FormEntry>(&mut arg0.forms, v0, v2);
        let v3 = FormCap{
            id      : 0x2::object::new(arg4),
            form_id : v0,
            owner   : v1,
        };
        0x2::transfer::transfer<FormCap>(v3, v1);
        arg0.total_forms = arg0.total_forms + 1;
    }

    entry fun submit_response(arg0: &mut FormRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<0x1::string::String, FormEntry>(&mut arg0.forms, 0x1::string::utf8(arg1)).submission_index_blob_id = 0x1::string::utf8(arg2);
    }

    entry fun update_index(arg0: &mut FormRegistry, arg1: &FormCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        assert!(arg1.form_id == v0, 0);
        0x2::table::borrow_mut<0x1::string::String, FormEntry>(&mut arg0.forms, v0).submission_index_blob_id = 0x1::string::utf8(arg3);
    }

    // decompiled from Move bytecode v7
}

