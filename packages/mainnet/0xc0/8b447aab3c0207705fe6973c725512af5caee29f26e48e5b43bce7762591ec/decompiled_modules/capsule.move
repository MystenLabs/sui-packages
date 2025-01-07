module 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::capsule {
    struct DrandChain has drop {
        genesis_time: u64,
        period: u64,
        public_key: vector<u8>,
        randomness: vector<u8>,
    }

    struct IbeEncryption has copy, drop, store {
        u: 0x2::group_ops::Element<0x2::bls12381::G2>,
        v: vector<u8>,
        w: vector<u8>,
    }

    public fun add_randomness(arg0: &mut DrandChain, arg1: vector<u8>) {
        arg0.randomness = 0x1::hash::sha2_256(arg1);
    }

    public fun bytes_to_ibe_encryption(arg0: &vector<u8>) : IbeEncryption {
        let v0 = b"u";
        let v1 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_vec_u8(arg0, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v0));
        let v2 = b"v";
        let v3 = b"w";
        IbeEncryption{
            u : 0x2::bls12381::g2_from_bytes(&v1),
            v : 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_vec_u8(arg0, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v2)),
            w : 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_vec_u8(arg0, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v3)),
        }
    }

    public fun decrypt(arg0: &DrandChain, arg1: &vector<u8>, arg2: vector<u8>) : vector<u8> {
        decrypt_with_round_signature(arg1, arg2)
    }

    public fun decrypt_with_round_signature(arg0: &vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::bls12381::g1_from_bytes(&arg1);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_chunks_count(arg0)) {
            let v4 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_vec_u8(arg0, (v2 as u32));
            let v5 = 0x1::option::destroy_with_default<vector<u8>>(ibe_decrypt(bytes_to_ibe_encryption(&v4), &v0), 0x1::vector::empty<u8>());
            if (v2 == 0) {
                v3 = (*0x1::vector::borrow<u8>(&v5, 0) as u32) << 24 | (*0x1::vector::borrow<u8>(&v5, 1) as u32) << 16 | (*0x1::vector::borrow<u8>(&v5, 2) as u32) << 8 | (*0x1::vector::borrow<u8>(&v5, 3) as u32);
                let v6 = 4;
                while (v6 < 32) {
                    0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v5, v6));
                    v6 = v6 + 1;
                };
            } else {
                0x1::vector::append<u8>(&mut v1, v5);
            };
            v2 = v2 + 1;
        };
        while (0x1::vector::length<u8>(&v1) > (v3 as u64)) {
            0x1::vector::pop_back<u8>(&mut v1);
        };
        v1
    }

    public fun drand_quicknet() : DrandChain {
        DrandChain{
            genesis_time : 1692803367,
            period       : 3,
            public_key   : x"83cf0f2896adee7eb8b5f01fcad3912212c437e0073e911fb90022d3e760183c8c4b450b6a0a6c3ac6a5776a2d1064510d1fec758c921cc22b0e17e63aaf4bcb5ed66304de9cf809bd274ca73bab4af5a6e9c76a4bc09e76eae8991ef5ece45a",
            randomness   : 0x1::vector::empty<u8>(),
        }
    }

    public fun drand_quicknet_with_randomness(arg0: vector<u8>) : DrandChain {
        let v0 = drand_quicknet();
        let v1 = &mut v0;
        add_randomness(v1, arg0);
        v0
    }

    public fun drand_with_params(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : DrandChain {
        DrandChain{
            genesis_time : arg0,
            period       : arg1,
            public_key   : arg2,
            randomness   : arg3,
        }
    }

    public fun encrypt(arg0: &mut DrandChain, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        0x1::vector::empty<u8>()
    }

    public fun encrypt_for_round(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>, arg3: &vector<u8>) : vector<u8> {
        0x1::vector::empty<u8>()
    }

    public fun encrypt_for_time(arg0: &mut DrandChain, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        0x1::vector::empty<u8>()
    }

    public fun ibe_decrypt(arg0: IbeEncryption, arg1: &0x2::group_ops::Element<0x2::bls12381::G1>) : 0x1::option::Option<vector<u8>> {
        let v0 = 0x2::bls12381::pairing(arg1, &arg0.u);
        let v1 = b"HASH2 - ";
        0x1::vector::append<u8>(&mut v1, *0x2::group_ops::bytes<0x2::bls12381::GT>(&v0));
        let v2 = 0x2::hash::blake2b256(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg0.v)) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4) ^ *0x1::vector::borrow<u8>(&arg0.v, v4));
            v4 = v4 + 1;
        };
        let v5 = b"HASH4 - ";
        0x1::vector::append<u8>(&mut v5, v3);
        let v6 = 0x2::hash::blake2b256(&v5);
        let v7 = 0x1::vector::empty<u8>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u8>(&arg0.w)) {
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v6, v8) ^ *0x1::vector::borrow<u8>(&arg0.w, v8));
            v8 = v8 + 1;
        };
        let v9 = b"HASH3 - ";
        0x1::vector::append<u8>(&mut v9, v3);
        0x1::vector::append<u8>(&mut v9, v7);
        let v10 = 0x2::hash::blake2b256(&v9);
        let v11 = modulo_order(&v10);
        let v12 = 0x2::bls12381::scalar_from_bytes(&v11);
        let v13 = 0x2::bls12381::g2_generator();
        let v14 = 0x2::bls12381::g2_mul(&v12, &v13);
        if (0x2::group_ops::equal<0x2::bls12381::G2>(&arg0.u, &v14)) {
            0x1::option::some<vector<u8>>(v7)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun ibe_encryption_to_bytes(arg0: IbeEncryption) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = b"v";
        0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::set<vector<u8>>(&mut v0, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v1), &arg0.v);
        let v2 = b"w";
        0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::set<vector<u8>>(&mut v0, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v2), &arg0.w);
        let v3 = b"u";
        0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::set<vector<u8>>(&mut v0, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v3), 0x2::group_ops::bytes<0x2::bls12381::G2>(&arg0.u));
        v0
    }

    public fun latest_round(arg0: &DrandChain, arg1: u64) : u64 {
        round_at(arg0, arg1)
    }

    fun modulo_order(arg0: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        loop {
            let v1 = try_substract(&v0);
            if (0x1::option::is_none<vector<u8>>(&v1)) {
                break
            };
            v0 = *0x1::option::borrow<vector<u8>>(&v1);
        };
        v0
    }

    public fun public_key(arg0: &DrandChain) : &vector<u8> {
        &arg0.public_key
    }

    public fun round_at(arg0: &DrandChain, arg1: u64) : u64 {
        let v0 = arg1 / 1000;
        if (arg0.genesis_time > v0) {
            return 0
        };
        (v0 - arg0.genesis_time) / arg0.period
    }

    public fun round_key(arg0: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u64>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::hash::sha2_256(v0)
    }

    fun try_substract(arg0: &vector<u8>) : 0x1::option::Option<vector<u8>> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        let v0 = x"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < 32) {
            let v4 = 31 - v2;
            let v5 = *0x1::vector::borrow<u8>(arg0, v4);
            let v6 = (*0x1::vector::borrow<u8>(&v0, v4) as u16) + (v3 as u16);
            if (v6 > (v5 as u16)) {
                v3 = 1;
                0x1::vector::push_back<u8>(&mut v1, ((256 + (v5 as u16) - v6) as u8));
            } else {
                v3 = 0;
                0x1::vector::push_back<u8>(&mut v1, (((v5 as u16) - v6) as u8));
            };
            v2 = v2 + 1;
        };
        if (v3 != 0) {
            0x1::option::none<vector<u8>>()
        } else {
            0x1::vector::reverse<u8>(&mut v1);
            0x1::option::some<vector<u8>>(v1)
        }
    }

    public fun use_randomness(arg0: &mut DrandChain) : &vector<u8> {
        arg0.randomness = 0x1::hash::sha2_256(arg0.randomness);
        &arg0.randomness
    }

    public fun verify_round_signature(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>) : bool {
        let v0 = round_key(arg1);
        0x2::bls12381::bls12381_min_sig_verify(arg2, arg0, &v0)
    }

    public fun verify_signature(arg0: &mut DrandChain, arg1: u64, arg2: &vector<u8>) : bool {
        verify_round_signature(&arg0.public_key, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

