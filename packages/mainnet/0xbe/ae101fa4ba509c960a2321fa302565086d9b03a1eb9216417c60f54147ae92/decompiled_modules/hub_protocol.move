module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol {
    struct SpokeSequence has drop, store {
        spoke_eid: u32,
        next_sequence: u64,
    }

    struct HubState has key {
        id: 0x2::object::UID,
        sequences: vector<SpokeSequence>,
        oapp_call_cap_id: 0x1::option::Option<address>,
    }

    struct HubStateBootstrapped has copy, drop {
        hub_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct HubOAppBound has copy, drop {
        hub_id: 0x2::object::ID,
        oapp_call_cap_id: address,
    }

    struct ReallocateCommand has copy, drop, store {
        domain: vector<u8>,
        version: u8,
        action: u8,
        spoke_eid: u32,
        sequence: u64,
        issued_at_ms: u64,
        expires_at_ms: u64,
        strategy_id: vector<u8>,
        guardrails_hash: vector<u8>,
        source_chain_id: vector<u8>,
        destination_chain_id: vector<u8>,
        from_asset_type: vector<u8>,
        to_asset_type: vector<u8>,
        from_opportunity_id: vector<u8>,
        to_opportunity_id: vector<u8>,
        allocation_bps: u64,
    }

    struct ManagedReallocateCommandV1 has copy, drop, store {
        domain: vector<u8>,
        version: u8,
        action: u8,
        spoke_eid: u32,
        sequence: u64,
        issued_at_ms: u64,
        expires_at_ms: u64,
        strategy_id: vector<u8>,
        guardrails_hash: vector<u8>,
        guardrails_id: vector<u8>,
        source_chain_id: vector<u8>,
        destination_chain_id: vector<u8>,
        source_native_asset: vector<u8>,
        destination_native_asset: vector<u8>,
        from_opportunity_id: vector<u8>,
        to_opportunity_id: vector<u8>,
        allocation_bps: u64,
        route_commitment: vector<u8>,
        reallocation_state_id: vector<u8>,
    }

    struct ExitModeCommand has copy, drop, store {
        domain: vector<u8>,
        version: u8,
        action: u8,
        spoke_eid: u32,
        sequence: u64,
        issued_at_ms: u64,
        expires_at_ms: u64,
        strategy_id: vector<u8>,
        guardrails_hash: vector<u8>,
    }

    struct AuthorizedHubCommand {
        dst_eid: u32,
        payload: vector<u8>,
        reallocate: ManagedReallocateCommandV1,
        oapp_call_cap_id: address,
    }

    struct IntentPreimageV1 has drop {
        domain: vector<u8>,
        dst_eid: u32,
        command_hash: vector<u8>,
    }

    struct SpokeInbox has drop, store {
        local_eid: u32,
        pinned_day_hub_peer: vector<u8>,
        next_sequence: u64,
    }

    public(friend) fun assert_canonical_hub_and_registry(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &HubState, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::id(arg2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::assert_canonical_strategy_registry_binding(arg0, v0, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::admin_cap_id(arg2), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::governance(arg2));
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::assert_canonical_hub_state_binding(arg0, 0x2::object::id<HubState>(arg1), v0);
    }

    fun assert_exit_body(arg0: &ExitModeCommand) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.strategy_id), 3);
        assert!(0x1::vector::length<u8>(&arg0.guardrails_hash) == 32, 4);
    }

    fun assert_expired_wire_header(arg0: &SpokeInbox, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: u8, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1 == b"DAY_HUB", 11);
        assert!(arg2 == 1, 12);
        assert!(arg3 == arg4, 13);
        assert!(arg5 == arg0.local_eid, 10);
        assert!(arg6 == arg0.next_sequence, 14);
        assert!(arg8 > arg7, 2);
        assert!(arg7 <= arg9, 2);
        assert!(arg9 > arg8, 31);
        assert!(arg0.next_sequence < 18446744073709551615, 8);
    }

    public fun assert_managed_reallocate_v1_message(arg0: u32, arg1: &vector<u8>) : u64 {
        let v0 = 0x2::bcs::new(*arg1);
        assert!(0x2::bcs::peel_vec_u8(&mut v0) == b"DAY_HUB", 11);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 12);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 13);
        assert!(0x2::bcs::peel_u32(&mut v0) == arg0, 10);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v3 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v4 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v5 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v6 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v7 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v8 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v9 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v10 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v11 = 0x2::bcs::peel_u64(&mut v0);
        let v12 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v13 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(!0x1::vector::is_empty<u8>(&v2), 3);
        assert!(0x1::vector::length<u8>(&v3) == 32, 4);
        assert!(0x1::vector::length<u8>(&v4) == 32, 18);
        assert!(!0x1::vector::is_empty<u8>(&v5), 19);
        assert!(!0x1::vector::is_empty<u8>(&v6), 19);
        assert!(layerzero_eid_for_chain(v6) == arg0, 10);
        assert!(!0x1::vector::is_empty<u8>(&v7), 20);
        assert!(!0x1::vector::is_empty<u8>(&v8), 20);
        assert!(!0x1::vector::is_empty<u8>(&v9), 5);
        assert!(!0x1::vector::is_empty<u8>(&v10), 5);
        assert!(v9 != v10, 6);
        assert!(v11 >= 1 && v11 <= 10000, 7);
        assert!(0x1::vector::length<u8>(&v12) == 32, 9);
        assert!(0x1::vector::length<u8>(&v13) == 32, 9);
        let v14 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v14), 9);
        assert!(v1 > 0x2::bcs::peel_u64(&mut v0), 2);
        v1
    }

    fun assert_provenance(arg0: &SpokeInbox, arg1: u32, arg2: vector<u8>) {
        assert!(provenance_matches(arg1, arg2, arg0.pinned_day_hub_peer), 9);
    }

    fun assert_reallocate_body(arg0: &ReallocateCommand) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.strategy_id), 3);
        assert!(0x1::vector::length<u8>(&arg0.guardrails_hash) == 32, 4);
        assert!(!0x1::vector::is_empty<u8>(&arg0.from_opportunity_id), 5);
        assert!(!0x1::vector::is_empty<u8>(&arg0.to_opportunity_id), 5);
        assert!(!0x1::vector::is_empty<u8>(&arg0.source_chain_id), 19);
        assert!(!0x1::vector::is_empty<u8>(&arg0.destination_chain_id), 19);
        assert!(!0x1::vector::is_empty<u8>(&arg0.from_asset_type), 20);
        assert!(!0x1::vector::is_empty<u8>(&arg0.to_asset_type), 20);
        assert!(layerzero_eid_for_chain(arg0.destination_chain_id) == arg0.spoke_eid, 10);
        assert!(arg0.from_opportunity_id != arg0.to_opportunity_id, 6);
        assert!(arg0.allocation_bps >= 1 && arg0.allocation_bps <= 10000, 7);
    }

    fun assert_wire_header(arg0: &SpokeInbox, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: u8, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1 == b"DAY_HUB", 11);
        assert!(arg2 == 1, 12);
        assert!(arg3 == arg4, 13);
        assert!(arg5 == arg0.local_eid, 10);
        assert!(arg6 == arg0.next_sequence, 14);
        assert!(arg8 > arg7, 2);
        assert!(arg7 <= arg9, 2);
        assert!(arg9 <= arg8, 15);
        assert!(arg0.next_sequence < 18446744073709551615, 8);
    }

    public(friend) fun authorize_validated_reallocation<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &mut HubState, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ReallocationPolicyWitness, arg5: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::ReallocationReservation<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : AuthorizedHubCommand {
        assert_canonical_hub_and_registry(arg0, arg1, arg2);
        let (_, _, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::consume_reallocation_witness(arg4);
        let (v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_reallocation::consume_reallocation_reservation<T0>(arg5);
        let v25 = v23;
        let v26 = v22;
        let v27 = v20;
        let v28 = v18;
        let v29 = v12;
        assert!(v2 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::id(arg2), 30);
        assert!(v3 == v17, 30);
        assert!(v4 == v28, 30);
        assert!(v5 == v19, 30);
        assert!(v7 == v13, 30);
        assert!(v9 == v14, 30);
        assert!(v8 == v15, 30);
        assert!(v10 == v16, 30);
        assert!(v11 == v24, 30);
        assert!(!0x1::vector::is_empty<u8>(&v27), 30);
        assert!(0x1::hash::sha2_256(v27) == v21, 30);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_accepts_reallocation(arg2, v17);
        let v30 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg2, v17);
        let v31 = 0x2::tx_context::sender(arg8);
        assert!(v6 == v31, 17);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::leader(v30) == v31, 17);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_id(v30) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg3), 18);
        let v32 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_hash(v30);
        assert!(v32 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg3), 18);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg3), 18);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg3) == v31, 17);
        assert!(v28 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg3), 18);
        assert!(v19 == v32, 18);
        assert!(0x1::option::is_some<address>(&arg1.oapp_call_cap_id), 25);
        let v33 = *0x1::option::borrow<address>(&arg1.oapp_call_cap_id);
        let v34 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&v25);
        let v35 = layerzero_eid_for_chain(v34);
        let v36 = prepare_validated_reallocation(arg1, v35, v17, v32, 0x2::bcs::to_bytes<0x2::object::ID>(&v28), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&v26), v34, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_canonical_v1_bytes(&v26), 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_canonical_v1_bytes(&v25), v15, v16, v24, v21, 0x2::bcs::to_bytes<0x2::object::ID>(&v29), arg6, arg7);
        AuthorizedHubCommand{
            dst_eid          : v35,
            payload          : managed_reallocate_v1_bytes(&v36),
            reallocate       : v36,
            oapp_call_cap_id : v33,
        }
    }

    public(friend) fun authorized_intent_id(arg0: &AuthorizedHubCommand) : vector<u8> {
        let v0 = IntentPreimageV1{
            domain       : b"DAY_INTENT",
            dst_eid      : arg0.dst_eid,
            command_hash : 0x1::hash::sha2_256(arg0.payload),
        };
        0x1::hash::sha2_256(0x2::bcs::to_bytes<IntentPreimageV1>(&v0))
    }

    public(friend) fun authorized_reallocate_audit_v1(arg0: &AuthorizedHubCommand) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, u64, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, u64, u64) {
        let v0 = &arg0.reallocate;
        (v0.strategy_id, v0.guardrails_hash, v0.guardrails_id, v0.route_commitment, v0.reallocation_state_id, v0.allocation_bps, v0.from_opportunity_id, v0.to_opportunity_id, v0.source_chain_id, v0.destination_chain_id, v0.source_native_asset, v0.destination_native_asset, v0.issued_at_ms, v0.expires_at_ms)
    }

    public fun authorized_transport_message(arg0: &AuthorizedHubCommand) : (u32, vector<u8>) {
        (arg0.dst_eid, arg0.payload)
    }

    public entry fun bind_layerzero_oapp_call_cap(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &mut HubState, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg4: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg5: &0x2::tx_context::TxContext) {
        assert_canonical_hub_and_registry(arg0, arg1, arg2);
        assert!(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap>(arg3) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::admin_cap_id(arg2), 22);
        assert!(0x2::tx_context::sender(arg5) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::governance(arg2), 23);
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::is_package(arg4), 26);
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg4);
        assert!(v0 != @0x0, 26);
        assert!(0x1::option::is_none<address>(&arg1.oapp_call_cap_id), 24);
        arg1.oapp_call_cap_id = 0x1::option::some<address>(v0);
        let v1 = HubOAppBound{
            hub_id           : 0x2::object::id<HubState>(arg1),
            oapp_call_cap_id : v0,
        };
        0x2::event::emit<HubOAppBound>(v1);
    }

    public entry fun bootstrap_hub_state(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::strategy_registry_bootstrapped(arg0), 21);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::id(arg1);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::admin_cap_id(arg1);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::governance(arg1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::assert_canonical_strategy_registry_binding(arg0, v0, v1, v2);
        assert!(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap>(arg2) == v1, 22);
        assert!(0x2::tx_context::sender(arg3) == v2, 23);
        let v3 = HubState{
            id               : 0x2::object::new(arg3),
            sequences        : 0x1::vector::empty<SpokeSequence>(),
            oapp_call_cap_id : 0x1::option::none<address>(),
        };
        let v4 = 0x2::object::id<HubState>(&v3);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::anchor_hub_state(arg0, v4, v0);
        let v5 = HubStateBootstrapped{
            hub_id      : v4,
            registry_id : v0,
        };
        0x2::event::emit<HubStateBootstrapped>(v5);
        0x2::transfer::share_object<HubState>(v3);
    }

    public fun consume_after_completed_layerzero_call(arg0: AuthorizedHubCommand, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>) {
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::caller<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1) == arg0.oapp_call_cap_id, 26);
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::callee<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1) == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(), 26);
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::is_completed(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::status<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1)), 27);
        assert!(0x1::option::is_some<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::result<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1)), 27);
        let v0 = 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1);
        assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::dst_eid(v0) == arg0.dst_eid, 10);
        assert!(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::message(v0) == arg0.payload, 9);
        let v1 = 0x1::option::borrow<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::result<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>(arg1));
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::nonce(v1);
        assert!(v2 > 0, 28);
        assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::guid(v1) == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::compute_guid(v2, 30378, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_address(arg0.oapp_call_cap_id), arg0.dst_eid, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::receiver(v0)), 28);
        let v3 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::messaging_fee(v1);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::native_fee(v3);
        if (!0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::pay_in_zro(v0)) {
            assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::zro_fee(v3) == 0, 29);
        };
        let AuthorizedHubCommand {
            dst_eid          : _,
            payload          : _,
            reallocate       : _,
            oapp_call_cap_id : _,
        } = arg0;
    }

    public fun exit_mode_bytes(arg0: &ExitModeCommand) : vector<u8> {
        0x2::bcs::to_bytes<ExitModeCommand>(arg0)
    }

    public fun exit_mode_hash(arg0: &ExitModeCommand) : vector<u8> {
        0x1::hash::sha2_256(exit_mode_bytes(arg0))
    }

    public fun exit_mode_sequence(arg0: &ExitModeCommand) : u64 {
        arg0.sequence
    }

    public fun exit_mode_spoke_eid(arg0: &ExitModeCommand) : u32 {
        arg0.spoke_eid
    }

    public fun inbox_next_sequence(arg0: &SpokeInbox) : u64 {
        arg0.next_sequence
    }

    public fun layerzero_eid_for_chain(arg0: vector<u8>) : u32 {
        if (arg0 == b"base") {
            30184
        } else if (arg0 == b"arbitrum") {
            30110
        } else {
            assert!(arg0 == b"solana", 16);
            30168
        }
    }

    public fun managed_reallocate_v1_bytes(arg0: &ManagedReallocateCommandV1) : vector<u8> {
        0x2::bcs::to_bytes<ManagedReallocateCommandV1>(arg0)
    }

    public(friend) fun prepare_exit_mode(arg0: &mut HubState, arg1: u32, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) : ExitModeCommand {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        validate_common(arg1, &arg2, &arg3, v0, arg4);
        ExitModeCommand{
            domain          : b"DAY_HUB",
            version         : 1,
            action          : 2,
            spoke_eid       : arg1,
            sequence        : reserve_sequence(arg0, arg1),
            issued_at_ms    : v0,
            expires_at_ms   : arg4,
            strategy_id     : arg2,
            guardrails_hash : arg3,
        }
    }

    public(friend) fun prepare_reallocate(arg0: &mut HubState, arg1: u32, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock) : ReallocateCommand {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        validate_common(arg1, &arg2, &arg3, v0, arg11);
        assert!(!0x1::vector::is_empty<u8>(&arg8), 5);
        assert!(!0x1::vector::is_empty<u8>(&arg9), 5);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 19);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 19);
        assert!(!0x1::vector::is_empty<u8>(&arg6), 20);
        assert!(!0x1::vector::is_empty<u8>(&arg7), 20);
        assert!(layerzero_eid_for_chain(arg5) == arg1, 10);
        assert!(arg8 != arg9, 6);
        assert!(arg10 >= 1 && arg10 <= 10000, 7);
        ReallocateCommand{
            domain               : b"DAY_HUB",
            version              : 1,
            action               : 1,
            spoke_eid            : arg1,
            sequence             : reserve_sequence(arg0, arg1),
            issued_at_ms         : v0,
            expires_at_ms        : arg11,
            strategy_id          : arg2,
            guardrails_hash      : arg3,
            source_chain_id      : arg4,
            destination_chain_id : arg5,
            from_asset_type      : arg6,
            to_asset_type        : arg7,
            from_opportunity_id  : arg8,
            to_opportunity_id    : arg9,
            allocation_bps       : arg10,
        }
    }

    fun prepare_validated_reallocation(arg0: &mut HubState, arg1: u32, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: u64, arg15: &0x2::clock::Clock) : ManagedReallocateCommandV1 {
        let v0 = 0x2::clock::timestamp_ms(arg15);
        validate_common(arg1, &arg2, &arg3, v0, arg14);
        assert!(!0x1::vector::is_empty<u8>(&arg9), 5);
        assert!(!0x1::vector::is_empty<u8>(&arg10), 5);
        assert!(arg9 != arg10, 6);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 19);
        assert!(!0x1::vector::is_empty<u8>(&arg6), 19);
        assert!(!0x1::vector::is_empty<u8>(&arg7), 20);
        assert!(!0x1::vector::is_empty<u8>(&arg8), 20);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 18);
        assert!(0x1::vector::length<u8>(&arg12) == 32, 4);
        assert!(0x1::vector::length<u8>(&arg13) == 32, 9);
        assert!(layerzero_eid_for_chain(arg6) == arg1, 10);
        assert!(arg11 >= 1 && arg11 <= 10000, 7);
        ManagedReallocateCommandV1{
            domain                   : b"DAY_HUB",
            version                  : 1,
            action                   : 1,
            spoke_eid                : arg1,
            sequence                 : reserve_sequence(arg0, arg1),
            issued_at_ms             : v0,
            expires_at_ms            : arg14,
            strategy_id              : arg2,
            guardrails_hash          : arg3,
            guardrails_id            : arg4,
            source_chain_id          : arg5,
            destination_chain_id     : arg6,
            source_native_asset      : arg7,
            destination_native_asset : arg8,
            from_opportunity_id      : arg9,
            to_opportunity_id        : arg10,
            allocation_bps           : arg11,
            route_commitment         : arg12,
            reallocation_state_id    : arg13,
        }
    }

    public fun provenance_matches(arg0: u32, arg1: vector<u8>, arg2: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg1) == 32) {
            if (0x1::vector::length<u8>(&arg2) == 32) {
                if (arg0 == 30378) {
                    arg1 == arg2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun reallocate_bytes(arg0: &ReallocateCommand) : vector<u8> {
        0x2::bcs::to_bytes<ReallocateCommand>(arg0)
    }

    public fun reallocate_hash(arg0: &ReallocateCommand) : vector<u8> {
        0x1::hash::sha2_256(reallocate_bytes(arg0))
    }

    public fun reallocate_sequence(arg0: &ReallocateCommand) : u64 {
        arg0.sequence
    }

    public fun reallocate_spoke_eid(arg0: &ReallocateCommand) : u32 {
        arg0.spoke_eid
    }

    fun reserve_sequence(arg0: &mut HubState, arg1: u32) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SpokeSequence>(&arg0.sequences)) {
            let v1 = 0x1::vector::borrow_mut<SpokeSequence>(&mut arg0.sequences, v0);
            if (v1.spoke_eid == arg1) {
                let v2 = v1.next_sequence;
                assert!(v2 < 18446744073709551615, 8);
                v1.next_sequence = v2 + 1;
                return v2
            };
            v0 = v0 + 1;
        };
        let v3 = SpokeSequence{
            spoke_eid     : arg1,
            next_sequence : 1,
        };
        0x1::vector::push_back<SpokeSequence>(&mut arg0.sequences, v3);
        0
    }

    public fun skip_expired_exit_mode_and_consume(arg0: &mut SpokeInbox, arg1: u32, arg2: vector<u8>, arg3: &ExitModeCommand, arg4: u64) {
        abort 32
    }

    public fun skip_expired_reallocate_and_consume(arg0: &mut SpokeInbox, arg1: u32, arg2: vector<u8>, arg3: &ReallocateCommand, arg4: u64) {
        abort 32
    }

    public fun sui_layerzero_eid() : u32 {
        30378
    }

    fun validate_common(arg0: u32, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: u64) {
        assert!(arg0 != 0 && arg0 != 30378, 1);
        assert!(!0x1::vector::is_empty<u8>(arg1), 3);
        assert!(0x1::vector::length<u8>(arg2) == 32, 4);
        assert!(arg4 > arg3, 2);
    }

    public fun verify_exit_mode_and_consume(arg0: &mut SpokeInbox, arg1: u32, arg2: vector<u8>, arg3: &ExitModeCommand, arg4: u64) {
        assert_provenance(arg0, arg1, arg2);
        assert_wire_header(arg0, arg3.domain, arg3.version, arg3.action, 2, arg3.spoke_eid, arg3.sequence, arg3.issued_at_ms, arg3.expires_at_ms, arg4);
        assert_exit_body(arg3);
        arg0.next_sequence = arg0.next_sequence + 1;
    }

    public fun verify_reallocate_and_consume(arg0: &mut SpokeInbox, arg1: u32, arg2: vector<u8>, arg3: &ReallocateCommand, arg4: u64) {
        assert_provenance(arg0, arg1, arg2);
        assert_wire_header(arg0, arg3.domain, arg3.version, arg3.action, 1, arg3.spoke_eid, arg3.sequence, arg3.issued_at_ms, arg3.expires_at_ms, arg4);
        assert_reallocate_body(arg3);
        arg0.next_sequence = arg0.next_sequence + 1;
    }

    // decompiled from Move bytecode v7
}

