module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_activity_log {
    struct ReallocateOrderedV1 has copy, drop {
        state: u8,
        intent_id: vector<u8>,
        verified_leader: address,
        strategy_id: vector<u8>,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        route_commitment: vector<u8>,
        reallocation_state_id: vector<u8>,
        allocation_bps: u64,
        source_opportunity_id: vector<u8>,
        destination_opportunity_id: vector<u8>,
        source_chain_id: vector<u8>,
        destination_chain_id: vector<u8>,
        source_native_asset: vector<u8>,
        destination_native_asset: vector<u8>,
        issued_at_ms: u64,
        expires_at_ms: u64,
        recorded_at_ms: u64,
    }

    public fun assert_terminal_outcome_state(arg0: u8) {
        assert!(arg0 == 2 || arg0 == 3, 3);
    }

    public fun executed_state() : u8 {
        2
    }

    public fun failed_state() : u8 {
        3
    }

    public fun ordered_state() : u8 {
        1
    }

    public(friend) fun record_ordered(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::AuthorizedHubCommand, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::authorized_intent_id(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 32, 2);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::authorized_reallocate_audit_v1(arg0);
        let v15 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg1);
        assert!(0x1::vector::length<u8>(&v15) == 32, 1);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg1), 1);
        assert!(v2 == v15, 1);
        let v16 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg1);
        assert!(v3 == 0x2::bcs::to_bytes<0x2::object::ID>(&v16), 5);
        let v17 = 0x2::tx_context::sender(arg3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg1) == v17, 4);
        let v18 = ReallocateOrderedV1{
            state                      : 1,
            intent_id                  : v0,
            verified_leader            : v17,
            strategy_id                : v1,
            guardrails_id              : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg1),
            guardrails_hash            : v15,
            route_commitment           : v4,
            reallocation_state_id      : v5,
            allocation_bps             : v6,
            source_opportunity_id      : v7,
            destination_opportunity_id : v8,
            source_chain_id            : v9,
            destination_chain_id       : v10,
            source_native_asset        : v11,
            destination_native_asset   : v12,
            issued_at_ms               : v13,
            expires_at_ms              : v14,
            recorded_at_ms             : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReallocateOrderedV1>(v18);
    }

    // decompiled from Move bytecode v7
}

