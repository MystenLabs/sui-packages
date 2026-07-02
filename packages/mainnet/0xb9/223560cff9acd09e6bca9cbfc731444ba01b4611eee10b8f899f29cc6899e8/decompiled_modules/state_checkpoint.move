module 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::state_checkpoint {
    struct CheckpointBody has copy, drop {
        seq: u64,
        prev_chain_hash: vector<u8>,
        state_root: vector<u8>,
        seat_stacks: vector<u64>,
        pot: u64,
        rake_so_far: u64,
        signer_bitmap: u64,
    }

    struct CheckpointPosted has copy, drop {
        hand_id: 0x2::object::ID,
        seq: u64,
        state_root: vector<u8>,
        chain_hash: vector<u8>,
        seat_stacks: vector<u64>,
        pot: u64,
        rake_so_far: u64,
        signer_bitmap: u64,
        created_at_ms: u64,
    }

    fun assert_signature_lengths(arg0: &vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v0)) == 64, 607);
            v0 = v0 + 1;
        };
    }

    public fun compute_chain_hash(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = CheckpointBody{
            seq             : arg0,
            prev_chain_hash : arg1,
            state_root      : arg2,
            seat_stacks     : arg3,
            pot             : arg4,
            rake_so_far     : arg5,
            signer_bitmap   : arg6,
        };
        let v1 = 0x2::bcs::to_bytes<CheckpointBody>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    fun popcount_u64(arg0: u64) : u64 {
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + (arg0 & 1);
            arg0 = arg0 >> 1;
        };
        v0
    }

    public fun post_checkpoint(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::HandAnchor, arg1: &0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry, arg2: u64, arg3: vector<u8>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::assert_coordinator(arg1, arg10);
        assert!(0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::registry_id(arg0) == 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry>(arg1), 608);
        assert!(0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::is_active(arg0), 601);
        assert!(arg2 == 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::last_checkpoint_seq(arg0) + 1, 602);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 603);
        assert!(0x1::vector::length<u64>(&arg4) == 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::player_count(arg0), 604);
        assert!(arg7 > 0, 605);
        assert!(0x1::vector::length<vector<u8>>(&arg8) == popcount_u64(arg7), 606);
        assert_signature_lengths(&arg8);
        let v0 = 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::new_checkpoint(arg2, arg3, arg4, arg5, arg6, compute_chain_hash(arg2, 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::prev_chain_hash(arg0), arg3, arg4, arg5, arg6, arg7), arg7, arg8, 0x2::clock::timestamp_ms(arg9));
        let v1 = CheckpointPosted{
            hand_id       : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::hand_id(arg0),
            seq           : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_seq(&v0),
            state_root    : *0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_state_root(&v0),
            chain_hash    : *0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_chain_hash(&v0),
            seat_stacks   : *0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_seat_stacks(&v0),
            pot           : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_pot(&v0),
            rake_so_far   : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_rake_so_far(&v0),
            signer_bitmap : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_signer_bitmap(&v0),
            created_at_ms : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::cp_created_at_ms(&v0),
        };
        0x2::event::emit<CheckpointPosted>(v1);
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor::set_latest_checkpoint(arg0, v0);
    }

    // decompiled from Move bytecode v7
}

