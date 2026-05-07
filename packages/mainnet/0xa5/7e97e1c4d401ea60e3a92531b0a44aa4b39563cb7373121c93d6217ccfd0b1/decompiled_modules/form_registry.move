module 0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::form_registry {
    struct Form has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        status: u8,
        schema_blob_id: 0x1::string::String,
        settings_hash: vector<u8>,
        access_policy_id: address,
        created_at: u64,
        updated_at: u64,
        submission_count: u64,
    }

    struct FormCreated has copy, drop {
        form_id: address,
        owner: address,
        schema_blob_id: 0x1::string::String,
        created_at: u64,
    }

    struct FormUpdated has copy, drop {
        form_id: address,
        schema_blob_id: 0x1::string::String,
        updated_at: u64,
    }

    struct FormArchived has copy, drop {
        form_id: address,
        archived_at: u64,
    }

    struct FormClosed has copy, drop {
        form_id: address,
        closed_at: u64,
    }

    public(friend) fun add_dynamic<T0: store>(arg0: &mut Form, arg1: vector<u8>, arg2: T0) {
        0x2::dynamic_field::add<vector<u8>, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun archive_form(arg0: &mut Form, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.status == 0, 2);
        arg0.status = 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = FormArchived{
            form_id     : 0x2::object::uid_to_address(&arg0.id),
            archived_at : arg0.updated_at,
        };
        0x2::event::emit<FormArchived>(v0);
    }

    public fun close_form(arg0: &mut Form, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.status == 0, 2);
        arg0.status = 2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = FormClosed{
            form_id   : 0x2::object::uid_to_address(&arg0.id),
            closed_at : arg0.updated_at,
        };
        0x2::event::emit<FormClosed>(v0);
    }

    public fun create_form(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Form{
            id               : 0x2::object::new(arg5),
            owner            : 0x2::tx_context::sender(arg5),
            title            : 0x1::string::utf8(arg0),
            status           : 0,
            schema_blob_id   : 0x1::string::utf8(arg1),
            settings_hash    : arg2,
            access_policy_id : arg3,
            created_at       : v0,
            updated_at       : v0,
            submission_count : 0,
        };
        let v2 = FormCreated{
            form_id        : 0x2::object::uid_to_address(&v1.id),
            owner          : v1.owner,
            schema_blob_id : v1.schema_blob_id,
            created_at     : v1.created_at,
        };
        0x2::event::emit<FormCreated>(v2);
        0x2::transfer::public_transfer<Form>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun form_id(arg0: &Form) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun increment_submission_count(arg0: &mut Form) {
        arg0.submission_count = arg0.submission_count + 1;
    }

    public fun is_active(arg0: &Form) : bool {
        arg0.status == 0
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun package_version() : u64 {
        0
    }

    public fun status(arg0: &Form) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_archived() : u8 {
        1
    }

    public fun status_closed() : u8 {
        2
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun update_metadata(arg0: &mut Form, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 1);
        assert!(arg0.status == 0, 2);
        arg0.title = 0x1::string::utf8(arg1);
        arg0.schema_blob_id = 0x1::string::utf8(arg2);
        arg0.settings_hash = arg3;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v0 = FormUpdated{
            form_id        : 0x2::object::uid_to_address(&arg0.id),
            schema_blob_id : arg0.schema_blob_id,
            updated_at     : arg0.updated_at,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

