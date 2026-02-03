module 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::delegation_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Delegation has copy, drop, store {
        access_level: u8,
        expires_at: u64,
        allowed_memory_types: vector<u8>,
        note: vector<u8>,
    }

    struct Config has store {
        vault_id: 0x2::object::ID,
        delegations: 0x2::table::Table<address, Delegation>,
    }

    public fun add(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            vault_id    : arg2,
            delegations : 0x2::table::new<address, Delegation>(arg3),
        };
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun access_level_full() : u8 {
        2
    }

    public fun access_level_read() : u8 {
        0
    }

    public fun access_level_read_write() : u8 {
        1
    }

    public fun delegate(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap, arg2: address, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(!0x2::table::contains<address, Delegation>(&v1.delegations, arg2), 4);
        let v2 = Delegation{
            access_level         : arg3,
            expires_at           : arg4,
            allowed_memory_types : arg5,
            note                 : arg6,
        };
        0x2::table::add<address, Delegation>(&mut v1.delegations, arg2, v2);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::delegation_created(v1.vault_id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::policy_id(arg0), arg2, arg3, arg4);
    }

    public fun get_delegation(arg0: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: address) : (u8, u64, vector<u8>, vector<u8>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::get_rule<Rule, Config>(v0, arg0);
        assert!(0x2::table::contains<address, Delegation>(&v1.delegations, arg1), 0);
        let v2 = 0x2::table::borrow<address, Delegation>(&v1.delegations, arg1);
        (v2.access_level, v2.expires_at, v2.allowed_memory_types, v2.note)
    }

    public fun has_delegation(arg0: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: address) : bool {
        let v0 = Rule{dummy_field: false};
        0x2::table::contains<address, Delegation>(&0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::get_rule<Rule, Config>(v0, arg0).delegations, arg1)
    }

    public fun is_configured(arg0: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy) : bool {
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessRequest, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Delegation>(&v1.delegations, v2), 0);
        let v3 = 0x2::table::borrow<address, Delegation>(&v1.delegations, v2);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg2) < v3.expires_at, 1);
        let v4 = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::access_type(arg0);
        let v5 = if (v4 == 0 && v3.access_level >= 0) {
            true
        } else if (v4 == 1 && v3.access_level >= 1) {
            true
        } else {
            v4 == 2 && v3.access_level >= 2
        };
        assert!(v5, 2);
        if (!0x1::vector::is_empty<u8>(&v3.allowed_memory_types)) {
            let v6 = false;
            let v7 = 0;
            while (v7 < 0x1::vector::length<u8>(&v3.allowed_memory_types)) {
                if (*0x1::vector::borrow<u8>(&v3.allowed_memory_types, v7) == 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::memory_type(arg0)) {
                    v6 = true;
                    break
                };
                v7 = v7 + 1;
            };
            assert!(v6, 3);
        };
        let v8 = Rule{dummy_field: false};
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::add_receipt<Rule>(v8, arg0);
    }

    public fun revoke(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(0x2::table::contains<address, Delegation>(&v1.delegations, arg2), 0);
        0x2::table::remove<address, Delegation>(&mut v1.delegations, arg2);
        0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::events::delegation_revoked(v1.vault_id, 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::policy_id(arg0), arg2);
    }

    public fun update_delegation(arg0: &mut 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicy, arg1: &0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::AccessPolicyCap, arg2: address, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(0x2::table::contains<address, Delegation>(&v1.delegations, arg2), 0);
        let v2 = 0x2::table::borrow_mut<address, Delegation>(&mut v1.delegations, arg2);
        v2.access_level = arg3;
        v2.expires_at = arg4;
        v2.allowed_memory_types = arg5;
        v2.note = arg6;
    }

    // decompiled from Move bytecode v6
}

