module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::sui_randomness {
    struct QuantumPokerRandomnessSeed has copy, drop {
        tunnel_id: 0x2::object::ID,
        session_nonce: u64,
        requester: address,
        seed: vector<u8>,
    }

    fun derive_quantum_poker_seed(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        let v0 = b"sui_tunnel::quantum_poker::session_seed";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x2::hash::blake2b256(&v0)
    }

    entry fun entry_emit_quantum_poker_seed(arg0: &0x2::random::Random, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        let v2 = QuantumPokerRandomnessSeed{
            tunnel_id     : arg1,
            session_nonce : arg2,
            requester     : v0,
            seed          : derive_quantum_poker_seed(arg1, arg2, v0, 0x2::random::generate_bytes(&mut v1, 32), arg3),
        };
        0x2::event::emit<QuantumPokerRandomnessSeed>(v2);
    }

    // decompiled from Move bytecode v7
}

