module 0x46dc02eeebe13b31ed3ddb2ec0a02e080b053402746f01f590671932d922a7b3::form {
    struct Form has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        form_type: 0x1::string::String,
        version: u64,
        config_blob_id: vector<u8>,
        submissions_index_blob_id: 0x1::option::Option<vector<u8>>,
        annotations_blob_id: 0x1::option::Option<vector<u8>>,
        last_index_updated: u64,
        admin_list: vector<address>,
        is_active: bool,
        submission_count: u64,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        form_type: 0x1::string::String,
        config_blob_id: vector<u8>,
        created_at: u64,
    }

    struct FormToggled has copy, drop {
        form_id: 0x2::object::ID,
        is_active: bool,
    }

    struct FormConfigUpdated has copy, drop {
        form_id: 0x2::object::ID,
        new_blob_id: vector<u8>,
        new_version: u64,
    }

    struct SubmissionsIndexUpdated has copy, drop {
        form_id: 0x2::object::ID,
        index_blob_id: vector<u8>,
        updated_at: u64,
    }

    struct AnnotationsBlobUpdated has copy, drop {
        form_id: 0x2::object::ID,
        blob_id: vector<u8>,
    }

    struct AdminGranted has copy, drop {
        form_id: 0x2::object::ID,
        admin_address: address,
    }

    struct SubmissionRecorded has copy, drop {
        form_id: 0x2::object::ID,
        submission_count: u64,
    }

    public fun admin_list(arg0: &Form) : &vector<address> {
        &arg0.admin_list
    }

    public fun annotations_blob_id(arg0: &Form) : &0x1::option::Option<vector<u8>> {
        &arg0.annotations_blob_id
    }

    public fun cap_form_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.form_id
    }

    public fun config_blob_id(arg0: &Form) : &vector<u8> {
        &arg0.config_blob_id
    }

    public fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::string::is_empty(&arg0), 0);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = vector[];
        0x1::vector::push_back<address>(&mut v4, v0);
        let v5 = Form{
            id                        : v1,
            owner                     : v0,
            title                     : arg0,
            description               : arg1,
            form_type                 : arg2,
            version                   : 0,
            config_blob_id            : arg3,
            submissions_index_blob_id : 0x1::option::none<vector<u8>>(),
            annotations_blob_id       : 0x1::option::none<vector<u8>>(),
            last_index_updated        : 0,
            admin_list                : v4,
            is_active                 : true,
            submission_count          : 0,
            created_at                : v3,
        };
        let v6 = AdminCap{
            id      : 0x2::object::new(arg5),
            form_id : v2,
        };
        let v7 = FormCreated{
            form_id        : v2,
            owner          : v0,
            form_type      : v5.form_type,
            config_blob_id : v5.config_blob_id,
            created_at     : v3,
        };
        0x2::event::emit<FormCreated>(v7);
        0x2::transfer::transfer<Form>(v5, v0);
        0x2::transfer::transfer<AdminCap>(v6, v0);
    }

    public fun grant_admin(arg0: &mut Form, arg1: &AdminCap, arg2: address) {
        assert!(arg1.form_id == 0x2::object::id<Form>(arg0), 2);
        assert!(!0x1::vector::contains<address>(&arg0.admin_list, &arg2), 3);
        0x1::vector::push_back<address>(&mut arg0.admin_list, arg2);
        let v0 = AdminGranted{
            form_id       : 0x2::object::id<Form>(arg0),
            admin_address : arg2,
        };
        0x2::event::emit<AdminGranted>(v0);
    }

    public fun is_active(arg0: &Form) : bool {
        arg0.is_active
    }

    public fun is_admin(arg0: &Form, arg1: address) : bool {
        arg1 == arg0.owner || 0x1::vector::contains<address>(&arg0.admin_list, &arg1)
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun record_submission(arg0: &mut Form, arg1: &AdminCap) {
        assert!(arg1.form_id == 0x2::object::id<Form>(arg0), 2);
        assert!(arg0.is_active, 4);
        arg0.submission_count = arg0.submission_count + 1;
        let v0 = SubmissionRecorded{
            form_id          : 0x2::object::id<Form>(arg0),
            submission_count : arg0.submission_count,
        };
        0x2::event::emit<SubmissionRecorded>(v0);
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun submissions_index_blob_id(arg0: &Form) : &0x1::option::Option<vector<u8>> {
        &arg0.submissions_index_blob_id
    }

    public fun toggle_active(arg0: &mut Form, arg1: &AdminCap) {
        assert!(arg1.form_id == 0x2::object::id<Form>(arg0), 2);
        arg0.is_active = !arg0.is_active;
        let v0 = FormToggled{
            form_id   : 0x2::object::id<Form>(arg0),
            is_active : arg0.is_active,
        };
        0x2::event::emit<FormToggled>(v0);
    }

    public fun update_annotations_blob(arg0: &mut Form, arg1: &AdminCap, arg2: vector<u8>) {
        assert!(arg1.form_id == 0x2::object::id<Form>(arg0), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 1);
        arg0.annotations_blob_id = 0x1::option::some<vector<u8>>(arg2);
        let v0 = AnnotationsBlobUpdated{
            form_id : 0x2::object::id<Form>(arg0),
            blob_id : *0x1::option::borrow<vector<u8>>(&arg0.annotations_blob_id),
        };
        0x2::event::emit<AnnotationsBlobUpdated>(v0);
    }

    public fun update_config_blob(arg0: &mut Form, arg1: &AdminCap, arg2: vector<u8>) {
        assert!(arg1.form_id == 0x2::object::id<Form>(arg0), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 1);
        arg0.config_blob_id = arg2;
        arg0.version = arg0.version + 1;
        let v0 = FormConfigUpdated{
            form_id     : 0x2::object::id<Form>(arg0),
            new_blob_id : arg0.config_blob_id,
            new_version : arg0.version,
        };
        0x2::event::emit<FormConfigUpdated>(v0);
    }

    public fun update_submissions_index(arg0: &mut Form, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(arg1.form_id == 0x2::object::id<Form>(arg0), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.submissions_index_blob_id = 0x1::option::some<vector<u8>>(arg2);
        arg0.last_index_updated = v0;
        let v1 = SubmissionsIndexUpdated{
            form_id       : 0x2::object::id<Form>(arg0),
            index_blob_id : *0x1::option::borrow<vector<u8>>(&arg0.submissions_index_blob_id),
            updated_at    : v0,
        };
        0x2::event::emit<SubmissionsIndexUpdated>(v1);
    }

    public fun version(arg0: &Form) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

