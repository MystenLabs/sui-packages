module 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form {
    struct Form has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        schema_blob: 0x1::string::String,
        schema_version: u32,
        encryption_policy: u8,
        close_at_ms: u64,
        submission_count: u64,
        is_open: bool,
        created_at_ms: u64,
    }

    struct FormAdminCap has store, key {
        id: 0x2::object::UID,
        form: 0x2::object::ID,
    }

    struct FormCreated has copy, drop {
        form: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        schema_blob: 0x1::string::String,
        encryption_policy: u8,
        close_at_ms: u64,
    }

    struct FormSchemaUpdated has copy, drop {
        form: 0x2::object::ID,
        new_blob: 0x1::string::String,
        new_version: u32,
    }

    struct FormClosed has copy, drop {
        form: 0x2::object::ID,
    }

    struct FormReopened has copy, drop {
        form: 0x2::object::ID,
    }

    public fun admin_cap_form(arg0: &FormAdminCap) : 0x2::object::ID {
        arg0.form
    }

    public entry fun close(arg0: &mut Form, arg1: &FormAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Form>(arg0) == arg1.form, 1);
        assert!(arg0.is_open, 3);
        arg0.is_open = false;
        let v0 = FormClosed{form: 0x2::object::id<Form>(arg0)};
        0x2::event::emit<FormClosed>(v0);
    }

    public fun close_at_ms(arg0: &Form) : u64 {
        arg0.close_at_ms
    }

    public entry fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2 == 2) {
            assert!(arg3 > v0, 4);
        };
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Form{
            id                : 0x2::object::new(arg5),
            creator           : v1,
            title             : arg0,
            schema_blob       : arg1,
            schema_version    : 1,
            encryption_policy : arg2,
            close_at_ms       : arg3,
            submission_count  : 0,
            is_open           : true,
            created_at_ms     : v0,
        };
        let v3 = 0x2::object::id<Form>(&v2);
        let v4 = FormAdminCap{
            id   : 0x2::object::new(arg5),
            form : v3,
        };
        let v5 = FormCreated{
            form              : v3,
            creator           : v1,
            title             : arg0,
            schema_blob       : arg1,
            encryption_policy : arg2,
            close_at_ms       : arg3,
        };
        0x2::event::emit<FormCreated>(v5);
        0x2::transfer::share_object<Form>(v2);
        0x2::transfer::public_transfer<FormAdminCap>(v4, v1);
    }

    public fun creator(arg0: &Form) : address {
        arg0.creator
    }

    public fun encryption_policy(arg0: &Form) : u8 {
        arg0.encryption_policy
    }

    public(friend) fun inc_submission_count(arg0: &mut Form) {
        arg0.submission_count = arg0.submission_count + 1;
    }

    public fun is_open(arg0: &Form) : bool {
        arg0.is_open
    }

    public fun policy_none() : u8 {
        0
    }

    public fun policy_owner_only() : u8 {
        1
    }

    public fun policy_timelock() : u8 {
        2
    }

    public entry fun reopen(arg0: &mut Form, arg1: &FormAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Form>(arg0) == arg1.form, 1);
        arg0.is_open = true;
        let v0 = FormReopened{form: 0x2::object::id<Form>(arg0)};
        0x2::event::emit<FormReopened>(v0);
    }

    public fun schema_blob(arg0: &Form) : 0x1::string::String {
        arg0.schema_blob
    }

    public fun schema_version(arg0: &Form) : u32 {
        arg0.schema_version
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun title(arg0: &Form) : 0x1::string::String {
        arg0.title
    }

    public entry fun update_schema(arg0: &mut Form, arg1: &FormAdminCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Form>(arg0) == arg1.form, 1);
        arg0.schema_blob = arg2;
        arg0.schema_version = arg0.schema_version + 1;
        let v0 = FormSchemaUpdated{
            form        : 0x2::object::id<Form>(arg0),
            new_blob    : arg0.schema_blob,
            new_version : arg0.schema_version,
        };
        0x2::event::emit<FormSchemaUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

