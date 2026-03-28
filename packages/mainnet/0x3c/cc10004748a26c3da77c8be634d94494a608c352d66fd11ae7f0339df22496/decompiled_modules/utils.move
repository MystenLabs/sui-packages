module 0x3ccc10004748a26c3da77c8be634d94494a608c352d66fd11ae7f0339df22496::utils {
    public fun add_mod(arg0: u256, arg1: u256, arg2: u256) : u256 {
        add_mod_unchecked(arg0 % arg2, arg1 % arg2, arg2)
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

