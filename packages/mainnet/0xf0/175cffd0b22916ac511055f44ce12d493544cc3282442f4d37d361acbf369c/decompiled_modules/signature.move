module 0xf0175cffd0b22916ac511055f44ce12d493544cc3282442f4d37d361acbf369c::signature {
    struct VSM has drop {
        version: u64,
        pool_id: 0x2::object::ID,
        account: address,
        amount_max: u64,
        expire_time: u64,
        protocol_type: u64,
        sig: vector<u8>,
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

    public fun get_bytes41_key(arg0: &VSM) : 0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41 {
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::new(get_reward_key(arg0.account, arg0.protocol_type))
    }

    public fun get_bytes41_key_direct(arg0: address, arg1: u64) : 0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41 {
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::new(get_reward_key(arg0, arg1))
    }

    public fun get_message(arg0: &VSM) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_u64_be(&mut v0, arg0.version);
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_vector<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0.pool_id));
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_vector<u8>(&mut v0, get_reward_key(arg0.account, arg0.protocol_type));
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_u64_be(&mut v0, arg0.amount_max);
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_u64_be(&mut v0, arg0.expire_time);
        v0
    }

    public fun get_reward_key(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_vector<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes::push_u64_be(&mut v0, arg1);
        v0
    }

    public fun verify_signature_ed25519(arg0: &VSM, arg1: vector<u8>) : bool {
        let v0 = get_message(arg0);
        0x2::ed25519::ed25519_verify(&arg0.sig, &arg1, &v0)
    }

    // decompiled from Move bytecode v6
}

