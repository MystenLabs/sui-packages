module 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::utils {
    struct SignaturePayload has copy, drop {
        target: address,
        receiver: address,
        amount: u64,
        expiry: u64,
        nonce: u128,
    }

    struct Signature has copy, drop {
        sig: vector<u8>,
        pk: vector<u8>,
        scheme: u8,
    }

    public fun convert_to_usdc_base(arg0: u128) : u64 {
        ((arg0 / 1000) as u64)
    }

    public fun decode_payload(arg0: vector<u8>) : (address, address, u64, u64, u128) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = SignaturePayload{
            target   : 0x2::bcs::peel_address(&mut v0),
            receiver : 0x2::bcs::peel_address(&mut v0),
            amount   : 0x2::bcs::peel_u64(&mut v0),
            expiry   : 0x2::bcs::peel_u64(&mut v0),
            nonce    : 0x2::bcs::peel_u128(&mut v0),
        };
        (v1.target, v1.receiver, v1.amount, v1.expiry, v1.nonce)
    }

    public fun payload_amount(arg0: SignaturePayload) : u64 {
        arg0.amount
    }

    public fun payload_nonce(arg0: SignaturePayload) : u128 {
        arg0.nonce
    }

    public fun payload_receiver(arg0: SignaturePayload) : address {
        arg0.receiver
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: address, arg4: &0x2::clock::Clock) : SignaturePayload {
        assert!(0x1::vector::length<u8>(&arg0) == 96, 3000);
        assert!(0x1::vector::length<u8>(&arg1) == 99 || 0x1::vector::length<u8>(&arg1) == 100, 3000);
        let v0 = 0x2::bcs::new(arg0);
        let v1 = SignaturePayload{
            target   : 0x2::bcs::peel_address(&mut v0),
            receiver : 0x2::bcs::peel_address(&mut v0),
            amount   : 0x2::bcs::peel_u64(&mut v0),
            expiry   : 0x2::bcs::peel_u64(&mut v0),
            nonce    : 0x2::bcs::peel_u128(&mut v0),
        };
        let v2 = 0x2::bcs::new(arg1);
        let v3 = Signature{
            sig    : 0x2::bcs::peel_vec_u8(&mut v2),
            pk     : 0x2::bcs::peel_vec_u8(&mut v2),
            scheme : 0x2::bcs::peel_u8(&mut v2),
        };
        assert!(v1.expiry == 0 || v1.expiry > 0x2::clock::timestamp_ms(arg4), 3004);
        let v4 = 0x1::hash::sha2_256(arg0);
        if (v3.scheme == 0) {
            assert!(0x2::ecdsa_k1::secp256k1_verify(&v3.sig, &v3.pk, &v4, 1), 3005);
            0x1::vector::insert<u8>(&mut v3.pk, 1, 0);
        } else {
            assert!(v3.scheme == 1, 3001);
            assert!(0x2::ed25519::ed25519_verify(&v3.sig, &v3.pk, &v4), 3005);
            0x1::vector::insert<u8>(&mut v3.pk, 0, 0);
        };
        assert!(0x2::hash::blake2b256(&v3.pk) == 0x2::address::to_bytes(arg2), 3002);
        assert!(v1.target == arg3, 3003);
        v1
    }

    // decompiled from Move bytecode v6
}

