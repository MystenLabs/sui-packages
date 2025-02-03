module 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa {
    struct VAA {
        guardian_set_index: u32,
        timestamp: u32,
        nonce: u32,
        emitter_chain: u16,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        sequence: u64,
        consistency_level: u8,
        payload: vector<u8>,
        digest: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32,
    }

    public fun consume(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs, arg1: &VAA) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::consume(arg0, digest(arg1));
    }

    public fun batch_id(arg0: &VAA) : u32 {
        nonce(arg0)
    }

    public fun compute_message_hash(arg0: &VAA) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.timestamp);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.nonce);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.emitter_chain);
        0x1::vector::append<u8>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.emitter_address));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.sequence);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.consistency_level);
        0x1::vector::append<u8>(&mut v0, arg0.payload);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(0x2::hash::keccak256(&v0))
    }

    public fun consistency_level(arg0: &VAA) : u8 {
        arg0.consistency_level
    }

    public fun digest(arg0: &VAA) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        arg0.digest
    }

    fun double_keccak256(arg0: vector<u8>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        let v0 = 0x2::hash::keccak256(&arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(0x2::hash::keccak256(&v0))
    }

    public fun emitter_address(arg0: &VAA) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.emitter_address
    }

    public fun emitter_chain(arg0: &VAA) : u16 {
        arg0.emitter_chain
    }

    public fun emitter_info(arg0: &VAA) : (u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, u64) {
        (arg0.emitter_chain, arg0.emitter_address, arg0.sequence)
    }

    public fun finality(arg0: &VAA) : u8 {
        consistency_level(arg0)
    }

    public fun guardian_set_index(arg0: &VAA) : u32 {
        arg0.guardian_set_index
    }

    public fun nonce(arg0: &VAA) : u32 {
        arg0.nonce
    }

    fun parse(arg0: vector<u8>) : (vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>, VAA) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 0);
        let v1 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>();
        let v2 = 0;
        while (v2 < 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0)) {
            0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>(&mut v1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::take_bytes(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0)));
            v2 = v2 + 1;
        };
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
        let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v3);
        let v5 = VAA{
            guardian_set_index : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u32_be(&mut v0),
            timestamp          : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u32_be(&mut v4),
            nonce              : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u32_be(&mut v4),
            emitter_chain      : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v4),
            emitter_address    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(&mut v4),
            sequence           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v4),
            consistency_level  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v4),
            payload            : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4),
            digest             : double_keccak256(v3),
        };
        (v1, v5)
    }

    public fun parse_and_verify(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : VAA {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::assert_latest_only(arg0);
        let (v0, v1) = parse(arg1);
        let v2 = v1;
        verify_signatures(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::guardian_set_at(arg0, v2.guardian_set_index), v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(compute_message_hash(&v2)), arg2);
        v2
    }

    public fun payload(arg0: &VAA) : vector<u8> {
        arg0.payload
    }

    public fun sequence(arg0: &VAA) : u64 {
        arg0.sequence
    }

    public fun take_emitter_info_and_payload(arg0: VAA) : (u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, vector<u8>) {
        let VAA {
            guardian_set_index : _,
            timestamp          : _,
            nonce              : _,
            emitter_chain      : v3,
            emitter_address    : v4,
            sequence           : _,
            consistency_level  : _,
            payload            : v7,
            digest             : _,
        } = arg0;
        (v3, v4, v7)
    }

    public fun take_payload(arg0: VAA) : vector<u8> {
        let (_, _, v2) = take_emitter_info_and_payload(arg0);
        v2
    }

    public fun timestamp(arg0: &VAA) : u32 {
        arg0.timestamp
    }

    fun verify_signatures(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_set::GuardianSet, arg1: vector<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_set::is_active(arg0, arg3), 3);
        assert!(0x1::vector::length<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>(&arg1) >= 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_set::quorum(arg0), 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>(arg1);
        let v1 = 0x1::option::none<u64>();
        while (!0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::is_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>(&v0)) {
            let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::poke<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>(&mut v0);
            let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::index_as_u64(&v2);
            assert!(0x1::option::is_none<u64>(&v1) || v3 > *0x1::option::borrow<u64>(&v1), 4);
            assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian::verify(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_set::guardian_at(arg0, v3), v2, arg2), 2);
            0x1::option::swap_or_fill<u64>(&mut v1, v3);
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::guardian_signature::GuardianSignature>(v0);
    }

    // decompiled from Move bytecode v6
}

