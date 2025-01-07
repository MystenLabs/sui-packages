module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils {
    struct SignaturePayload has copy, drop {
        target: address,
        receiver: address,
        amount: u64,
        nonce: u128,
        type: u8,
    }

    struct Signature has copy, drop {
        sig: vector<u8>,
        pk: vector<u8>,
        scheme: u8,
    }

    public(friend) fun convert_to_usdc_base(arg0: u128) : u64 {
        ((arg0 / 1000) as u64)
    }

    public(friend) fun payload_amount(arg0: SignaturePayload) : u64 {
        arg0.amount
    }

    public(friend) fun payload_nonce(arg0: SignaturePayload) : u128 {
        arg0.nonce
    }

    public(friend) fun payload_receiver(arg0: SignaturePayload) : address {
        arg0.receiver
    }

    public(friend) fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: address, arg4: u8) : SignaturePayload {
        assert!(0x1::vector::length<u8>(&arg0) == 89, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_size());
        assert!(0x1::vector::length<u8>(&arg1) == 99 || 0x1::vector::length<u8>(&arg1) == 100, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_size());
        let v0 = 0x2::bcs::new(arg0);
        let v1 = SignaturePayload{
            target   : 0x2::bcs::peel_address(&mut v0),
            receiver : 0x2::bcs::peel_address(&mut v0),
            amount   : 0x2::bcs::peel_u64(&mut v0),
            nonce    : 0x2::bcs::peel_u128(&mut v0),
            type     : 0x2::bcs::peel_u8(&mut v0),
        };
        let v2 = 0x2::bcs::new(arg1);
        let v3 = Signature{
            sig    : 0x2::bcs::peel_vec_u8(&mut v2),
            pk     : 0x2::bcs::peel_vec_u8(&mut v2),
            scheme : 0x2::bcs::peel_u8(&mut v2),
        };
        let v4 = 0x1::hash::sha2_256(arg0);
        if (v3.scheme == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::secp256k1_scheme()) {
            assert!(0x2::ecdsa_k1::secp256k1_verify(&v3.sig, &v3.pk, &v4, 1), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_signature());
            0x1::vector::insert<u8>(&mut v3.pk, 1, 0);
        } else {
            assert!(v3.scheme == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::ed25519_scheme(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::unsupported_wallet_scheme());
            assert!(0x2::ed25519::ed25519_verify(&v3.sig, &v3.pk, &v4), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::invalid_signature());
            0x1::vector::insert<u8>(&mut v3.pk, 0, 0);
        };
        assert!(0x2::hash::blake2b256(&v3.pk) == 0x2::address::to_bytes(arg2), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::not_valid_signer());
        assert!(v1.target == arg3, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::target_address_do_not_match());
        assert!(v1.type == arg4, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::payload_type_do_not_match());
        v1
    }

    // decompiled from Move bytecode v6
}

