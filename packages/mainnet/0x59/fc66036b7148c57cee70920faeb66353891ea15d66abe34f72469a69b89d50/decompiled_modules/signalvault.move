module 0x59fc66036b7148c57cee70920faeb66353891ea15d66abe34f72469a69b89d50::signalvault {
    struct FormPolicy has store, key {
        id: 0x2::object::UID,
        form_uid: vector<u8>,
        owner: address,
        schema_blob_id: 0x1::string::String,
        admins: vector<address>,
        created_at_ms: u64,
        updated_at_ms: u64,
        active: bool,
        response_count: u64,
    }

    struct FormCreated has copy, drop {
        policy_id: 0x2::object::ID,
        form_uid: vector<u8>,
        owner: address,
        schema_blob_id: 0x1::string::String,
        created_at_ms: u64,
    }

    struct FormUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        new_schema_blob_id: 0x1::string::String,
        updated_at_ms: u64,
    }

    struct FormArchived has copy, drop {
        policy_id: 0x2::object::ID,
        archived_by: address,
    }

    struct AdminAdded has copy, drop {
        policy_id: 0x2::object::ID,
        admin: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        policy_id: 0x2::object::ID,
        admin: address,
        removed_by: address,
    }

    struct ResponseRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        response_blob_id: 0x1::string::String,
        response_hash: vector<u8>,
        submitter: address,
        timestamp_ms: u64,
        sequence: u64,
    }

    public fun add_admin(arg0: &mut FormPolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAdded{
            policy_id : 0x2::object::id<FormPolicy>(arg0),
            admin     : arg1,
            added_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun admins(arg0: &FormPolicy) : &vector<address> {
        &arg0.admins
    }

    public fun archive_form(arg0: &mut FormPolicy, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.active = false;
        let v0 = FormArchived{
            policy_id   : 0x2::object::id<FormPolicy>(arg0),
            archived_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<FormArchived>(v0);
    }

    fun assert_owner(arg0: &FormPolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    public fun create_form(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = FormPolicy{
            id             : 0x2::object::new(arg3),
            form_uid       : arg0,
            owner          : v0,
            schema_blob_id : 0x1::string::utf8(arg1),
            admins         : 0x1::vector::empty<address>(),
            created_at_ms  : v1,
            updated_at_ms  : v1,
            active         : true,
            response_count : 0,
        };
        let v3 = FormCreated{
            policy_id      : 0x2::object::id<FormPolicy>(&v2),
            form_uid       : v2.form_uid,
            owner          : v0,
            schema_blob_id : v2.schema_blob_id,
            created_at_ms  : v1,
        };
        0x2::event::emit<FormCreated>(v3);
        0x2::transfer::share_object<FormPolicy>(v2);
    }

    public fun form_uid(arg0: &FormPolicy) : &vector<u8> {
        &arg0.form_uid
    }

    fun index_of(arg0: &vector<address>, arg1: &address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun is_active(arg0: &FormPolicy) : bool {
        arg0.active
    }

    public fun is_authorized(arg0: &FormPolicy, arg1: address) : bool {
        arg1 == arg0.owner || 0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun owner(arg0: &FormPolicy) : address {
        arg0.owner
    }

    public fun reactivate_form(arg0: &mut FormPolicy, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.active = true;
    }

    public fun record_response(arg0: &mut FormPolicy, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        let v0 = arg0.response_count + 1;
        arg0.response_count = v0;
        let v1 = ResponseRecorded{
            policy_id        : 0x2::object::id<FormPolicy>(arg0),
            response_blob_id : 0x1::string::utf8(arg1),
            response_hash    : arg2,
            submitter        : 0x2::tx_context::sender(arg4),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
            sequence         : v0,
        };
        0x2::event::emit<ResponseRecorded>(v1);
    }

    public fun remove_admin(arg0: &mut FormPolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let (v0, v1) = index_of(&arg0.admins, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        let v2 = AdminRemoved{
            policy_id  : 0x2::object::id<FormPolicy>(arg0),
            admin      : arg1,
            removed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminRemoved>(v2);
    }

    public fun response_count(arg0: &FormPolicy) : u64 {
        arg0.response_count
    }

    public fun schema_blob_id(arg0: &FormPolicy) : 0x1::string::String {
        arg0.schema_blob_id
    }

    public fun update_schema(arg0: &mut FormPolicy, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        arg0.schema_blob_id = 0x1::string::utf8(arg1);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = FormUpdated{
            policy_id          : 0x2::object::id<FormPolicy>(arg0),
            new_schema_blob_id : arg0.schema_blob_id,
            updated_at_ms      : arg0.updated_at_ms,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

