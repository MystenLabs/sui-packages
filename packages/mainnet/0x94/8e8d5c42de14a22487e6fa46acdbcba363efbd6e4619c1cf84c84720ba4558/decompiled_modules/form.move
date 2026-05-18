module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form {
    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        schema_blob_id: vector<u8>,
        is_private: bool,
        schema_version: u64,
        submission_identity_mode: u8,
    }

    struct SchemaUpdated has copy, drop {
        form_id: 0x2::object::ID,
        old_blob_id: vector<u8>,
        new_blob_id: vector<u8>,
        new_version: u64,
        updater: address,
    }

    struct FormClosed has copy, drop {
        form_id: 0x2::object::ID,
        closed_by: address,
    }

    struct FormReopened has copy, drop {
        form_id: 0x2::object::ID,
        reopened_by: address,
    }

    struct FormIdentityModeUpdated has copy, drop {
        form_id: 0x2::object::ID,
        old_mode: u8,
        new_mode: u8,
        updated_by: address,
    }

    struct Form has key {
        id: 0x2::object::UID,
        owner: address,
        schema_blob_id: vector<u8>,
        schema_version: u64,
        is_private: bool,
        is_closed: bool,
        submission_count: u64,
        created_at: u64,
        submission_identity_mode: u8,
    }

    struct FormOwnerCap has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    public(friend) fun cap_form_id(arg0: &FormOwnerCap) : 0x2::object::ID {
        arg0.form_id
    }

    entry fun close_form(arg0: &mut Form, arg1: &FormOwnerCap, arg2: &0x2::tx_context::TxContext) {
        verify_owner_cap(arg1, arg0);
        assert!(!arg0.is_closed, 10);
        arg0.is_closed = true;
        let v0 = FormClosed{
            form_id   : 0x2::object::uid_to_inner(&arg0.id),
            closed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FormClosed>(v0);
    }

    public(friend) fun close_form_internal(arg0: &mut Form, arg1: address) {
        if (!arg0.is_closed) {
            arg0.is_closed = true;
            let v0 = FormClosed{
                form_id   : 0x2::object::uid_to_inner(&arg0.id),
                closed_by : arg1,
            };
            0x2::event::emit<FormClosed>(v0);
        };
    }

    entry fun create(arg0: vector<u8>, arg1: bool, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 4);
        validate_identity_mode(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Form{
            id                       : 0x2::object::new(arg3),
            owner                    : v0,
            schema_blob_id           : arg0,
            schema_version           : 0,
            is_private               : arg1,
            is_closed                : false,
            submission_count         : 0,
            created_at               : 0x2::tx_context::epoch(arg3),
            submission_identity_mode : arg2,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = FormOwnerCap{
            id      : 0x2::object::new(arg3),
            form_id : v2,
        };
        let v4 = FormCreated{
            form_id                  : v2,
            owner                    : v0,
            schema_blob_id           : v1.schema_blob_id,
            is_private               : arg1,
            schema_version           : 0,
            submission_identity_mode : arg2,
        };
        0x2::event::emit<FormCreated>(v4);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::schema_version::create(v2, v1.schema_blob_id, 0, 0x1::option::none<vector<u8>>(), v0, arg3);
        0x2::transfer::share_object<Form>(v1);
        0x2::transfer::transfer<FormOwnerCap>(v3, v0);
    }

    public fun created_at(arg0: &Form) : u64 {
        arg0.created_at
    }

    public(friend) fun id(arg0: &Form) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun increment_submission_count(arg0: &mut Form) {
        arg0.submission_count = arg0.submission_count + 1;
    }

    public fun is_closed(arg0: &Form) : bool {
        arg0.is_closed
    }

    public fun is_private(arg0: &Form) : bool {
        arg0.is_private
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun owner_cap_form_id(arg0: &FormOwnerCap) : 0x2::object::ID {
        arg0.form_id
    }

    entry fun reopen_form(arg0: &mut Form, arg1: &FormOwnerCap, arg2: &0x2::tx_context::TxContext) {
        verify_owner_cap(arg1, arg0);
        assert!(arg0.is_closed, 11);
        arg0.is_closed = false;
        let v0 = FormReopened{
            form_id     : 0x2::object::uid_to_inner(&arg0.id),
            reopened_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FormReopened>(v0);
    }

    public fun schema_blob_id(arg0: &Form) : vector<u8> {
        arg0.schema_blob_id
    }

    public fun schema_version(arg0: &Form) : u64 {
        arg0.schema_version
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun submission_identity_mode(arg0: &Form) : u8 {
        arg0.submission_identity_mode
    }

    entry fun update_identity_mode(arg0: &mut Form, arg1: &FormOwnerCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        verify_owner_cap(arg1, arg0);
        validate_identity_mode(arg2);
        arg0.submission_identity_mode = arg2;
        let v0 = FormIdentityModeUpdated{
            form_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_mode   : arg0.submission_identity_mode,
            new_mode   : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FormIdentityModeUpdated>(v0);
    }

    entry fun update_schema(arg0: &mut Form, arg1: &FormOwnerCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_owner_cap(arg1, arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        let v0 = arg0.schema_blob_id;
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        arg0.schema_version = arg0.schema_version + 1;
        arg0.schema_blob_id = arg2;
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::schema_version::create(v1, arg2, arg0.schema_version, 0x1::option::some<vector<u8>>(v0), 0x2::tx_context::sender(arg3), arg3);
        let v2 = SchemaUpdated{
            form_id     : v1,
            old_blob_id : v0,
            new_blob_id : arg2,
            new_version : arg0.schema_version,
            updater     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SchemaUpdated>(v2);
    }

    fun validate_identity_mode(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 12);
    }

    public(friend) fun verify_cap(arg0: &FormOwnerCap, arg1: &Form) {
        verify_owner_cap(arg0, arg1);
    }

    fun verify_owner_cap(arg0: &FormOwnerCap, arg1: &Form) {
        assert!(arg0.form_id == 0x2::object::uid_to_inner(&arg1.id), 2);
    }

    // decompiled from Move bytecode v6
}

