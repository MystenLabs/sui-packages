module 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils {
    public fun from_bytes_u128(arg0: &vector<u8>) : u128 {
        let v0 = truncate_zeros(arg0);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 16 - 0x1::vector::length<u8>(&v0);
        while (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 - 1;
        };
        let v2 = 0x2::bcs::new(v0);
        0x2::bcs::peel_u128(&mut v2)
    }

    public fun from_bytes_u32(arg0: &vector<u8>) : u32 {
        let v0 = truncate_zeros(arg0);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 4 - 0x1::vector::length<u8>(&v0);
        while (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 - 1;
        };
        let v2 = 0x2::bcs::new(v0);
        0x2::bcs::peel_u32(&mut v2)
    }

    public fun from_bytes_u64(arg0: &vector<u8>) : u64 {
        let v0 = truncate_zeros(arg0);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = 8 - 0x1::vector::length<u8>(&v0);
        while (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 - 1;
        };
        let v2 = 0x2::bcs::new(v0);
        0x2::bcs::peel_u64(&mut v2)
    }

    public fun slice_vector(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun to_bytes_u128(arg0: u128) : vector<u8> {
        to_signed_bytes(0x1::bcs::to_bytes<u128>(&arg0), true)
    }

    public fun to_bytes_u128_sign(arg0: u128, arg1: bool) : vector<u8> {
        to_signed_bytes(0x1::bcs::to_bytes<u128>(&arg0), arg1)
    }

    public fun to_bytes_u32(arg0: u32) : vector<u8> {
        to_signed_bytes(0x1::bcs::to_bytes<u32>(&arg0), true)
    }

    public fun to_bytes_u32_sign(arg0: u32, arg1: bool) : vector<u8> {
        to_signed_bytes(0x1::bcs::to_bytes<u32>(&arg0), arg1)
    }

    public fun to_bytes_u64(arg0: u64) : vector<u8> {
        to_signed_bytes(0x1::bcs::to_bytes<u64>(&arg0), true)
    }

    public fun to_bytes_u64_sign(arg0: u64, arg1: bool) : vector<u8> {
        to_signed_bytes(0x1::bcs::to_bytes<u64>(&arg0), arg1)
    }

    fun to_signed_bytes(arg0: vector<u8>, arg1: bool) : vector<u8> {
        0x1::vector::reverse<u8>(&mut arg0);
        let v0 = truncate_zeros(&arg0);
        if (arg1 == false) {
            return v0
        };
        if (*0x1::vector::borrow<u8>(&v0, 0) >= 128) {
            let v2 = x"00";
            0x1::vector::append<u8>(&mut v2, v0);
            v2
        } else {
            v0
        }
    }

    fun truncate_zeros(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0;
        let v1 = false;
        let v2 = 0x1::vector::empty<u8>();
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v3 = (*0x1::vector::borrow<u8>(arg0, v0) as u8);
            if (v3 > 0 || v1) {
                v1 = true;
                0x1::vector::push_back<u8>(&mut v2, v3);
            };
            v0 = v0 + 1;
        };
        if (0x1::vector::length<u8>(&v2) == 0) {
            x"00"
        } else {
            v2
        }
    }

    // decompiled from Move bytecode v6
}

