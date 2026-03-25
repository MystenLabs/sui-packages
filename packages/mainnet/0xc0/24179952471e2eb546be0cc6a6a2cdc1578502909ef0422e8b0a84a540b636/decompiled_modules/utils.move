module 0xc024179952471e2eb546be0cc6a6a2cdc1578502909ef0422e8b0a84a540b636::utils {
    public fun mul_mod(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0xc024179952471e2eb546be0cc6a6a2cdc1578502909ef0422e8b0a84a540b636::bn254_mod_mul::modulus()) {
            return 0xc024179952471e2eb546be0cc6a6a2cdc1578502909ef0422e8b0a84a540b636::bn254_mod_mul::mul_mod(arg0, arg1)
        };
        mul_mod_generic(arg0, arg1, arg2)
    }

    public fun add_mod(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1 % arg2;
        if (v0 >= arg2 - v1) {
            v0 - arg2 - v1
        } else {
            v0 + v1
        }
    }

    public fun add_mod_unchecked(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 >= arg2 - arg1) {
            arg0 - arg2 - arg1
        } else {
            arg0 + arg1
        }
    }

    public fun be_bytes_to_u256(arg0: vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        0x1::vector::reverse<u8>(&mut arg0);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u256(&mut v0)
    }

    fun mul_mod_generic(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1 % arg2;
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = v1;
        while (v3 > 0) {
            if (v3 & 1 == 1) {
                v2 = add_mod_unchecked(v2, v0, arg2);
            };
            v3 = v3 >> 1;
            if (v3 > 0) {
                v0 = add_mod_unchecked(v0, v0, arg2);
            };
        };
        v2
    }

    public fun u256_to_be_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    // decompiled from Move bytecode v6
}

