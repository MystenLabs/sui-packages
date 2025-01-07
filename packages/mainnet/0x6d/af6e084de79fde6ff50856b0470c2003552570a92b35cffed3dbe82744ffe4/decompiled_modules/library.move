module 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library {
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

    public entry fun get_oracle_price(arg0: &0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::PriceInfoObject) : u128 {
        let v0 = 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::pyth::get_price_unsafe(arg0);
        let v1 = 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price::get_price(&v0);
        (0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::i64::get_magnitude_if_positive(&v1) as u128)
    }

    public entry fun get_price_identifier(arg0: &0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::PriceInfoObject) : vector<u8> {
        let v0 = 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_info::get_price_identifier(&v0);
        0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier::get_bytes(&v1)
    }

    public fun get_public_address(arg0: vector<u8>) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"01");
        0x1::vector::append<u8>(&mut v0, arg0);
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 32) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v3));
            v3 = v3 + 1;
        };
        0x2::address::from_bytes(v2)
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

    public fun recover_public_key_from_signature(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg1, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 1)
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

    // decompiled from Move bytecode v6
}

