module 0xbc0ffc154c5d6b1d4de3b8ed2d306b9530e79d9428916ad657c705d6088f235d::wire {
    struct Header has copy, drop {
        version: u8,
        chain_id: u64,
        receiver: vector<u8>,
    }

    struct SwapIntent has copy, drop {
        intent_nonce: u64,
        intent_hash: vector<u8>,
        escrow_id: u64,
        src_user: vector<u8>,
        expiry_time: u64,
        input_token: vector<u8>,
        input_amount: u256,
        dst_token: vector<u8>,
        min_dst_amount: u256,
        dst_recipient: vector<u8>,
    }

    struct Fulfilled has copy, drop {
        intent_hash: vector<u8>,
        claim_target: vector<u8>,
        solver: vector<u8>,
        fulfill_amount: u256,
        swap_intent_digest: vector<u8>,
    }

    struct Voided has copy, drop {
        intent_nonce: u64,
        escrow_id: u64,
        escrow_user: vector<u8>,
        expiry_time: u64,
        swap_intent_digest: vector<u8>,
    }

    public fun address_to_raw(arg0: address) : vector<u8> {
        0x2::address::to_bytes(arg0)
    }

    public fun decode_fulfilled(arg0: &vector<u8>) : Fulfilled {
        let (v0, v1) = read_u8(arg0, 41);
        assert!(v0 == 1, 4);
        let (v2, v3) = read_bytes(arg0, v1, 32);
        let (v4, v5) = read_bytes(arg0, v3, 32);
        let (v6, v7) = read_bytes(arg0, v5, 32);
        let (v8, v9) = read_u256_be(arg0, v7);
        let (v10, v11) = read_bytes(arg0, v9, 32);
        assert!(v11 == 0x1::vector::length<u8>(arg0), 2);
        Fulfilled{
            intent_hash        : v2,
            claim_target       : v4,
            solver             : v6,
            fulfill_amount     : v8,
            swap_intent_digest : v10,
        }
    }

    public fun decode_header(arg0: &vector<u8>) : Header {
        assert!(0x1::vector::length<u8>(arg0) >= 41, 1);
        let (v0, v1) = read_u8(arg0, 0);
        let (v2, v3) = read_u64_be(arg0, v1);
        let (v4, _) = read_bytes(arg0, v3, 32);
        Header{
            version  : v0,
            chain_id : v2,
            receiver : v4,
        }
    }

    public fun decode_swap_intent(arg0: &vector<u8>) : SwapIntent {
        let (v0, v1) = read_u8(arg0, 41);
        assert!(v0 == 0, 4);
        let (v2, v3) = read_u64_be(arg0, v1);
        let (v4, v5) = read_bytes(arg0, v3, 32);
        let (v6, v7) = read_u64_be(arg0, v5);
        let (v8, v9) = read_bytes(arg0, v7, 32);
        let (v10, v11) = read_u64_be(arg0, v9);
        let (v12, v13) = read_token(arg0, v11);
        let (v14, v15) = read_u256_be(arg0, v13);
        let (v16, v17) = read_token(arg0, v15);
        let (v18, v19) = read_u256_be(arg0, v17);
        let (v20, v21) = read_bytes(arg0, v19, 32);
        assert!(v21 == 0x1::vector::length<u8>(arg0), 2);
        SwapIntent{
            intent_nonce   : v2,
            intent_hash    : v4,
            escrow_id      : v6,
            src_user       : v8,
            expiry_time    : v10,
            input_token    : v12,
            input_amount   : v14,
            dst_token      : v16,
            min_dst_amount : v18,
            dst_recipient  : v20,
        }
    }

    public fun decode_voided(arg0: &vector<u8>) : Voided {
        let (v0, v1) = read_u8(arg0, 41);
        assert!(v0 == 2, 4);
        let (v2, v3) = read_u64_be(arg0, v1);
        let (v4, v5) = read_u64_be(arg0, v3);
        let (v6, v7) = read_bytes(arg0, v5, 32);
        let (v8, v9) = read_u64_be(arg0, v7);
        let (v10, v11) = read_bytes(arg0, v9, 32);
        assert!(v11 == 0x1::vector::length<u8>(arg0), 2);
        Voided{
            intent_nonce       : v2,
            escrow_id          : v4,
            escrow_user        : v6,
            expiry_time        : v8,
            swap_intent_digest : v10,
        }
    }

    public fun encode_fulfilled(arg0: u64, arg1: &vector<u8>, arg2: &Fulfilled) : vector<u8> {
        let v0 = encode_header(arg0, arg1);
        let v1 = &mut v0;
        write_u8(v1, 1);
        let v2 = &mut v0;
        write_bytes32(v2, &arg2.intent_hash);
        let v3 = &mut v0;
        write_bytes32(v3, &arg2.claim_target);
        let v4 = &mut v0;
        write_bytes32(v4, &arg2.solver);
        let v5 = &mut v0;
        write_u256_be(v5, arg2.fulfill_amount);
        let v6 = &mut v0;
        write_bytes32(v6, &arg2.swap_intent_digest);
        v0
    }

    public fun encode_header(arg0: u64, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 3);
        let v1 = &mut v0;
        write_u64_be(v1, arg0);
        let v2 = &mut v0;
        write_bytes32(v2, arg1);
        v0
    }

    public fun encode_swap_intent(arg0: u64, arg1: &vector<u8>, arg2: &SwapIntent) : vector<u8> {
        let v0 = encode_header(arg0, arg1);
        let v1 = &mut v0;
        write_u8(v1, 0);
        let v2 = &mut v0;
        write_u64_be(v2, arg2.intent_nonce);
        let v3 = &mut v0;
        write_bytes32(v3, &arg2.intent_hash);
        let v4 = &mut v0;
        write_u64_be(v4, arg2.escrow_id);
        let v5 = &mut v0;
        write_bytes32(v5, &arg2.src_user);
        let v6 = &mut v0;
        write_u64_be(v6, arg2.expiry_time);
        0x1::vector::append<u8>(&mut v0, arg2.input_token);
        let v7 = &mut v0;
        write_u256_be(v7, arg2.input_amount);
        0x1::vector::append<u8>(&mut v0, arg2.dst_token);
        let v8 = &mut v0;
        write_u256_be(v8, arg2.min_dst_amount);
        let v9 = &mut v0;
        write_bytes32(v9, &arg2.dst_recipient);
        v0
    }

    public fun encode_voided(arg0: u64, arg1: &vector<u8>, arg2: &Voided) : vector<u8> {
        let v0 = encode_header(arg0, arg1);
        let v1 = &mut v0;
        write_u8(v1, 2);
        let v2 = &mut v0;
        write_u64_be(v2, arg2.intent_nonce);
        let v3 = &mut v0;
        write_u64_be(v3, arg2.escrow_id);
        let v4 = &mut v0;
        write_bytes32(v4, &arg2.escrow_user);
        let v5 = &mut v0;
        write_u64_be(v5, arg2.expiry_time);
        let v6 = &mut v0;
        write_bytes32(v6, &arg2.swap_intent_digest);
        v0
    }

    public fun f_claim_target(arg0: &Fulfilled) : &vector<u8> {
        &arg0.claim_target
    }

    public fun f_fulfill_amount(arg0: &Fulfilled) : u256 {
        arg0.fulfill_amount
    }

    public fun f_intent_hash(arg0: &Fulfilled) : &vector<u8> {
        &arg0.intent_hash
    }

    public fun f_solver(arg0: &Fulfilled) : &vector<u8> {
        &arg0.solver
    }

    public fun f_swap_intent_digest(arg0: &Fulfilled) : &vector<u8> {
        &arg0.swap_intent_digest
    }

    public fun finality_finalized() : u32 {
        2000
    }

    public fun header_chain_id(arg0: &Header) : u64 {
        arg0.chain_id
    }

    public fun header_receiver(arg0: &Header) : &vector<u8> {
        &arg0.receiver
    }

    public fun header_version(arg0: &Header) : u8 {
        arg0.version
    }

    public fun inbox_msg_hash(arg0: u64, arg1: u32, arg2: &vector<u8>, arg3: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        let v1 = &mut v0;
        write_u64_be(v1, arg0);
        let v2 = &mut v0;
        write_u32_be(v2, arg1);
        let v3 = &mut v0;
        write_bytes32(v3, arg2);
        0x1::vector::append<u8>(&mut v0, *arg3);
        0x1::hash::sha2_256(v0)
    }

    public fun intent_hash(arg0: u64, arg1: u64, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: &vector<u8>, arg6: u64, arg7: &vector<u8>, arg8: u256, arg9: &vector<u8>, arg10: u256, arg11: u256) : vector<u8> {
        let v0 = b"gum:intent:v1";
        let v1 = &mut v0;
        write_u64_be(v1, arg0);
        let v2 = &mut v0;
        write_u64_be(v2, arg1);
        let v3 = &mut v0;
        write_u64_be(v3, arg2);
        let v4 = &mut v0;
        write_bytes32(v4, arg3);
        let v5 = &mut v0;
        write_u64_be(v5, arg4);
        let v6 = &mut v0;
        write_bytes32(v6, arg5);
        let v7 = &mut v0;
        write_u64_be(v7, arg6);
        let v8 = &mut v0;
        write_bytes32(v8, arg7);
        let v9 = &mut v0;
        write_u256_be(v9, arg8);
        let v10 = &mut v0;
        write_bytes32(v10, arg9);
        let v11 = &mut v0;
        write_u256_be(v11, arg10);
        let v12 = &mut v0;
        write_u256_be(v12, arg11);
        assert!(0x1::vector::length<u8>(&v0) == 277, 7);
        0x1::hash::sha2_256(v0)
    }

    public fun is_deliverable_to(arg0: &Header, arg1: u64, arg2: &vector<u8>) : bool {
        if (arg0.version == 3) {
            if (arg0.chain_id == arg1) {
                &arg0.receiver == arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun message_version() : u8 {
        3
    }

    public fun new_fulfilled(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u256, arg4: vector<u8>) : Fulfilled {
        let v0 = if (0x1::vector::length<u8>(&arg0) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                if (0x1::vector::length<u8>(&arg1) == 32) {
                    0x1::vector::length<u8>(&arg2) == 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        Fulfilled{
            intent_hash        : arg0,
            claim_target       : arg1,
            solver             : arg2,
            fulfill_amount     : arg3,
            swap_intent_digest : arg4,
        }
    }

    public fun new_swap_intent(arg0: u64, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: u256, arg9: vector<u8>) : SwapIntent {
        let v0 = if (0x1::vector::length<u8>(&arg1) == 32) {
            if (0x1::vector::length<u8>(&arg3) == 32) {
                0x1::vector::length<u8>(&arg9) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        SwapIntent{
            intent_nonce   : arg0,
            intent_hash    : arg1,
            escrow_id      : arg2,
            src_user       : arg3,
            expiry_time    : arg4,
            input_token    : arg5,
            input_amount   : arg6,
            dst_token      : arg7,
            min_dst_amount : arg8,
            dst_recipient  : arg9,
        }
    }

    public fun new_voided(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<u8>) : Voided {
        assert!(0x1::vector::length<u8>(&arg2) == 32 && 0x1::vector::length<u8>(&arg4) == 32, 7);
        Voided{
            intent_nonce       : arg0,
            escrow_id          : arg1,
            escrow_user        : arg2,
            expiry_time        : arg3,
            swap_intent_digest : arg4,
        }
    }

    public fun payload_tag(arg0: &vector<u8>) : u8 {
        let (v0, _) = read_u8(arg0, 41);
        v0
    }

    public fun raw_to_address(arg0: &vector<u8>) : address {
        assert!(0x1::vector::length<u8>(arg0) == 32, 7);
        0x2::address::from_bytes(*arg0)
    }

    fun read_bytes(arg0: &vector<u8>, arg1: u64, arg2: u64) : (vector<u8>, u64) {
        assert!(arg1 + arg2 <= 0x1::vector::length<u8>(arg0), 1);
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        (v0, arg1 + arg2)
    }

    fun read_token(arg0: &vector<u8>, arg1: u64) : (vector<u8>, u64) {
        let (v0, _) = read_u8(arg0, arg1);
        let (v2, v3) = token_shape(arg0, arg1, v0);
        read_bytes(arg0, arg1, v2 + v3)
    }

    fun read_u256_be(arg0: &vector<u8>, arg1: u64) : (u256, u64) {
        assert!(arg1 + 32 <= 0x1::vector::length<u8>(arg0), 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        (v0, arg1 + 32)
    }

    fun read_u64_be(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        assert!(arg1 + 8 <= 0x1::vector::length<u8>(arg0), 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        (v0, arg1 + 8)
    }

    fun read_u8(arg0: &vector<u8>, arg1: u64) : (u8, u64) {
        assert!(arg1 < 0x1::vector::length<u8>(arg0), 1);
        (*0x1::vector::borrow<u8>(arg0, arg1), arg1 + 1)
    }

    public fun si_dst_recipient(arg0: &SwapIntent) : &vector<u8> {
        &arg0.dst_recipient
    }

    public fun si_dst_token(arg0: &SwapIntent) : &vector<u8> {
        &arg0.dst_token
    }

    public fun si_escrow_id(arg0: &SwapIntent) : u64 {
        arg0.escrow_id
    }

    public fun si_expiry_time(arg0: &SwapIntent) : u64 {
        arg0.expiry_time
    }

    public fun si_input_amount(arg0: &SwapIntent) : u256 {
        arg0.input_amount
    }

    public fun si_input_token(arg0: &SwapIntent) : &vector<u8> {
        &arg0.input_token
    }

    public fun si_intent_hash(arg0: &SwapIntent) : &vector<u8> {
        &arg0.intent_hash
    }

    public fun si_intent_nonce(arg0: &SwapIntent) : u64 {
        arg0.intent_nonce
    }

    public fun si_min_dst_amount(arg0: &SwapIntent) : u256 {
        arg0.min_dst_amount
    }

    public fun si_src_user(arg0: &SwapIntent) : &vector<u8> {
        &arg0.src_user
    }

    public fun sui_token<T0>() : vector<u8> {
        let v0 = sui_token_payload<T0>();
        assert!(0x1::vector::length<u8>(&v0) >= 32 && 0x1::vector::length<u8>(&v0) <= 128, 6);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, 3);
        0x1::vector::push_back<u8>(v2, (0x1::vector::length<u8>(&v0) as u8));
        0x1::vector::append<u8>(&mut v1, v0);
        v1
    }

    public fun sui_token_payload<T0>() : vector<u8> {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let (v1, _) = read_bytes(&v0, 0, 64);
        let v3 = 0x2::hex::decode(v1);
        let (v4, _) = read_bytes(&v0, 64, 0x1::vector::length<u8>(&v0) - 64);
        0x1::vector::append<u8>(&mut v3, v4);
        v3
    }

    public fun swap_intent_digest(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"gum:swap-intent:v1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::hash::sha2_256(v0)
    }

    public fun tag_fulfilled() : u8 {
        1
    }

    public fun tag_swap_intent() : u8 {
        0
    }

    public fun tag_voided() : u8 {
        2
    }

    public fun token_hash(arg0: &vector<u8>) : vector<u8> {
        validate_token(arg0);
        let v0 = if (*0x1::vector::borrow<u8>(arg0, 0) == 3) {
            2
        } else {
            1
        };
        let (v1, _) = read_bytes(arg0, v0, 0x1::vector::length<u8>(arg0) - v0);
        0x1::hash::sha2_256(v1)
    }

    fun token_shape(arg0: &vector<u8>, arg1: u64, arg2: u8) : (u64, u64) {
        if (arg2 == 1 || arg2 == 4) {
            (1, 20)
        } else if (arg2 == 2) {
            (1, 32)
        } else {
            assert!(arg2 == 3, 5);
            let (v2, _) = read_u8(arg0, arg1 + 1);
            assert!(v2 >= 32 && v2 <= 128, 6);
            (2, (v2 as u64))
        }
    }

    public fun v_escrow_id(arg0: &Voided) : u64 {
        arg0.escrow_id
    }

    public fun v_escrow_user(arg0: &Voided) : &vector<u8> {
        &arg0.escrow_user
    }

    public fun v_expiry_time(arg0: &Voided) : u64 {
        arg0.expiry_time
    }

    public fun v_intent_nonce(arg0: &Voided) : u64 {
        arg0.intent_nonce
    }

    public fun v_swap_intent_digest(arg0: &Voided) : &vector<u8> {
        &arg0.swap_intent_digest
    }

    public fun validate_token(arg0: &vector<u8>) {
        let (v0, _) = read_u8(arg0, 0);
        let (v2, v3) = token_shape(arg0, 0, v0);
        assert!(0x1::vector::length<u8>(arg0) == v2 + v3, 6);
    }

    public fun write_bytes32(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 7);
        0x1::vector::append<u8>(arg0, *arg1);
    }

    public fun write_u256_be(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 32;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> v1 * 8 & 255) as u8));
        };
    }

    public fun write_u32_be(arg0: &mut vector<u8>, arg1: u32) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    public fun write_u64_be(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 8;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> v1 * 8 & 255) as u8));
        };
    }

    public fun write_u8(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

