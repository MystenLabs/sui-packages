module 0xd5f000ba6f432b06371e31c8ab0c23611cb3daeab4416f451f8a19ea561cf64e::signature {
    struct VSM has drop {
        version: u64,
        pool_id: 0x2::object::ID,
        account: address,
        amount_max: u64,
        expire_time: u64,
        protocol_type: u64,
        sig: vector<u8>,
    }

    public fun get_bytes41_key(arg0: &VSM) : 0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes41::Bytes41 {
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes41::new(get_reward_key(arg0.account, arg0.protocol_type))
    }

    public fun get_bytes41_key_direct(arg0: address, arg1: u64) : 0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes41::Bytes41 {
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes41::new(get_reward_key(arg0, arg1))
    }

    public fun get_message(arg0: &VSM) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_u64_be(&mut v0, arg0.version);
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_vector<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.pool_id));
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_vector<u8>(&mut v0, get_reward_key(arg0.account, arg0.protocol_type));
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_u64_be(&mut v0, arg0.amount_max);
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_u64_be(&mut v0, arg0.expire_time);
        v0
    }

    public fun get_reward_key(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_vector<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes::push_u64_be(&mut v0, arg1);
        v0
    }

    public fun new(arg0: u64, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: u64) : VSM {
        VSM{
            version       : arg0,
            pool_id       : arg1,
            account       : arg3,
            amount_max    : arg4,
            expire_time   : arg5,
            protocol_type : arg6,
            sig           : arg2,
        }
    }

    public fun verify_signature_ed25519(arg0: &VSM, arg1: vector<u8>) : bool {
        let v0 = get_message(arg0);
        0x2::ed25519::ed25519_verify(&arg0.sig, &arg1, &v0)
    }

    // decompiled from Move bytecode v6
}

