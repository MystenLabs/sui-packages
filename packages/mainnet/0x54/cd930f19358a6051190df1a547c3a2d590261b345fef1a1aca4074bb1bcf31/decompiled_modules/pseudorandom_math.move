module 0x54cd930f19358a6051190df1a547c3a2d590261b345fef1a1aca4074bb1bcf31::pseudorandom_math {
    public fun select_u16(arg0: u16, arg1: &vector<u8>) : u16 {
        assert!(0x1::vector::length<u8>(arg1) >= 32, 0);
        ((u256_from_be_bytes(arg1) % (arg0 as u256)) as u16)
    }

    public fun select_u32(arg0: u32, arg1: &vector<u8>) : u32 {
        assert!(0x1::vector::length<u8>(arg1) >= 32, 0);
        ((u256_from_be_bytes(arg1) % (arg0 as u256)) as u32)
    }

    public fun select_u64(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 32, 0);
        ((u256_from_be_bytes(arg1) % (arg0 as u256)) as u64)
    }

    public fun select_u8(arg0: u8, arg1: &vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg1) >= 32, 0);
        ((u256_from_be_bytes(arg1) % (arg0 as u256)) as u8)
    }

    public fun u128_from_be_bytes(arg0: &vector<u8>) : u128 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 16) {
            v2
        } else {
            16
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u128) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u128_from_le_bytes(arg0: &vector<u8>) : u128 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 16) {
            v2
        } else {
            16
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v2 - v1) as u128) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u16_from_be_bytes(arg0: &vector<u8>) : u16 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 2) {
            v2
        } else {
            2
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u16) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u16_from_le_bytes(arg0: &vector<u8>) : u16 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 2) {
            v2
        } else {
            2
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v3 - v1) as u16) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u256_from_be_bytes(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 32) {
            v2
        } else {
            32
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u256) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u256_from_le_bytes(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 32) {
            v2
        } else {
            32
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v2 - v1) as u256) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u32_from_be_bytes(arg0: &vector<u8>) : u32 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 4) {
            v2
        } else {
            4
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u32) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u32_from_le_bytes(arg0: &vector<u8>) : u32 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 4) {
            v2
        } else {
            4
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v2 - v1) as u32) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_from_be_bytes(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 8) {
            v2
        } else {
            8
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u64) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_from_le_bytes(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(arg0);
        let v3 = if (v2 < 8) {
            v2
        } else {
            8
        };
        while (v1 < v3) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v2 - v1) as u64) << 8 * (v1 as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun u8_from_bytes(arg0: &vector<u8>) : u8 {
        if (0x1::vector::length<u8>(arg0) < 1) {
            0
        } else {
            *0x1::vector::borrow<u8>(arg0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

