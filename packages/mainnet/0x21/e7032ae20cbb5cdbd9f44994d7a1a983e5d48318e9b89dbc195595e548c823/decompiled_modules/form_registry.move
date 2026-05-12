module 0x21e7032ae20cbb5cdbd9f44994d7a1a983e5d48318e9b89dbc195595e548c823::form_registry {
    struct FormMeta has store {
        id: 0x2::object::ID,
        creator: address,
        schema_blob_id: 0x1::string::String,
        submission_index_blob_id: 0x1::string::String,
        is_private: bool,
        created_at: u64,
        total_submissions: u64,
    }

    struct FormRegistry has key {
        id: 0x2::object::UID,
        forms: 0x2::table::Table<0x2::object::ID, FormMeta>,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        creator: address,
        schema_blob_id: 0x1::string::String,
    }

    struct SubmissionRecorded has copy, drop {
        form_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    public fun create_form(arg0: &mut FormRegistry, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = FormMeta{
            id                       : v1,
            creator                  : v2,
            schema_blob_id           : arg3,
            submission_index_blob_id : 0x1::string::utf8(b""),
            is_private               : arg4,
            created_at               : 0x2::clock::timestamp_ms(arg1),
            total_submissions        : 0,
        };
        0x2::table::add<0x2::object::ID, FormMeta>(&mut arg0.forms, v1, v3);
        0x21e7032ae20cbb5cdbd9f44994d7a1a983e5d48318e9b89dbc195595e548c823::access_control::create_admin_cap(v1, v2, arg5);
        let v4 = FormCreated{
            form_id        : v1,
            creator        : v2,
            schema_blob_id : arg3,
        };
        0x2::event::emit<FormCreated>(v4);
        0x2::object::delete(v0);
        v1
    }

    public fun get_form_meta(arg0: &FormRegistry, arg1: 0x2::object::ID) : (address, 0x1::string::String, 0x1::string::String, bool, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, FormMeta>(&arg0.forms, arg1);
        (v0.creator, v0.schema_blob_id, v0.submission_index_blob_id, v0.is_private, v0.created_at, v0.total_submissions)
    }

    public fun increment_submission_count(arg0: &mut FormRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, FormMeta>(&mut arg0.forms, arg1);
        v0.total_submissions = v0.total_submissions + 1;
        let v1 = SubmissionRecorded{
            form_id : arg1,
            blob_id : arg2,
        };
        0x2::event::emit<SubmissionRecorded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FormRegistry{
            id    : 0x2::object::new(arg0),
            forms : 0x2::table::new<0x2::object::ID, FormMeta>(arg0),
        };
        0x2::transfer::share_object<FormRegistry>(v0);
    }

    public fun update_submission_index(arg0: &mut FormRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        0x2::table::borrow_mut<0x2::object::ID, FormMeta>(&mut arg0.forms, arg1).submission_index_blob_id = arg2;
    }

    // decompiled from Move bytecode v7
}

