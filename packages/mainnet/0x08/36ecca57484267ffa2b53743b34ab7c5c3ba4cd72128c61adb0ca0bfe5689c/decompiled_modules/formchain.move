module 0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain {
    struct FormRegistry has key {
        id: 0x2::object::UID,
        total_forms: u64,
        total_responses: u64,
    }

    struct Form has key {
        id: 0x2::object::UID,
        config_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
        seal_encrypted: bool,
        seal_policy_id: 0x1::option::Option<0x1::string::String>,
        published: bool,
        paused: bool,
        created_at: u64,
        updated_at: u64,
        response_count: u64,
        responses: vector<ResponseRecord>,
    }

    struct ResponseRecord has copy, drop, store {
        index: u64,
        blob_id: 0x1::string::String,
        submitter: address,
        submitted_at: u64,
        priority: u8,
        note: 0x1::string::String,
    }

    struct FormOwnerCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        owner: address,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        config_blob_id: 0x1::string::String,
        seal_encrypted: bool,
        timestamp: u64,
    }

    struct FormPublished has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct FormPaused has copy, drop {
        form_id: 0x2::object::ID,
        paused: bool,
        timestamp: u64,
    }

    struct FormDeleted has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct FormConfigUpdated has copy, drop {
        form_id: 0x2::object::ID,
        new_blob_id: 0x1::string::String,
        timestamp: u64,
    }

    struct ResponseSubmitted has copy, drop {
        form_id: 0x2::object::ID,
        response_index: u64,
        blob_id: 0x1::string::String,
        submitter: address,
        seal_encrypted: bool,
        timestamp: u64,
    }

    struct ResponseAnnotated has copy, drop {
        form_id: 0x2::object::ID,
        response_index: u64,
        priority: u8,
        timestamp: u64,
    }

    public entry fun annotate_response(arg0: &FormOwnerCap, arg1: &mut Form, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg6);
        assert!(arg3 <= 3, 9);
        assert!(arg2 < arg1.response_count, 10);
        let v0 = 0x1::string::utf8(arg4);
        assert!(0x1::string::length(&v0) <= 1000, 8);
        let v1 = 0x1::vector::borrow_mut<ResponseRecord>(&mut arg1.responses, arg2);
        v1.priority = arg3;
        v1.note = v0;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v2 = ResponseAnnotated{
            form_id        : 0x2::object::id<Form>(arg1),
            response_index : arg2,
            priority       : arg3,
            timestamp      : arg1.updated_at,
        };
        0x2::event::emit<ResponseAnnotated>(v2);
    }

    fun assert_owner(arg0: &FormOwnerCap, arg1: &Form, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 1);
    }

    public fun cap_form_id(arg0: &FormOwnerCap) : 0x2::object::ID {
        arg0.form_id
    }

    public fun cap_owner(arg0: &FormOwnerCap) : address {
        arg0.owner
    }

    public entry fun create_form(arg0: &mut FormRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x1::string::utf8(arg3);
        let v2 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) <= 120, 4);
        assert!(0x1::string::length(&v1) <= 500, 5);
        assert!(0x1::string::length(&v2) > 0, 6);
        assert!(0x1::string::length(&v2) <= 128, 7);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        let v5 = if (arg4 && !0x1::vector::is_empty<u8>(&arg5)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg5))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v6 = 0x2::object::new(arg7);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = Form{
            id             : v6,
            config_blob_id : v2,
            title          : v0,
            description    : v1,
            owner          : v3,
            seal_encrypted : arg4,
            seal_policy_id : v5,
            published      : false,
            paused         : false,
            created_at     : v4,
            updated_at     : v4,
            response_count : 0,
            responses      : 0x1::vector::empty<ResponseRecord>(),
        };
        let v9 = FormOwnerCap{
            id      : 0x2::object::new(arg7),
            form_id : v7,
            owner   : v3,
        };
        arg0.total_forms = arg0.total_forms + 1;
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v3)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.id, v3), v7);
        } else {
            let v10 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v7);
            0x2::dynamic_field::add<address, vector<0x2::object::ID>>(&mut arg0.id, v3, v10);
        };
        let v11 = FormCreated{
            form_id        : v7,
            owner          : v3,
            config_blob_id : v2,
            seal_encrypted : arg4,
            timestamp      : v4,
        };
        0x2::event::emit<FormCreated>(v11);
        0x2::transfer::share_object<Form>(v8);
        0x2::transfer::transfer<FormOwnerCap>(v9, v3);
    }

    public entry fun delete_form(arg0: FormOwnerCap, arg1: Form, arg2: &mut FormRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.form_id == 0x2::object::id<Form>(&arg1), 1);
        let v0 = 0x2::object::id<Form>(&arg1);
        let v1 = arg1.owner;
        if (0x2::dynamic_field::exists_<address>(&arg2.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.id, v1);
            let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(v2, &v0);
            if (v3) {
                0x1::vector::remove<0x2::object::ID>(v2, v4);
            };
        };
        if (arg2.total_forms > 0) {
            arg2.total_forms = arg2.total_forms - 1;
        };
        let v5 = FormDeleted{
            form_id   : v0,
            owner     : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FormDeleted>(v5);
        let FormOwnerCap {
            id      : v6,
            form_id : _,
            owner   : _,
        } = arg0;
        0x2::object::delete(v6);
        let Form {
            id             : v9,
            config_blob_id : _,
            title          : _,
            description    : _,
            owner          : _,
            seal_encrypted : _,
            seal_policy_id : _,
            published      : _,
            paused         : _,
            created_at     : _,
            updated_at     : _,
            response_count : _,
            responses      : _,
        } = arg1;
        0x2::object::delete(v9);
    }

    public fun get_form_info(arg0: &Form) : (0x1::string::String, 0x1::string::String, address, bool, bool, bool, u64, u64) {
        (arg0.title, arg0.config_blob_id, arg0.owner, arg0.seal_encrypted, arg0.published, arg0.paused, arg0.response_count, arg0.created_at)
    }

    public fun get_owner_forms(arg0: &FormRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<address, vector<0x2::object::ID>>(&arg0.id, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_response_blob(arg0: &Form, arg1: u64) : (0x1::string::String, address, u64, u8, 0x1::string::String) {
        assert!(arg1 < arg0.response_count, 10);
        let v0 = 0x1::vector::borrow<ResponseRecord>(&arg0.responses, arg1);
        (v0.blob_id, v0.submitter, v0.submitted_at, v0.priority, v0.note)
    }

    public fun get_responses(arg0: &Form) : &vector<ResponseRecord> {
        &arg0.responses
    }

    public fun get_seal_policy(arg0: &Form) : 0x1::option::Option<0x1::string::String> {
        arg0.seal_policy_id
    }

    public fun get_stats(arg0: &FormRegistry) : (u64, u64) {
        (arg0.total_forms, arg0.total_responses)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FormRegistry{
            id              : 0x2::object::new(arg0),
            total_forms     : 0,
            total_responses : 0,
        };
        0x2::transfer::share_object<FormRegistry>(v0);
    }

    public entry fun publish_form(arg0: &FormOwnerCap, arg1: &mut Form, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(!arg1.published, 11);
        arg1.published = true;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = FormPublished{
            form_id   : 0x2::object::id<Form>(arg1),
            owner     : arg1.owner,
            timestamp : arg1.updated_at,
        };
        0x2::event::emit<FormPublished>(v0);
    }

    public fun record_blob_id(arg0: &ResponseRecord) : 0x1::string::String {
        arg0.blob_id
    }

    public fun record_index(arg0: &ResponseRecord) : u64 {
        arg0.index
    }

    public fun record_note(arg0: &ResponseRecord) : 0x1::string::String {
        arg0.note
    }

    public fun record_priority(arg0: &ResponseRecord) : u8 {
        arg0.priority
    }

    public fun record_submitter(arg0: &ResponseRecord) : address {
        arg0.submitter
    }

    public entry fun set_paused(arg0: &FormOwnerCap, arg1: &mut Form, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg4);
        arg1.paused = arg2;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = FormPaused{
            form_id   : 0x2::object::id<Form>(arg1),
            paused    : arg2,
            timestamp : arg1.updated_at,
        };
        0x2::event::emit<FormPaused>(v0);
    }

    public entry fun submit_response(arg0: &mut Form, arg1: &mut FormRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.published, 2);
        assert!(!arg0.paused, 3);
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x1::string::length(&v0) > 0, 6);
        assert!(0x1::string::length(&v0) <= 128, 7);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = arg0.response_count;
        let v4 = ResponseRecord{
            index        : v3,
            blob_id      : v0,
            submitter    : v1,
            submitted_at : v2,
            priority     : 0,
            note         : 0x1::string::utf8(b""),
        };
        0x1::vector::push_back<ResponseRecord>(&mut arg0.responses, v4);
        arg0.response_count = arg0.response_count + 1;
        arg1.total_responses = arg1.total_responses + 1;
        let v5 = ResponseSubmitted{
            form_id        : 0x2::object::id<Form>(arg0),
            response_index : v3,
            blob_id        : v0,
            submitter      : v1,
            seal_encrypted : arg0.seal_encrypted,
            timestamp      : v2,
        };
        0x2::event::emit<ResponseSubmitted>(v5);
    }

    public entry fun update_config(arg0: &FormOwnerCap, arg1: &mut Form, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg6);
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x1::string::utf8(arg3);
        let v2 = 0x1::string::utf8(arg4);
        assert!(0x1::string::length(&v0) > 0, 6);
        assert!(0x1::string::length(&v0) <= 128, 7);
        assert!(0x1::string::length(&v1) <= 120, 4);
        assert!(0x1::string::length(&v2) <= 500, 5);
        arg1.config_blob_id = v0;
        arg1.title = v1;
        arg1.description = v2;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v3 = FormConfigUpdated{
            form_id     : 0x2::object::id<Form>(arg1),
            new_blob_id : v0,
            timestamp   : arg1.updated_at,
        };
        0x2::event::emit<FormConfigUpdated>(v3);
    }

    // decompiled from Move bytecode v7
}

