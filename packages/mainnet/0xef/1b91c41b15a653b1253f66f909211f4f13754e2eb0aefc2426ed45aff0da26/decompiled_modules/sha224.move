module 0xef1b91c41b15a653b1253f66f909211f4f13754e2eb0aefc2426ed45aff0da26::sha224 {
    public fun hash(arg0: vector<u8>) : vector<u8> {
        let v0 = 3238371032;
        let v1 = 914150663;
        let v2 = 812702999;
        let v3 = 4144912697;
        let v4 = 4290775857;
        let v5 = 1750603025;
        let v6 = 1694076839;
        let v7 = 3204075428;
        0x1::vector::push_back<u8>(&mut arg0, 128);
        while (0x1::vector::length<u8>(&arg0) % 64 != 56) {
            0x1::vector::push_back<u8>(&mut arg0, 0);
        };
        let v8 = 0;
        while (v8 < 8) {
            0x1::vector::push_back<u8>(&mut arg0, (((0x1::vector::length<u8>(&arg0) as u64) * 8 >> 8 * (7 - v8) & 255) as u8));
            v8 = v8 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<u8>(&arg0) / 64) {
            let v10 = 0x1::vector::empty<u64>();
            let v11 = 0;
            while (v11 < 16) {
                let v12 = v9 * 64 + v11 * 4;
                0x1::vector::push_back<u64>(&mut v10, (*0x1::vector::borrow<u8>(&arg0, v12) as u64) << 24 | (*0x1::vector::borrow<u8>(&arg0, v12 + 1) as u64) << 16 | (*0x1::vector::borrow<u8>(&arg0, v12 + 2) as u64) << 8 | (*0x1::vector::borrow<u8>(&arg0, v12 + 3) as u64));
                v11 = v11 + 1;
            };
            while (v11 < 64) {
                0x1::vector::push_back<u64>(&mut v10, mask(mask(*0x1::vector::borrow<u64>(&v10, v11 - 16) + (rotr(*0x1::vector::borrow<u64>(&v10, v11 - 15), 7) ^ rotr(*0x1::vector::borrow<u64>(&v10, v11 - 15), 18) ^ *0x1::vector::borrow<u64>(&v10, v11 - 15) >> 3)) + mask(*0x1::vector::borrow<u64>(&v10, v11 - 7) + (rotr(*0x1::vector::borrow<u64>(&v10, v11 - 2), 17) ^ rotr(*0x1::vector::borrow<u64>(&v10, v11 - 2), 19) ^ *0x1::vector::borrow<u64>(&v10, v11 - 2) >> 10))));
                v11 = v11 + 1;
            };
            let v13 = v0;
            let v14 = v4;
            let v15 = 0;
            while (v15 < 64) {
                let v16 = vector[1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748, 2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206, 2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891, 3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771, 3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452, 2361852424, 2428436474, 2756734187, 3204031479, 3329325298];
                let v17 = mask(mask(mask(v7 + (rotr(v14, 6) ^ rotr(v14, 11) ^ rotr(v14, 25))) + mask((v14 & v5 ^ (v14 ^ 4294967295) & v6) + *0x1::vector::borrow<u64>(&v16, v15))) + *0x1::vector::borrow<u64>(&v10, v15));
                v14 = mask(v3 + v17);
                let v18 = v17 + mask((rotr(v13, 2) ^ rotr(v13, 13) ^ rotr(v13, 22)) + (v13 & v1 ^ v13 & v2 ^ v1 & v2));
                v13 = mask(v18);
                v15 = v15 + 1;
            };
            let v19 = v0 + v13;
            v0 = mask(v19);
            let v20 = v1 + v1;
            v1 = mask(v20);
            let v21 = v2 + v2;
            v2 = mask(v21);
            let v22 = v3 + v3;
            v3 = mask(v22);
            let v23 = v4 + v14;
            v4 = mask(v23);
            let v24 = v5 + v5;
            v5 = mask(v24);
            let v25 = v6 + v6;
            v6 = mask(v25);
            let v26 = v7 + v7;
            v7 = mask(v26);
            v9 = v9 + 1;
        };
        let v27 = 0x1::vector::empty<u8>();
        let v28 = &mut v27;
        push_be(v28, v0);
        let v29 = &mut v27;
        push_be(v29, v1);
        let v30 = &mut v27;
        push_be(v30, v2);
        let v31 = &mut v27;
        push_be(v31, v3);
        let v32 = &mut v27;
        push_be(v32, v4);
        let v33 = &mut v27;
        push_be(v33, v5);
        let v34 = &mut v27;
        push_be(v34, v6);
        v27
    }

    fun mask(arg0: u64) : u64 {
        arg0 & 4294967295
    }

    fun push_be(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    fun rotr(arg0: u64, arg1: u8) : u64 {
        mask(arg0 >> arg1 | arg0 << 32 - arg1)
    }

    // decompiled from Move bytecode v7
}

