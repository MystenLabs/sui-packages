module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker_referee {
    struct QuantumPokerDisputeResolved has copy, drop {
        tunnel_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        hand_id: u64,
        winner: u64,
        party_a_balance: u64,
        party_b_balance: u64,
    }

    public fun build_public_inputs(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>) : vector<u8> {
        assert!(arg4 <= 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::winner_tie(), 13906834492171091971);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, field_safe_scalar(arg0));
        0x1::vector::push_back<vector<u8>>(v1, field_safe_scalar(arg1));
        0x1::vector::push_back<vector<u8>>(v1, field_safe_scalar(arg2));
        0x1::vector::push_back<vector<u8>>(v1, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::u64_to_scalar(arg3));
        0x1::vector::push_back<vector<u8>>(v1, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::u64_to_scalar(arg4));
        0x1::vector::push_back<vector<u8>>(v1, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::u64_to_scalar(arg5));
        0x1::vector::push_back<vector<u8>>(v1, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::u64_to_scalar(arg6));
        0x1::vector::push_back<vector<u8>>(v1, field_safe_scalar(arg7));
        0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::concat_scalars(v0)
    }

    public fun build_public_inputs_for_tunnel<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::PokerSession, arg1: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>) : vector<u8> {
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::session_tunnel_id(arg0) == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::id<T0>(arg1), 13906834599545405445);
        build_public_inputs(*0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::session_rules_hash(arg0), tunnel_id_hash<T0>(arg1), arg2, arg3, arg4, arg5, arg6, arg7)
    }

    entry fun entry_resolve_with_proof<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::PokerSession, arg1: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::CircuitRegistry, arg2: &mut 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        resolve_with_proof<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun field_safe_scalar(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834393386713089);
        *0x1::vector::borrow_mut<u8>(&mut arg0, 31) = *0x1::vector::borrow<u8>(&arg0, 31) & 31;
        arg0
    }

    public fun resolve_with_proof<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::PokerSession, arg1: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::CircuitRegistry, arg2: &mut 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::circuit_params_agreed(arg0), 13906834930258542607);
        assert!(verify_result_proof<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 13906834990387691529);
        0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::resolve_dispute_verified<T0>(arg2, arg7, arg8, arg10, arg11);
        let v0 = QuantumPokerDisputeResolved{
            tunnel_id       : 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::id<T0>(arg2),
            session_id      : 0x2::object::id<0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::PokerSession>(arg0),
            hand_id         : arg5,
            winner          : arg6,
            party_a_balance : arg7,
            party_b_balance : arg8,
        };
        0x2::event::emit<QuantumPokerDisputeResolved>(v0);
    }

    public fun tunnel_id_hash<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>) : vector<u8> {
        let v0 = 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::id<T0>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public fun verify_result_proof<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::PokerSession, arg1: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::CircuitRegistry, arg2: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>) : bool {
        assert!(&arg4 == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::state_hash(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::state<T0>(arg2)), 13906834715509653511);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::is_trusted_registry(arg1), 13906834732689784843);
        assert!(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::circuit_input_schema_hash(0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::get_circuit(arg1, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::session_circuit_id(arg0))) == 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::session_input_schema_hash(arg0), 13906834779934556173);
        let v0 = build_public_inputs_for_tunnel<T0>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier::verify_circuit_proof(arg1, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::quantum_poker::session_circuit_id(arg0), &v0, &arg3)
    }

    // decompiled from Move bytecode v7
}

