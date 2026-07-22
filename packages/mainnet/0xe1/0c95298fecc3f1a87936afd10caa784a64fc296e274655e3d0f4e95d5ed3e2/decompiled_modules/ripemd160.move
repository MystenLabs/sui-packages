module 0xe10c95298fecc3f1a87936afd10caa784a64fc296e274655e3d0f4e95d5ed3e2::ripemd160 {
    fun append_le32(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 4) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 * v0 & 255) as u8));
            v0 = v0 + 1;
        };
    }

    fun f(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 < 16) {
            (arg1 ^ arg2 ^ arg3) & 4294967295
        } else if (arg0 < 32) {
            (arg1 & arg2 | (arg1 ^ 4294967295) & arg3) & 4294967295
        } else if (arg0 < 48) {
            ((arg1 | arg2 ^ 4294967295) ^ arg3) & 4294967295
        } else if (arg0 < 64) {
            (arg1 & arg3 | arg2 & (arg3 ^ 4294967295)) & 4294967295
        } else {
            (arg1 ^ (arg2 | arg3 ^ 4294967295)) & 4294967295
        }
    }

    public fun hash(arg0: vector<u8>) : vector<u8> {
        let v0 = 1732584193;
        let v1 = v0;
        let v2 = 4023233417;
        let v3 = 2562383102;
        let v4 = 271733878;
        let v5 = 3285377520;
        0x1::vector::push_back<u8>(&mut arg0, 128);
        while (0x1::vector::length<u8>(&arg0) % 64 != 56) {
            0x1::vector::push_back<u8>(&mut arg0, 0);
        };
        let v6 = 0;
        while (v6 < 8) {
            0x1::vector::push_back<u8>(&mut arg0, (((0x1::vector::length<u8>(&arg0) as u64) * 8 >> 8 * v6 & 255) as u8));
            v6 = v6 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&arg0) / 64) {
            let v8 = 0x1::vector::empty<u64>();
            let v9 = 0;
            while (v9 < 16) {
                let v10 = v7 * 64 + v9 * 4;
                0x1::vector::push_back<u64>(&mut v8, (*0x1::vector::borrow<u8>(&arg0, v10) as u64) | (*0x1::vector::borrow<u8>(&arg0, v10 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(&arg0, v10 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(&arg0, v10 + 3) as u64) << 24);
                v9 = v9 + 1;
            };
            let v11 = v4;
            let v12 = v2;
            let v13 = v4;
            let v14 = v3;
            let v15 = v2;
            let v16 = 0;
            while (v16 < 80) {
                v12 = mask(rotl(mask(mask(mask(v1 + f(v16, v12, v3, v11)) + *0x1::vector::borrow<u64>(&v8, rl(v16))) + kl(v16)), sl(v16)) + v5);
                v11 = rotl(v3, 10);
                v15 = mask(rotl(mask(mask(mask(v1 + f(79 - v16, v15, v3, v13)) + *0x1::vector::borrow<u64>(&v8, rr(v16))) + kr(v16)), sr(v16)) + v5);
                v13 = rotl(v3, 10);
                v14 = v2;
                v16 = v16 + 1;
            };
            let v17 = mask(mask(v2 + v3) + v13);
            v2 = mask(mask(v3 + v11) + v5);
            v3 = mask(mask(v4 + v5) + v0);
            v4 = mask(mask(v5 + v0) + v15);
            v5 = mask(mask(v0 + v12) + v14);
            v1 = v17;
            v7 = v7 + 1;
        };
        let v18 = 0x1::vector::empty<u8>();
        let v19 = &mut v18;
        append_le32(v19, v1);
        let v20 = &mut v18;
        append_le32(v20, v2);
        let v21 = &mut v18;
        append_le32(v21, v3);
        let v22 = &mut v18;
        append_le32(v22, v4);
        let v23 = &mut v18;
        append_le32(v23, v5);
        v18
    }

    fun kl(arg0: u64) : u64 {
        if (arg0 < 16) {
            0
        } else if (arg0 < 32) {
            1518500249
        } else if (arg0 < 48) {
            1859775393
        } else if (arg0 < 64) {
            2400959708
        } else {
            2840853838
        }
    }

    fun kr(arg0: u64) : u64 {
        if (arg0 < 16) {
            1352829926
        } else if (arg0 < 32) {
            1548603684
        } else if (arg0 < 48) {
            1836072691
        } else if (arg0 < 64) {
            2053994217
        } else {
            0
        }
    }

    fun mask(arg0: u64) : u64 {
        arg0 & 4294967295
    }

    fun rl(arg0: u64) : u64 {
        let v0 = vector[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 7, 4, 13, 1, 10, 6, 15, 3, 12, 0, 9, 5, 2, 14, 11, 8, 3, 10, 14, 4, 9, 15, 8, 1, 2, 7, 0, 6, 13, 11, 5, 12, 1, 9, 11, 10, 0, 8, 12, 4, 13, 3, 7, 15, 14, 5, 6, 2, 4, 0, 5, 9, 7, 12, 2, 10, 14, 1, 3, 8, 11, 6, 15, 13];
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    fun rotl(arg0: u64, arg1: u8) : u64 {
        let v0 = arg0 & 4294967295;
        (v0 << arg1 | v0 >> 32 - arg1) & 4294967295
    }

    fun rr(arg0: u64) : u64 {
        let v0 = vector[5, 14, 7, 0, 9, 2, 11, 4, 13, 6, 15, 8, 1, 10, 3, 12, 6, 11, 3, 7, 0, 13, 5, 10, 14, 15, 8, 12, 4, 9, 1, 2, 15, 5, 1, 3, 7, 14, 6, 9, 11, 8, 12, 2, 10, 0, 4, 13, 8, 6, 4, 1, 3, 11, 15, 0, 5, 12, 2, 13, 9, 7, 10, 14, 12, 15, 10, 4, 1, 5, 8, 7, 6, 2, 13, 14, 0, 3, 9, 11];
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    fun sl(arg0: u64) : u8 {
        let v0 = x"0b0e0f0c050807090b0d0e0f060709080706080d0b09070f070c0f090b070d0c0b0d06070e090d0f0e080d06050c07050b0c0e0f0e0f0908090e05060806050c090f050b06080d0c050c0d0e0b080506";
        *0x1::vector::borrow<u8>(&v0, arg0)
    }

    fun sr(arg0: u64) : u8 {
        let v0 = x"0809090b0d0f0f050707080b0e0e0c06090d0f070c08090b07070c07060f0d0b09070f0b0806060e0c0d050e0d0d07050f05080b0e0e060e06090c090c050f0808050c090c050e06080d06050f0d0b0b";
        *0x1::vector::borrow<u8>(&v0, arg0)
    }

    // decompiled from Move bytecode v7
}

