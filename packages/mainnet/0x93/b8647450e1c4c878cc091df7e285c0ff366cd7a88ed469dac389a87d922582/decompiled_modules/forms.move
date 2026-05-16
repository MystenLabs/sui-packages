module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms {
    struct Form has store, key {
        id: 0x2::object::UID,
        creator: address,
        session_id: 0x1::option::Option<0x2::object::ID>,
        schema_blob_id: u256,
        title: 0x1::string::String,
        auth_modes: u8,
        require_nft_type: 0x1::option::Option<0x1::string::String>,
        require_token_type: 0x1::option::Option<0x1::string::String>,
        require_token_amount: u64,
        encrypted: bool,
        time_lock_unlock_at: u64,
        allowlist_id: 0x1::option::Option<0x2::object::ID>,
        issues_attendance_nft: bool,
        is_listed: bool,
        submission_count: u64,
        closed: bool,
        created_at: u64,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        session_id: 0x1::option::Option<0x2::object::ID>,
        creator: address,
        is_listed: bool,
    }

    struct FormUpdated has copy, drop {
        form_id: 0x2::object::ID,
    }

    struct FormClosed has copy, drop {
        form_id: 0x2::object::ID,
    }

    struct FormReopened has copy, drop {
        form_id: 0x2::object::ID,
    }

    struct FormListedChanged has copy, drop {
        form_id: 0x2::object::ID,
        is_listed: bool,
    }

    public fun allowlist_id(arg0: &Form) : &0x1::option::Option<0x2::object::ID> {
        &arg0.allowlist_id
    }

    public fun assert_admin(arg0: &Form, arg1: address) {
        assert!(arg1 == arg0.creator, 1);
    }

    public fun assert_open(arg0: &Form) {
        assert!(!arg0.closed, 2);
    }

    public fun auth_modes(arg0: &Form) : u8 {
        arg0.auth_modes
    }

    public fun auth_wallet_bit() : u8 {
        1
    }

    public fun auth_zklogin_bit() : u8 {
        2
    }

    fun build_form(arg0: 0x1::option::Option<0x2::object::ID>, arg1: u256, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: u64, arg7: bool, arg8: u64, arg9: 0x1::option::Option<0x2::object::ID>, arg10: bool, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : Form {
        let v0 = Form{
            id                    : 0x2::object::new(arg13),
            creator               : 0x2::tx_context::sender(arg13),
            session_id            : arg0,
            schema_blob_id        : arg1,
            title                 : arg2,
            auth_modes            : arg3,
            require_nft_type      : arg4,
            require_token_type    : arg5,
            require_token_amount  : arg6,
            encrypted             : arg7,
            time_lock_unlock_at   : arg8,
            allowlist_id          : arg9,
            issues_attendance_nft : arg10,
            is_listed             : arg11,
            submission_count      : 0,
            closed                : false,
            created_at            : 0x2::clock::timestamp_ms(arg12),
        };
        let v1 = FormCreated{
            form_id    : 0x2::object::id<Form>(&v0),
            session_id : arg0,
            creator    : 0x2::tx_context::sender(arg13),
            is_listed  : arg11,
        };
        0x2::event::emit<FormCreated>(v1);
        v0
    }

    public fun close(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        arg0.closed = true;
        let v0 = FormClosed{form_id: 0x2::object::id<Form>(arg0)};
        0x2::event::emit<FormClosed>(v0);
    }

    public fun create_in_session(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: u256, arg2: 0x1::string::String, arg3: u8, arg4: bool, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg10));
        assert!(!0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::is_archived(arg0), 3);
        let v0 = build_form(0x1::option::some<0x2::object::ID>(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0)), arg1, arg2, arg3, 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), 0, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::attach_form(arg0, 0x2::object::id<Form>(&v0));
        0x2::transfer::share_object<Form>(v0);
    }

    public fun create_in_session_with_nft<T0: key>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: &T0, arg2: 0x1::string::String, arg3: u256, arg4: 0x1::string::String, arg5: u8, arg6: bool, arg7: u64, arg8: 0x1::option::Option<0x2::object::ID>, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg12));
        assert!(!0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::is_archived(arg0), 3);
        let v0 = build_form(0x1::option::some<0x2::object::ID>(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0)), arg3, arg4, arg5, 0x1::option::some<0x1::string::String>(arg2), 0x1::option::none<0x1::string::String>(), 0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::attach_form(arg0, 0x2::object::id<Form>(&v0));
        0x2::transfer::share_object<Form>(v0);
    }

    public fun create_in_session_with_token<T0>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u64, arg4: u256, arg5: 0x1::string::String, arg6: u8, arg7: bool, arg8: u64, arg9: 0x1::option::Option<0x2::object::ID>, arg10: bool, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg13));
        assert!(!0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::is_archived(arg0), 3);
        assert!(0x2::coin::value<T0>(arg1) >= arg3, 5);
        let v0 = build_form(0x1::option::some<0x2::object::ID>(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0)), arg4, arg5, arg6, 0x1::option::none<0x1::string::String>(), 0x1::option::some<0x1::string::String>(arg2), arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::attach_form(arg0, 0x2::object::id<Form>(&v0));
        0x2::transfer::share_object<Form>(v0);
    }

    public fun create_standalone(arg0: u256, arg1: 0x1::string::String, arg2: u8, arg3: bool, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Form>(build_form(0x1::option::none<0x2::object::ID>(), arg0, arg1, arg2, 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), 0, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun create_standalone_with_nft<T0: key>(arg0: &T0, arg1: 0x1::string::String, arg2: u256, arg3: 0x1::string::String, arg4: u8, arg5: bool, arg6: u64, arg7: 0x1::option::Option<0x2::object::ID>, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Form>(build_form(0x1::option::none<0x2::object::ID>(), arg2, arg3, arg4, 0x1::option::some<0x1::string::String>(arg1), 0x1::option::none<0x1::string::String>(), 0, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun create_standalone_with_token<T0>(arg0: &0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u256, arg4: 0x1::string::String, arg5: u8, arg6: bool, arg7: u64, arg8: 0x1::option::Option<0x2::object::ID>, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 5);
        0x2::transfer::share_object<Form>(build_form(0x1::option::none<0x2::object::ID>(), arg3, arg4, arg5, 0x1::option::none<0x1::string::String>(), 0x1::option::some<0x1::string::String>(arg1), arg2, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    public fun creator(arg0: &Form) : address {
        arg0.creator
    }

    public fun encrypted(arg0: &Form) : bool {
        arg0.encrypted
    }

    public fun is_closed(arg0: &Form) : bool {
        arg0.closed
    }

    public fun is_listed(arg0: &Form) : bool {
        arg0.is_listed
    }

    public fun issues_attendance_nft(arg0: &Form) : bool {
        arg0.issues_attendance_nft
    }

    public(friend) fun record_submission(arg0: &mut Form) {
        arg0.submission_count = arg0.submission_count + 1;
    }

    public fun reopen(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        arg0.closed = false;
        let v0 = FormReopened{form_id: 0x2::object::id<Form>(arg0)};
        0x2::event::emit<FormReopened>(v0);
    }

    public fun require_nft_type(arg0: &Form) : &0x1::option::Option<0x1::string::String> {
        &arg0.require_nft_type
    }

    public fun require_token_amount(arg0: &Form) : u64 {
        arg0.require_token_amount
    }

    public fun require_token_type(arg0: &Form) : &0x1::option::Option<0x1::string::String> {
        &arg0.require_token_type
    }

    public fun schema_blob_id(arg0: &Form) : u256 {
        arg0.schema_blob_id
    }

    public fun session_id(arg0: &Form) : &0x1::option::Option<0x2::object::ID> {
        &arg0.session_id
    }

    public fun set_listed(arg0: &mut Form, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        arg0.is_listed = arg1;
        let v0 = FormListedChanged{
            form_id   : 0x2::object::id<Form>(arg0),
            is_listed : arg1,
        };
        0x2::event::emit<FormListedChanged>(v0);
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun time_lock_unlock_at(arg0: &Form) : u64 {
        arg0.time_lock_unlock_at
    }

    public fun title(arg0: &Form) : &0x1::string::String {
        &arg0.title
    }

    public fun update_schema(arg0: &mut Form, arg1: u256, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 0);
        arg0.schema_blob_id = arg1;
        arg0.title = arg2;
        let v0 = FormUpdated{form_id: 0x2::object::id<Form>(arg0)};
        0x2::event::emit<FormUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

