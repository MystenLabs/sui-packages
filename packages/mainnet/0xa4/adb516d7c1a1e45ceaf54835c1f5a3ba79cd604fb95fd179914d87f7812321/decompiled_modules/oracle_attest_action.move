module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle_attest_action {
    struct AttestationCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        guardian_id: 0x2::object::ID,
        secp256k1_key: vector<u8>,
        timestamp_ms: u64,
    }

    struct AttestationResolved has copy, drop {
        oracle_id: 0x2::object::ID,
        secp256k1_key: vector<u8>,
        timestamp_ms: u64,
    }

    fun actuate(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::add_attestation(arg0, 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::new_attestation(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg2), arg5, arg3 * 1000), 0x2::clock::timestamp_ms(arg6));
        let v0 = AttestationCreated{
            oracle_id     : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg0),
            guardian_id   : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg2),
            secp256k1_key : arg5,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AttestationCreated>(v0);
        if (0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::valid_attestation_count(arg0, arg5) >= 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::min_attestations(arg1)) {
            0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::enable_oracle(arg0, arg5, arg4, 0x2::clock::timestamp_ms(arg6) + 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::oracle_validity_length_ms(arg1));
            let v1 = AttestationResolved{
                oracle_id     : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg0),
                secp256k1_key : arg5,
                timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<AttestationResolved>(v1);
        };
    }

    public entry fun run(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        validate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        actuate(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun validate(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::queue(arg2) == 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::guardian_queue_id(arg1), 9223372243013206017);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::expiration_time_ms(arg0) > 0x2::clock::timestamp_ms(arg7), 9223372255898238979);
        assert!(0x1::vector::length<u8>(&arg6) == 65, 9223372268783271941);
        assert!(arg3 * 1000 + 36000000 >= 0x2::clock::timestamp_ms(arg7), 9223372281668304903);
        let v0 = 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::hash::generate_attestation_msg(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::oracle_key(arg0), 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::queue_key(arg0), arg4, x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg3);
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg6, &v0, 1);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::secp256k1_key(arg2);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::hash::check_subvec(&v2, &v3, 1), 9223372363272814601);
    }

    // decompiled from Move bytecode v6
}

