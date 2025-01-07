module 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library {
    struct VerificationResult has copy, drop {
        is_verified: bool,
        public_key: vector<u8>,
    }

    public entry fun get_price_identifier(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : vector<u8> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1)
    }

    public fun base_div(arg0: u128, arg1: u128) : u128 {
        arg0 * 1000000000 / arg1
    }

    public fun base_mul(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / 1000000000
    }

    public fun base_uint() : u128 {
        1000000000
    }

    public fun ceil(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1 * arg1
    }

    public fun compute_mro(arg0: u128) : u128 {
        base_div(base_uint(), arg0)
    }

    public fun convert_usdc_to_base_decimals(arg0: u128) : u128 {
        arg0 * 1000
    }

    public fun get_hash(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public entry fun get_oracle_base(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u128)
    }

    public entry fun get_oracle_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128)
    }

    public fun get_public_address(arg0: vector<u8>) : address {
        let v0 = 0x2::hash::blake2b256(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        0x2::address::from_bytes(v1)
    }

    public fun get_result_public_key(arg0: VerificationResult) : vector<u8> {
        arg0.public_key
    }

    public fun get_result_status(arg0: VerificationResult) : bool {
        arg0.is_verified
    }

    public fun half_base_uint() : u128 {
        500000000
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun round(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1 * 5 / 10;
        v0 - v0 % arg1
    }

    public fun round_down(arg0: u128) : u128 {
        arg0 / base_uint() * base_uint()
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun to_1x9_vec(arg0: vector<u128>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0)) {
            0x1::vector::push_back<u128>(&mut v0, *0x1::vector::borrow<u128>(&arg0, v1) / 1000000000);
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : VerificationResult {
        let v0 = 0x1::vector::pop_back<u8>(&mut arg0);
        let v1 = VerificationResult{
            is_verified : false,
            public_key  : arg1,
        };
        if (v0 == 0) {
            v1.is_verified = 0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg1, &arg2, 1);
            0x1::vector::insert<u8>(&mut v1.public_key, 1, 0);
        } else if (v0 == 1) {
            let v2 = get_hash(arg2);
            v1.is_verified = 0x2::ed25519::ed25519_verify(&arg0, &arg1, &v2);
            0x1::vector::insert<u8>(&mut v1.public_key, 0, 0);
        } else if (v0 == 2) {
            let v3 = get_hash(arg2);
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v4, 3);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<vector<u8>>(&v3));
            let v5 = 0x2::hash::blake2b256(&v4);
            v1.is_verified = 0x2::ed25519::ed25519_verify(&arg0, &arg1, &v5);
            0x1::vector::insert<u8>(&mut v1.public_key, 0, 0);
        };
        v1
    }

    // decompiled from Move bytecode v6
}

