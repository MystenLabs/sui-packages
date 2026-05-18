module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access {
    struct AccessPolicyCreated has copy, drop {
        form_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        has_response_limit: bool,
        response_limit: u64,
        has_opens_at: bool,
        has_closes_at: bool,
        has_password: bool,
        created_by: address,
    }

    struct AccessPolicyUpdated has copy, drop {
        form_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        updated_by: address,
    }

    struct AllowlistEntryAdded has copy, drop {
        form_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        allowed_address: address,
        added_by: address,
    }

    struct AllowlistEntryRemoved has copy, drop {
        form_id: 0x2::object::ID,
        entry_id: 0x2::object::ID,
        allowed_address: address,
        removed_by: address,
    }

    struct FormAccessPolicy has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        requires_allowlist: bool,
        has_response_limit: bool,
        response_limit: u64,
        opens_at: 0x1::option::Option<u64>,
        closes_at: 0x1::option::Option<u64>,
        password_hash: 0x1::option::Option<vector<u8>>,
    }

    struct AllowlistEntry has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        allowed_address: address,
        added_at: u64,
    }

    entry fun add_to_allowlist(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg1);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = AllowlistEntry{
            id              : 0x2::object::new(arg3),
            form_id         : v0,
            allowed_address : arg2,
            added_at        : 0x2::tx_context::epoch(arg3),
        };
        let v3 = AllowlistEntryAdded{
            form_id         : v0,
            entry_id        : 0x2::object::uid_to_inner(&v2.id),
            allowed_address : arg2,
            added_by        : v1,
        };
        0x2::event::emit<AllowlistEntryAdded>(v3);
        0x2::transfer::transfer<AllowlistEntry>(v2, v1);
    }

    public fun added_at(arg0: &AllowlistEntry) : u64 {
        arg0.added_at
    }

    public fun allowed_address(arg0: &AllowlistEntry) : address {
        arg0.allowed_address
    }

    entry fun check_and_enforce_response_limit(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &FormAccessPolicy, arg2: &mut 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg3: &0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg2);
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg2), 23);
        if (arg1.has_response_limit && 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::submission_count(arg2) >= arg1.response_limit) {
            0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::close_form_internal(arg2, 0x2::tx_context::sender(arg3));
        };
    }

    public fun closes_at(arg0: &FormAccessPolicy) : 0x1::option::Option<u64> {
        arg0.closes_at
    }

    entry fun create_access_policy(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg2: bool, arg3: bool, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<vector<u8>>, arg8: &mut 0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg1);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg1);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = FormAccessPolicy{
            id                 : 0x2::object::new(arg8),
            form_id            : v0,
            requires_allowlist : arg2,
            has_response_limit : arg3,
            response_limit     : arg4,
            opens_at           : arg5,
            closes_at          : arg6,
            password_hash      : arg7,
        };
        let v3 = AccessPolicyCreated{
            form_id            : v0,
            policy_id          : 0x2::object::uid_to_inner(&v2.id),
            has_response_limit : arg3,
            response_limit     : arg4,
            has_opens_at       : 0x1::option::is_some<u64>(&arg5),
            has_closes_at      : 0x1::option::is_some<u64>(&arg6),
            has_password       : 0x1::option::is_some<vector<u8>>(&arg7),
            created_by         : v1,
        };
        0x2::event::emit<AccessPolicyCreated>(v3);
        0x2::transfer::transfer<FormAccessPolicy>(v2, v1);
    }

    public fun entry_form_id(arg0: &AllowlistEntry) : 0x2::object::ID {
        arg0.form_id
    }

    public fun form_id(arg0: &FormAccessPolicy) : 0x2::object::ID {
        arg0.form_id
    }

    public fun has_password(arg0: &FormAccessPolicy) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.password_hash)
    }

    public fun has_response_limit(arg0: &FormAccessPolicy) : bool {
        arg0.has_response_limit
    }

    public fun opens_at(arg0: &FormAccessPolicy) : 0x1::option::Option<u64> {
        arg0.opens_at
    }

    public(friend) fun policy_form_id(arg0: &FormAccessPolicy) : 0x2::object::ID {
        arg0.form_id
    }

    entry fun remove_from_allowlist(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: AllowlistEntry, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 23);
        let AllowlistEntry {
            id              : v0,
            form_id         : _,
            allowed_address : _,
            added_at        : _,
        } = arg1;
        0x2::object::delete(v0);
        let v4 = AllowlistEntryRemoved{
            form_id         : arg1.form_id,
            entry_id        : 0x2::object::uid_to_inner(&arg1.id),
            allowed_address : arg1.allowed_address,
            removed_by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AllowlistEntryRemoved>(v4);
    }

    public fun requires_allowlist(arg0: &FormAccessPolicy) : bool {
        arg0.requires_allowlist
    }

    public fun response_limit(arg0: &FormAccessPolicy) : u64 {
        arg0.response_limit
    }

    entry fun update_access_policy(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &mut FormAccessPolicy, arg2: bool, arg3: bool, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<vector<u8>>, arg8: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 23);
        arg1.requires_allowlist = arg2;
        arg1.has_response_limit = arg3;
        arg1.response_limit = arg4;
        arg1.opens_at = arg5;
        arg1.closes_at = arg6;
        arg1.password_hash = arg7;
        let v0 = AccessPolicyUpdated{
            form_id    : arg1.form_id,
            policy_id  : 0x2::object::uid_to_inner(&arg1.id),
            updated_by : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<AccessPolicyUpdated>(v0);
    }

    public(friend) fun verify_password(arg0: &FormAccessPolicy, arg1: 0x1::option::Option<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(&arg0.password_hash)) {
            assert!(0x1::option::is_some<vector<u8>>(&arg1), 16);
            assert!(*0x1::option::borrow<vector<u8>>(&arg1) == *0x1::option::borrow<vector<u8>>(&arg0.password_hash), 16);
        };
    }

    public(friend) fun verify_submission_window(arg0: &FormAccessPolicy, arg1: u64) {
        if (0x1::option::is_some<u64>(&arg0.opens_at)) {
            assert!(arg1 >= *0x1::option::borrow<u64>(&arg0.opens_at), 14);
        };
        if (0x1::option::is_some<u64>(&arg0.closes_at)) {
            assert!(arg1 <= *0x1::option::borrow<u64>(&arg0.closes_at), 14);
        };
    }

    // decompiled from Move bytecode v6
}

