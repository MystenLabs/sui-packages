module 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::savanna {
    struct Seat has copy, drop, store {
        weight: u64,
        key: 0x2::group_ops::Element<0x2::bls12381::G1>,
        raw: vector<u8>,
    }

    struct Policy has copy, drop, store {
        generation: u32,
        threshold: u64,
        seats: vector<Seat>,
    }

    struct FinalityInputs has copy, drop {
        major_version: u32,
        minor_version: u32,
        active_generation: u32,
        last_pending_generation: u32,
        finality_mroot: vector<u8>,
        last_pending_policy_digest: vector<u8>,
        last_pending_policy_start: u32,
        reversible_blocks_mroot: vector<u8>,
        qc_claim_block_num: u32,
        qc_claim_finality_digest: vector<u8>,
        qc_claim_timestamp: u32,
        timestamp: u32,
        base_digest: vector<u8>,
    }

    public fun active_generation(arg0: &FinalityInputs) : u32 {
        arg0.active_generation
    }

    fun be48(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 48;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v2));
        };
        v0
    }

    public fun bit(arg0: &vector<u8>, arg1: u64) : bool {
        arg1 / 8 < 0x1::vector::length<u8>(arg0) && *0x1::vector::borrow<u8>(arg0, arg1 / 8) >> ((arg1 % 8) as u8) & 1 == 1
    }

    public fun check_quorum(arg0: &Policy, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<Seat>(&arg0.seats);
        assert!(0x1::vector::length<u8>(arg1) == (v0 + 7) / 8, 5);
        if (v0 % 8 != 0) {
            assert!(*0x1::vector::borrow<u8>(arg1, 0x1::vector::length<u8>(arg1) - 1) >> ((v0 % 8) as u8) == 0, 5);
        };
        let v1 = 0x2::bls12381::g1_identity();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            if (*0x1::vector::borrow<u8>(arg1, v3 / 8) >> ((v3 % 8) as u8) & 1 == 1) {
                let v4 = 0x1::vector::borrow<Seat>(&arg0.seats, v3);
                let v5 = &v1;
                v1 = 0x2::bls12381::g1_add(v5, &v4.key);
                v2 = v2 + v4.weight;
            };
            v3 = v3 + 1;
        };
        assert!(v2 >= arg0.threshold, 6);
        verify_aggregate(&v1, arg2, arg3)
    }

    public fun compress_g1(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 96, 1);
        let v0 = be48(arg0, 0);
        let v1 = &mut v0;
        let v2 = be48(arg0, 48);
        set_flags(v1, gt_half_p(&v2));
        v0
    }

    public fun compress_g2(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 192, 1);
        let v0 = be48(arg0, 48);
        0x1::vector::append<u8>(&mut v0, be48(arg0, 0));
        let v1 = be48(arg0, 144);
        let v2 = if (is_zero(&v1)) {
            let v3 = be48(arg0, 96);
            gt_half_p(&v3)
        } else {
            gt_half_p(&v1)
        };
        let v4 = &mut v0;
        set_flags(v4, v2);
        v0
    }

    public fun finality_digest(arg0: &FinalityInputs) : vector<u8> {
        let v0 = arg0.reversible_blocks_mroot;
        0x1::vector::append<u8>(&mut v0, le32(arg0.qc_claim_block_num));
        0x1::vector::append<u8>(&mut v0, arg0.qc_claim_finality_digest);
        0x1::vector::append<u8>(&mut v0, le32(arg0.qc_claim_timestamp));
        0x1::vector::append<u8>(&mut v0, le32(arg0.timestamp));
        0x1::vector::append<u8>(&mut v0, arg0.base_digest);
        let v1 = arg0.last_pending_policy_digest;
        0x1::vector::append<u8>(&mut v1, le32(arg0.last_pending_policy_start));
        0x1::vector::append<u8>(&mut v1, 0x1::hash::sha2_256(v0));
        let v2 = le32(arg0.major_version);
        0x1::vector::append<u8>(&mut v2, le32(arg0.minor_version));
        0x1::vector::append<u8>(&mut v2, le32(arg0.active_generation));
        0x1::vector::append<u8>(&mut v2, le32(arg0.last_pending_generation));
        0x1::vector::append<u8>(&mut v2, arg0.finality_mroot);
        0x1::vector::append<u8>(&mut v2, 0x1::hash::sha2_256(v1));
        0x1::hash::sha2_256(v2)
    }

    public fun finality_inputs(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: vector<u8>, arg8: u32, arg9: vector<u8>, arg10: u32, arg11: u32, arg12: vector<u8>) : FinalityInputs {
        assert!(0x1::vector::length<u8>(&arg4) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg9) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg12) == 32, 1);
        FinalityInputs{
            major_version              : arg0,
            minor_version              : arg1,
            active_generation          : arg2,
            last_pending_generation    : arg3,
            finality_mroot             : arg4,
            last_pending_policy_digest : arg5,
            last_pending_policy_start  : arg6,
            reversible_blocks_mroot    : arg7,
            qc_claim_block_num         : arg8,
            qc_claim_finality_digest   : arg9,
            qc_claim_timestamp         : arg10,
            timestamp                  : arg11,
            base_digest                : arg12,
        }
    }

    public fun finality_mroot(arg0: &FinalityInputs) : vector<u8> {
        arg0.finality_mroot
    }

    public fun generation(arg0: &Policy) : u32 {
        arg0.generation
    }

    fun gt_half_p(arg0: &vector<u8>) : bool {
        let v0 = x"0d0088f51cbff34d258dd3db21a5d66bb23ba5c279c2895fb39869507b587b120f55ffff58a9ffffdcff7fffffffd555";
        let v1 = 0;
        while (v1 < 48) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(&v0, v1)) {
                return *0x1::vector::borrow<u8>(arg0, v1) > *0x1::vector::borrow<u8>(&v0, v1)
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun is_safe_threshold(arg0: u64, arg1: u128) : bool {
        let v0 = (arg0 as u128);
        if (v0 > 0) {
            if (v0 <= arg1) {
                v0 > arg1 / 2
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_zero(arg0: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (!(*0x1::vector::borrow<u8>(arg0, v0) == 0)) {
                v1 = false;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = true;
        v1
    }

    public fun last_pending_generation(arg0: &FinalityInputs) : u32 {
        arg0.last_pending_generation
    }

    public fun last_pending_policy_digest(arg0: &FinalityInputs) : vector<u8> {
        arg0.last_pending_policy_digest
    }

    public fun last_pending_policy_start(arg0: &FinalityInputs) : u32 {
        arg0.last_pending_policy_start
    }

    fun le32(arg0: u32) : vector<u8> {
        0x2::bcs::to_bytes<u32>(&arg0)
    }

    public fun major_version(arg0: &FinalityInputs) : u32 {
        arg0.major_version
    }

    public fun parse_policy(arg0: vector<u8>) : Policy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x1::vector::empty<Seat>();
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x2::bcs::peel_vec_length(&mut v0)) {
            0x2::bcs::peel_vec_u8(&mut v0);
            let v6 = 0x2::bcs::peel_u64(&mut v0);
            let v7 = 0x2::bcs::peel_vec_u8(&mut v0);
            assert!(!0x1::vector::contains<vector<u8>>(&v3, &v7), 3);
            let v8 = compress_g1(&v7);
            0x1::vector::push_back<vector<u8>>(&mut v3, v7);
            let v9 = Seat{
                weight : v6,
                key    : 0x2::bls12381::g1_from_bytes(&v8),
                raw    : v7,
            };
            0x1::vector::push_back<Seat>(&mut v2, v9);
            v4 = v4 + (v6 as u128);
            v5 = v5 + 1;
        };
        let v10 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v10), 2);
        assert!(is_safe_threshold(v1, v4), 4);
        Policy{
            generation : 0x2::bcs::peel_u32(&mut v0),
            threshold  : v1,
            seats      : v2,
        }
    }

    public fun qc_claim_timestamp(arg0: &FinalityInputs) : u32 {
        arg0.qc_claim_timestamp
    }

    public fun seat_key(arg0: &Seat) : 0x2::group_ops::Element<0x2::bls12381::G1> {
        arg0.key
    }

    public fun seat_raw(arg0: &Seat) : vector<u8> {
        arg0.raw
    }

    public fun seat_weight(arg0: &Seat) : u64 {
        arg0.weight
    }

    public fun seats(arg0: &Policy) : &vector<Seat> {
        &arg0.seats
    }

    fun set_flags(arg0: &mut vector<u8>, arg1: bool) {
        let v0 = 0x1::vector::borrow_mut<u8>(arg0, 0);
        *v0 = *v0 | 128;
        if (arg1) {
            *v0 = *v0 | 32;
        };
    }

    public fun size(arg0: &Policy) : u64 {
        0x1::vector::length<Seat>(&arg0.seats)
    }

    public fun threshold(arg0: &Policy) : u64 {
        arg0.threshold
    }

    public fun verify_aggregate(arg0: &0x2::group_ops::Element<0x2::bls12381::G1>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = compress_g2(arg1);
        0x2::bls12381::bls12381_min_pk_verify(&v0, 0x2::group_ops::bytes<0x2::bls12381::G1>(arg0), arg2)
    }

    // decompiled from Move bytecode v7
}

