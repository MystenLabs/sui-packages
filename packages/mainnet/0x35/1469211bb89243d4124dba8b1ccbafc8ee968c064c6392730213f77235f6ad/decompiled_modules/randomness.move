module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::randomness {
    struct Seed has copy, drop, store {
        bytes: vector<u8>,
        counter: u64,
    }

    struct Commitment has copy, drop, store {
        hash: vector<u8>,
        committer: address,
        timestamp: u64,
    }

    struct Reveal has copy, drop, store {
        value: vector<u8>,
        salt: vector<u8>,
    }

    struct CombinedRandomness has copy, drop, store {
        seed: Seed,
        commitment_a: Commitment,
        commitment_b: Commitment,
        finalized: bool,
    }

    fun bytes_to_u128(arg0: &vector<u8>) : u128 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1 + 8));
            v1 = v1 + 1;
        };
        (bytes_to_u64(arg0) as u128) << 64 | (bytes_to_u64(&v0) as u128)
    }

    fun bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 16) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1 + 16));
            v1 = v1 + 1;
        };
        let v2 = b"";
        let v3 = 0;
        while (v3 < 8) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, v3 + 8));
            v3 = v3 + 1;
        };
        (bytes_to_u128(arg0) as u256) << 128 | (((bytes_to_u64(&v0) as u128) << 64 | (bytes_to_u64(&v2) as u128)) as u256)
    }

    public fun bytes_to_u64(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 13906836553755262977);
        (*0x1::vector::borrow<u8>(arg0, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, 3) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 7) as u64)
    }

    public fun combine_reveals(arg0: &Reveal, arg1: &Reveal) : Seed {
        let v0 = b"sui_tunnel::randomness::commit_reveal";
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg0.value)));
        0x1::vector::append<u8>(&mut v0, arg0.value);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg0.salt)));
        0x1::vector::append<u8>(&mut v0, arg0.salt);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg1.value)));
        0x1::vector::append<u8>(&mut v0, arg1.value);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg1.salt)));
        0x1::vector::append<u8>(&mut v0, arg1.salt);
        Seed{
            bytes   : 0x2::hash::blake2b256(&v0),
            counter : 0,
        }
    }

    public fun combined_seed(arg0: &CombinedRandomness) : &Seed {
        assert!(arg0.finalized, 13906836476446507019);
        &arg0.seed
    }

    public fun commitment_committer(arg0: &Commitment) : address {
        arg0.committer
    }

    public fun commitment_hash(arg0: &Commitment) : &vector<u8> {
        &arg0.hash
    }

    public fun commitment_timestamp(arg0: &Commitment) : u64 {
        arg0.timestamp
    }

    public fun create_combined_randomness(arg0: Commitment, arg1: Commitment) : CombinedRandomness {
        let v0 = Seed{
            bytes   : b"",
            counter : 0,
        };
        CombinedRandomness{
            seed         : v0,
            commitment_a : arg0,
            commitment_b : arg1,
            finalized    : false,
        }
    }

    public fun create_commitment(arg0: &vector<u8>, arg1: &vector<u8>, arg2: address, arg3: u64) : Commitment {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 13906835888035332097);
        let v0 = b"sui_tunnel::randomness::commit_reveal";
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg0)));
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg1)));
        0x1::vector::append<u8>(&mut v0, *arg1);
        Commitment{
            hash      : 0x2::hash::blake2b256(&v0),
            committer : arg2,
            timestamp : arg3,
        }
    }

    fun create_domain_message(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        arg0
    }

    public fun create_reveal(arg0: vector<u8>, arg1: vector<u8>) : Reveal {
        Reveal{
            value : arg0,
            salt  : arg1,
        }
    }

    public fun draw_from_vector<T0: drop>(arg0: &Seed, arg1: &mut vector<T0>) : (T0, Seed) {
        let v0 = 0x1::vector::length<T0>(arg1);
        assert!(v0 > 0, 13906835668992131075);
        let (v1, v2) = select_index(arg0, v0);
        (0x1::vector::swap_remove<T0>(arg1, v1), v2)
    }

    public fun finalize_combined_randomness(arg0: &mut CombinedRandomness, arg1: &Reveal, arg2: &Reveal) {
        assert!(!arg0.finalized, 13906836231633108999);
        assert!(verify_commitment(&arg0.commitment_a, arg1), 13906836244518141961);
        assert!(verify_commitment(&arg0.commitment_b, arg2), 13906836248813109257);
        arg0.seed = combine_reveals(arg1, arg2);
        arg0.finalized = true;
    }

    public(friend) fun from_bls_signature(arg0: &vector<u8>, arg1: &vector<u8>) : Seed {
        let v0 = b"sui_tunnel::randomness::bls";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        Seed{
            bytes   : 0x2::hash::blake2b256(&v0),
            counter : 0,
        }
    }

    public(friend) fun from_bytes(arg0: vector<u8>) : Seed {
        let v0 = create_domain_message(b"sui_tunnel::randomness::chain", arg0);
        Seed{
            bytes   : 0x2::hash::blake2b256(&v0),
            counter : 0,
        }
    }

    public fun from_tunnel_context(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) : Seed {
        let v0 = b"sui_tunnel::randomness::tunnel_context";
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg0)));
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg2)));
        0x1::vector::append<u8>(&mut v0, arg2);
        Seed{
            bytes   : 0x2::hash::blake2b256(&v0),
            counter : 0,
        }
    }

    public fun from_verified_bls_min_pk(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : Seed {
        assert!(0x2::bls12381::bls12381_min_pk_verify(arg2, arg0, arg1), 13906835050516971525);
        from_bls_signature(arg1, arg2)
    }

    public fun from_verified_bls_min_sig(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : Seed {
        assert!(0x2::bls12381::bls12381_min_sig_verify(arg2, arg0, arg1), 13906834964617625605);
        from_bls_signature(arg1, arg2)
    }

    public fun is_finalized(arg0: &CombinedRandomness) : bool {
        arg0.finalized
    }

    public fun next_seed(arg0: &Seed) : Seed {
        let v0 = b"sui_tunnel::randomness::chain";
        0x1::vector::append<u8>(&mut v0, arg0.bytes);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(arg0.counter));
        Seed{
            bytes   : 0x2::hash::blake2b256(&v0),
            counter : 0,
        }
    }

    public fun next_u128(arg0: &Seed) : (u128, Seed) {
        let v0 = next_seed(arg0);
        let v1 = Seed{
            bytes   : v0.bytes,
            counter : v0.counter + 1,
        };
        (bytes_to_u128(&v0.bytes), v1)
    }

    public fun next_u256(arg0: &Seed) : (u256, Seed) {
        let v0 = next_seed(arg0);
        let v1 = Seed{
            bytes   : v0.bytes,
            counter : v0.counter + 1,
        };
        (bytes_to_u256(&v0.bytes), v1)
    }

    public fun next_u64(arg0: &Seed) : (u64, Seed) {
        let v0 = next_seed(arg0);
        let v1 = Seed{
            bytes   : v0.bytes,
            counter : v0.counter + 1,
        };
        (bytes_to_u64(&v0.bytes), v1)
    }

    public fun next_u64_in_range(arg0: &Seed, arg1: u64, arg2: u64) : (u64, Seed) {
        assert!(arg1 < arg2, 13906835471424290829);
        let v0 = arg2 - arg1;
        if (v0 == 1) {
            let v1 = next_seed(arg0);
            let v2 = Seed{
                bytes   : v1.bytes,
                counter : v1.counter + 1,
            };
            return (arg1, v2)
        };
        let v3 = 18446744073709551615;
        let v4 = (v3 % v0 + 1) % v0;
        let v5 = if (v4 == 0) {
            0
        } else {
            v3 - v4 + 1
        };
        let v6 = *arg0;
        let v7;
        loop {
            v6 = next_seed(&v6);
            v7 = bytes_to_u64(&v6.bytes);
            if (v5 == 0 || v7 < v5) {
                break
            };
        };
        let v8 = Seed{
            bytes   : v6.bytes,
            counter : v6.counter + 1,
        };
        (v7 % v0 + arg1, v8)
    }

    public fun next_u8_in_range(arg0: &Seed, arg1: u8, arg2: u8) : (u8, Seed) {
        assert!(arg1 < arg2, 13906835432769585165);
        let (v0, v1) = next_u64_in_range(arg0, (arg1 as u64), (arg2 as u64));
        ((v0 as u8), v1)
    }

    public fun reveal_salt(arg0: &Reveal) : &vector<u8> {
        &arg0.salt
    }

    public fun reveal_value(arg0: &Reveal) : &vector<u8> {
        &arg0.value
    }

    public fun seed_bytes(arg0: &Seed) : &vector<u8> {
        &arg0.bytes
    }

    public fun seed_counter(arg0: &Seed) : u64 {
        arg0.counter
    }

    public fun select_index(arg0: &Seed, arg1: u64) : (u64, Seed) {
        assert!(arg1 > 0, 13906835617452523523);
        next_u64_in_range(arg0, 0, arg1)
    }

    public fun shuffle<T0>(arg0: &Seed, arg1: &mut vector<T0>) : Seed {
        let v0 = 0x1::vector::length<T0>(arg1);
        if (v0 <= 1) {
            return *arg0
        };
        let v1 = *arg0;
        let v2 = v0 - 1;
        while (v2 > 0) {
            let (v3, v4) = next_u64_in_range(&v1, 0, v2 + 1);
            v1 = v4;
            if (v2 != v3) {
                0x1::vector::swap<T0>(arg1, v2, v3);
            };
            v2 = v2 - 1;
        };
        v1
    }

    public fun verify_commitment(arg0: &Commitment, arg1: &Reveal) : bool {
        let v0 = b"sui_tunnel::randomness::commit_reveal";
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg1.value)));
        0x1::vector::append<u8>(&mut v0, arg1.value);
        0x1::vector::append<u8>(&mut v0, 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg1.salt)));
        0x1::vector::append<u8>(&mut v0, arg1.salt);
        0x2::hash::blake2b256(&v0) == arg0.hash
    }

    // decompiled from Move bytecode v7
}

