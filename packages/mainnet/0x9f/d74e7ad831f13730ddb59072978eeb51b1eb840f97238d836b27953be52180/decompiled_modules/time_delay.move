module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::time_delay {
    struct TimeDelay has drop {
        dummy_field: bool,
    }

    struct TimeDelayConfig has store {
        delay_ms: u64,
        commitments: 0x2::table::Table<vector<u8>, u64>,
    }

    struct CommitmentCreated has copy, drop {
        engine_id: 0x2::object::ID,
        message_hash: vector<u8>,
        commit_ms: u64,
        release_ms: u64,
    }

    struct CommitmentConsumed has copy, drop {
        engine_id: 0x2::object::ID,
        message_hash: vector<u8>,
        consumed_ms: u64,
    }

    struct CommitmentRevoked has copy, drop {
        engine_id: 0x2::object::ID,
        message_hash: vector<u8>,
        revoked_ms: u64,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeDelay{dummy_field: false};
        let v1 = TimeDelayConfig{
            delay_ms    : arg2,
            commitments : 0x2::table::new<vector<u8>, u64>(arg3),
        };
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<TimeDelay, TimeDelayConfig>(arg0, arg1, v0, v1);
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        let TimeDelayConfig {
            delay_ms    : _,
            commitments : v1,
        } = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<TimeDelay, TimeDelayConfig>(arg0, arg1);
        0x2::table::destroy_empty<vector<u8>, u64>(v1);
    }

    public fun commit(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAccessCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0);
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::access_cap_engine_id(arg1) == v0, 3);
        let v1 = TimeDelay{dummy_field: false};
        let v2 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TimeDelay, TimeDelayConfig>(arg0, v1);
        assert!(!0x2::table::contains<vector<u8>, u64>(&v2.commitments, arg2), 2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        0x2::table::add<vector<u8>, u64>(&mut v2.commitments, arg2, v3);
        let v4 = CommitmentCreated{
            engine_id    : v0,
            message_hash : arg2,
            commit_ms    : v3,
            release_ms   : v3 + v2.delay_ms,
        };
        0x2::event::emit<CommitmentCreated>(v4);
    }

    public fun commitment_ms(arg0: &TimeDelayConfig, arg1: vector<u8>) : u64 {
        *0x2::table::borrow<vector<u8>, u64>(&arg0.commitments, arg1)
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &TimeDelayConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<TimeDelay, TimeDelayConfig>(arg0)
    }

    public fun delay_ms(arg0: &TimeDelayConfig) : u64 {
        arg0.delay_ms
    }

    public fun enforce(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest, arg2: &0x2::clock::Clock) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<TimeDelay> {
        let v0 = 0x2::hash::blake2b256(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::message(arg1));
        let v1 = TimeDelay{dummy_field: false};
        let v2 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TimeDelay, TimeDelayConfig>(arg0, v1);
        assert!(0x2::table::contains<vector<u8>, u64>(&v2.commitments, v0), 0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        assert!(v3 >= 0x2::table::remove<vector<u8>, u64>(&mut v2.commitments, v0) + v2.delay_ms, 1);
        let v4 = CommitmentConsumed{
            engine_id    : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::engine_id(arg1),
            message_hash : v0,
            consumed_ms  : v3,
        };
        0x2::event::emit<CommitmentConsumed>(v4);
        let v5 = TimeDelay{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<TimeDelay>(v5, arg1)
    }

    public fun has_commitment(arg0: &TimeDelayConfig, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.commitments, arg1)
    }

    public fun revoke_commitment(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0);
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == v0, 0);
        let v1 = TimeDelay{dummy_field: false};
        0x2::table::remove<vector<u8>, u64>(&mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TimeDelay, TimeDelayConfig>(arg0, v1).commitments, arg2);
        let v2 = CommitmentRevoked{
            engine_id    : v0,
            message_hash : arg2,
            revoked_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CommitmentRevoked>(v2);
    }

    public fun set_delay_ms(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TimeDelay{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TimeDelay, TimeDelayConfig>(arg0, v0).delay_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

