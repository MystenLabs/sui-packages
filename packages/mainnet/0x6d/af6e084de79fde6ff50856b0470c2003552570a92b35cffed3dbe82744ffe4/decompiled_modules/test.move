module 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::test {
    struct SignatureVerifiedEvent has copy, drop {
        is_verified: bool,
    }

    struct PublicKeyRecoveredEvent has copy, drop {
        public_key: vector<u8>,
    }

    struct HashGeneratedEvent has copy, drop {
        hash: vector<u8>,
    }

    struct OrderSerializedEvent has copy, drop {
        serialized_order: vector<u8>,
    }

    struct PublicAddressGeneratedEvent has copy, drop {
        addr: vector<u8>,
    }

    struct EncodedOrder has copy, drop {
        order: vector<u8>,
    }

    public entry fun hash(arg0: address, arg1: address) {
        let v0 = 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::order::get_serialized_order(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::order::pack_order(arg1, 24, 1000000000, 1000000000, 1000000000, arg0, 1747984534000, 1668690862116));
        let v1 = OrderSerializedEvent{serialized_order: v0};
        0x2::event::emit<OrderSerializedEvent>(v1);
        let v2 = HashGeneratedEvent{hash: 0x1::hash::sha2_256(v0)};
        0x2::event::emit<HashGeneratedEvent>(v2);
    }

    public entry fun get_public_address(arg0: vector<u8>) {
        let v0 = PublicAddressGeneratedEvent{addr: 0x2::address::to_bytes(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::get_public_address(arg0))};
        0x2::event::emit<PublicAddressGeneratedEvent>(v0);
    }

    public entry fun get_public_key(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = PublicKeyRecoveredEvent{public_key: 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::recover_public_key_from_signature(arg1, arg0)};
        0x2::event::emit<PublicKeyRecoveredEvent>(v0);
    }

    public entry fun get_public_key_from_signed_order(arg0: address, arg1: address, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: vector<u8>) {
        let v0 = 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::order::get_serialized_order(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::order::pack_order(arg0, arg2, arg3, arg4, arg5, arg1, arg6, arg7));
        let v1 = OrderSerializedEvent{serialized_order: v0};
        0x2::event::emit<OrderSerializedEvent>(v1);
        let v2 = HashGeneratedEvent{hash: 0x1::hash::sha2_256(v0)};
        0x2::event::emit<HashGeneratedEvent>(v2);
        let v3 = 0x2::hex::encode(v0);
        let v4 = EncodedOrder{order: v3};
        0x2::event::emit<EncodedOrder>(v4);
        let v5 = PublicKeyRecoveredEvent{public_key: 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::recover_public_key_from_signature(v3, arg8)};
        0x2::event::emit<PublicKeyRecoveredEvent>(v5);
    }

    public entry fun hash_recover_pub_key(arg0: vector<u8>, arg1: address, arg2: address) {
        let v0 = 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::order::get_serialized_order(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::order::pack_order(arg2, 24, 1000000000, 1000000000, 1000000000, arg1, 1747984534000, 1668690862116));
        let v1 = OrderSerializedEvent{serialized_order: v0};
        0x2::event::emit<OrderSerializedEvent>(v1);
        let v2 = HashGeneratedEvent{hash: 0x1::hash::sha2_256(v0)};
        0x2::event::emit<HashGeneratedEvent>(v2);
        let v3 = PublicKeyRecoveredEvent{public_key: 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::recover_public_key_from_signature(0x2::hex::encode(v0), arg0)};
        0x2::event::emit<PublicKeyRecoveredEvent>(v3);
    }

    public entry fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = SignatureVerifiedEvent{is_verified: 0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg1, &arg2, 1)};
        0x2::event::emit<SignatureVerifiedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

