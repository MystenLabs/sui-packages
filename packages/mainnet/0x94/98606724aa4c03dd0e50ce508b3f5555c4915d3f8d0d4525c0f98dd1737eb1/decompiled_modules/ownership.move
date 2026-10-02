module 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::ownership {
    struct ExecutionOwnership has key {
        id: 0x2::object::UID,
        profile_version: u16,
        execution_id: vector<u8>,
        tunnel_id: 0x2::object::ID,
        policy_digest: vector<u8>,
        controller_public_key: vector<u8>,
        attestation_policy_digest: vector<u8>,
        ownership_epoch: u64,
        runtime_public_key: vector<u8>,
    }

    struct ExecutionOwnershipCreated has copy, drop {
        ownership_id: 0x2::object::ID,
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        ownership_epoch: u64,
    }

    struct OwnershipAdvanced has copy, drop {
        ownership_id: 0x2::object::ID,
        previous_epoch: u64,
        ownership_epoch: u64,
        runtime_public_key: vector<u8>,
    }

    struct ResolutionSeatV1 has copy, drop, store {
        current_stack: u64,
        returned_contribution: u64,
        final_entitlement: u64,
        folded: bool,
    }

    public fun advance_ownership(arg0: &mut ExecutionOwnership, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>) {
        assert!(arg0.ownership_epoch == arg1, 13906834676855078921);
        assert!(arg2 > arg1, 13906834681150177291);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906834685445668883);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906834689740636179);
        assert!(0x1::vector::length<u8>(&arg6) == 64, 13906834694035210253);
        assert!(0x1::vector::length<u8>(&arg7) == 64, 13906834698330308623);
        let v0 = encode_ownership_chain_grant(arg0.profile_version, arg0.execution_id, 0x2::object::id_to_bytes(&arg0.tunnel_id), arg0.policy_digest, arg0.attestation_policy_digest, arg0.controller_public_key, arg3, arg4, arg1, arg2, arg5);
        let v1 = digest_ownership_chain_grant(&v0);
        let v2 = digest_ownership_chain_grant_possession(&v0);
        assert!(0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::verify(0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::ed25519(), &arg0.controller_public_key, &v1, &arg6), 13906834822884229133);
        assert!(0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::verify(0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::ed25519(), &arg3, &v2, &arg7), 13906834861539065871);
        arg0.ownership_epoch = arg2;
        arg0.runtime_public_key = arg3;
        let v3 = OwnershipAdvanced{
            ownership_id       : 0x2::object::id<ExecutionOwnership>(arg0),
            previous_epoch     : arg0.ownership_epoch,
            ownership_epoch    : arg2,
            runtime_public_key : arg0.runtime_public_key,
        };
        0x2::event::emit<OwnershipAdvanced>(v3);
    }

    public fun assert_current_epoch(arg0: &ExecutionOwnership, arg1: u64) {
        assert!(arg0.ownership_epoch == arg1, 13906835845086183433);
    }

    public fun attestation_policy_digest(arg0: &ExecutionOwnership) : vector<u8> {
        arg0.attestation_policy_digest
    }

    public fun controller_public_key(arg0: &ExecutionOwnership) : vector<u8> {
        arg0.controller_public_key
    }

    public(friend) fun create(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : ExecutionOwnership {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834578071486483);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834582366453779);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906834586661421075);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906834590956388371);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906834595251355667);
        let v0 = ExecutionOwnership{
            id                        : 0x2::object::new(arg6),
            profile_version           : 1,
            execution_id              : arg0,
            tunnel_id                 : arg1,
            policy_digest             : arg2,
            controller_public_key     : arg3,
            attestation_policy_digest : arg4,
            ownership_epoch           : 1,
            runtime_public_key        : arg5,
        };
        let v1 = ExecutionOwnershipCreated{
            ownership_id    : 0x2::object::id<ExecutionOwnership>(&v0),
            tunnel_id       : arg1,
            execution_id    : v0.execution_id,
            ownership_epoch : 1,
        };
        0x2::event::emit<ExecutionOwnershipCreated>(v1);
        v0
    }

    public(friend) fun destroy_disposed(arg0: ExecutionOwnership) {
        let ExecutionOwnership {
            id                        : v0,
            profile_version           : _,
            execution_id              : _,
            tunnel_id                 : _,
            policy_digest             : _,
            controller_public_key     : _,
            attestation_policy_digest : _,
            ownership_epoch           : _,
            runtime_public_key        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun digest_ownership_chain_grant(arg0: &vector<u8>) : vector<u8> {
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::ownership_chain_grant_v1", arg0)
    }

    public fun digest_ownership_chain_grant_possession(arg0: &vector<u8>) : vector<u8> {
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::ownership_chain_grant_possession_v1", arg0)
    }

    public fun digest_recovery_adoption(arg0: &vector<u8>) : vector<u8> {
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::recovery_adoption_v1", arg0)
    }

    public fun digest_recovery_resolution(arg0: &vector<u8>) : vector<u8> {
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::recovery_resolution_v1", arg0)
    }

    public fun digest_recovery_resolution_referee(arg0: &vector<u8>) : vector<u8> {
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::recovery_resolution_referee_v1", arg0)
    }

    public fun digest_runtime_effect_endorsement(arg0: &vector<u8>) : vector<u8> {
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::runtime_effect_v1", arg0)
    }

    public fun encode_ownership_chain_grant(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834986093379603);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834990388346899);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906834994683314195);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906834998978281491);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906835003273248787);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906835007568216083);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 13906835011863183379);
        let v0 = 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, arg6);
        0x1::vector::append<u8>(&mut v0, arg7);
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg8));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg9));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg10));
        v0
    }

    public fun encode_recovery_adoption(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906835346870632467);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906835351165599763);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835355460567059);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906835359755534355);
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x1::vector::append<u8>(&mut arg0, arg3);
        arg0
    }

    public fun encode_recovery_resolution(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &vector<ResolutionSeatV1>, arg12: u64, arg13: vector<u8>, arg14: u8) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906836613886443546);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906836618181410842);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906836622476378138);
        assert!(0x1::vector::length<u8>(&arg10) == 32, 13906836626771345434);
        assert!(0x1::vector::length<u8>(&arg13) == 32, 13906836631066312730);
        assert!(0x1::vector::length<ResolutionSeatV1>(arg11) <= 65535, 13906836635361411100);
        let v0 = 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg5));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg6));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg7));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg8));
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg9));
        0x1::vector::append<u8>(&mut v0, arg10);
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::u16_to_be_bytes((0x1::vector::length<ResolutionSeatV1>(arg11) as u16)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<ResolutionSeatV1>(arg11)) {
            let v2 = 0x1::vector::borrow<ResolutionSeatV1>(arg11, v1);
            0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(v2.current_stack));
            0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(v2.returned_contribution));
            0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(v2.final_entitlement));
            let v3 = if (v2.folded) {
                1
            } else {
                0
            };
            0x1::vector::push_back<u8>(&mut v0, v3);
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg12));
        0x1::vector::append<u8>(&mut v0, arg13);
        0x1::vector::push_back<u8>(&mut v0, arg14);
        v0
    }

    public fun encode_recovery_resolution_referee_preimage(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906836845814677530);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906836850109644826);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906836854404612122);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906836858699579418);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906836862994546714);
        let v0 = 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::push_back<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, arg6);
        v0
    }

    public fun encode_runtime_effect_endorsement(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906835187956973589);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835192251809811);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906835196546777107);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906835200841613329);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 13906835205136580625);
        let v0 = 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::u64_to_be_bytes(arg4));
        0x1::vector::push_back<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, arg6);
        0x1::vector::append<u8>(&mut v0, arg7);
        v0
    }

    public fun execution_id(arg0: &ExecutionOwnership) : vector<u8> {
        arg0.execution_id
    }

    public fun new_resolution_seat(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : ResolutionSeatV1 {
        ResolutionSeatV1{
            current_stack         : arg0,
            returned_contribution : arg1,
            final_entitlement     : arg2,
            folded                : arg3,
        }
    }

    public fun operation_adopt_disputed_checkpoint() : u8 {
        3
    }

    public fun operation_apply_non_outcome_receipt() : u8 {
        10
    }

    public fun operation_force_close_after_timeout() : u8 {
        7
    }

    public fun operation_open_dispute_from_committed_state() : u8 {
        1
    }

    public fun operation_open_dispute_with_checkpoint() : u8 {
        2
    }

    public fun operation_publish_action_outcome() : u8 {
        9
    }

    public fun operation_publish_hand_outcome() : u8 {
        8
    }

    public fun operation_resolve_recovery() : u8 {
        11
    }

    public fun operation_settle_by_referee() : u8 {
        5
    }

    public fun operation_settle_cooperative() : u8 {
        4
    }

    public fun operation_void_by_referee() : u8 {
        6
    }

    public fun ownership_epoch(arg0: &ExecutionOwnership) : u64 {
        arg0.ownership_epoch
    }

    public fun ownership_id(arg0: &ExecutionOwnership) : 0x2::object::ID {
        0x2::object::id<ExecutionOwnership>(arg0)
    }

    public fun policy_digest(arg0: &ExecutionOwnership) : vector<u8> {
        arg0.policy_digest
    }

    public fun profile_version(arg0: &ExecutionOwnership) : u16 {
        arg0.profile_version
    }

    public fun runtime_public_key(arg0: &ExecutionOwnership) : vector<u8> {
        arg0.runtime_public_key
    }

    public fun seat_current_stack(arg0: &ResolutionSeatV1) : u64 {
        arg0.current_stack
    }

    public fun seat_final_entitlement(arg0: &ResolutionSeatV1) : u64 {
        arg0.final_entitlement
    }

    public fun seat_folded(arg0: &ResolutionSeatV1) : bool {
        arg0.folded
    }

    public fun seat_returned_contribution(arg0: &ResolutionSeatV1) : u64 {
        arg0.returned_contribution
    }

    public(friend) fun share(arg0: ExecutionOwnership) {
        0x2::transfer::share_object<ExecutionOwnership>(arg0);
    }

    public fun stable_effect_id(arg0: vector<u8>, arg1: u8, arg2: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906835565913964563);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835570208800785);
        0x1::vector::push_back<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::terminal_wire::digest_framed(b"dopa_open::stable_effect_id_v1", &arg0)
    }

    public fun tunnel_id(arg0: &ExecutionOwnership) : 0x2::object::ID {
        arg0.tunnel_id
    }

    public fun verify_runtime_endorsement(arg0: &ExecutionOwnership, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(arg0.tunnel_id == arg1, 13906835703352918035);
        assert!(0x1::vector::length<u8>(&arg6) == 64, 13906835707647754257);
        assert!(arg5 == stable_effect_id(arg0.execution_id, arg3, arg4), 13906835724828475422);
        let v0 = encode_runtime_effect_endorsement(arg0.profile_version, arg2, arg0.execution_id, 0x2::object::id_to_bytes(&arg1), arg0.ownership_epoch, arg3, arg4, arg5);
        let v1 = digest_runtime_effect_endorsement(&v0);
        assert!(0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::verify(0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::signature::ed25519(), &arg0.runtime_public_key, &v1, &arg6), 13906835810726969361);
    }

    // decompiled from Move bytecode v7
}

