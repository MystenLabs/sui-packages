module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry {
    struct WF has drop {
        dummy_field: bool,
    }

    struct Form has key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        policy_type: u8,
        policy_object_id: vector<u8>,
        unlock_time_ms: u64,
        submission_count: u64,
        open: bool,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        schema_blob_id: 0x1::string::String,
        policy_type: u8,
    }

    struct FormUpdated has copy, drop {
        form_id: 0x2::object::ID,
        schema_blob_id: 0x1::string::String,
    }

    struct FormClosed has copy, drop {
        form_id: 0x2::object::ID,
    }

    fun build_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Form {
        let v0 = Form{
            id               : 0x2::object::new(arg5),
            owner            : 0x2::tx_context::sender(arg5),
            title            : arg0,
            schema_blob_id   : arg1,
            policy_type      : arg2,
            policy_object_id : arg3,
            unlock_time_ms   : arg4,
            submission_count : 0,
            open             : true,
        };
        let v1 = FormCreated{
            form_id        : 0x2::object::id<Form>(&v0),
            owner          : v0.owner,
            schema_blob_id : v0.schema_blob_id,
            policy_type    : arg2,
        };
        0x2::event::emit<FormCreated>(v1);
        v0
    }

    public fun close_form(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.open = false;
        let v0 = FormClosed{form_id: 0x2::object::id<Form>(arg0)};
        0x2::event::emit<FormClosed>(v0);
    }

    public fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Form>(build_form(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun create_form_group(arg0: &mut 0x2::tx_context::TxContext) : 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WF> {
        let v0 = WF{dummy_field: false};
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::new<WF>(v0, arg0)
    }

    public fun create_form_with_allowlist(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::seal_policies::Allowlist, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Form>(build_form(arg0, arg1, 1, 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::seal_policies::allowlist_id_bytes(&arg2), 0, arg3));
        0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::seal_policies::share_allowlist(arg2);
    }

    public(friend) fun increment_submission_count(arg0: &mut Form) {
        arg0.submission_count = arg0.submission_count + 1;
    }

    public fun is_open(arg0: &Form) : bool {
        arg0.open
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun policy_allowlist() : u8 {
        1
    }

    public fun policy_object_id(arg0: &Form) : vector<u8> {
        arg0.policy_object_id
    }

    public fun policy_public() : u8 {
        0
    }

    public fun policy_timelock() : u8 {
        2
    }

    public fun policy_token_gated() : u8 {
        3
    }

    public fun policy_type(arg0: &Form) : u8 {
        arg0.policy_type
    }

    public fun schema_blob_id(arg0: &Form) : 0x1::string::String {
        arg0.schema_blob_id
    }

    public fun unlock_time_ms(arg0: &Form) : u64 {
        arg0.unlock_time_ms
    }

    public fun update_form(arg0: &mut Form, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        arg0.title = arg1;
        arg0.schema_blob_id = arg2;
        let v0 = FormUpdated{
            form_id        : 0x2::object::id<Form>(arg0),
            schema_blob_id : arg2,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

