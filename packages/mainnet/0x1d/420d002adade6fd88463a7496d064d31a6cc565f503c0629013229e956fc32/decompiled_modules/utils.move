module 0x1d420d002adade6fd88463a7496d064d31a6cc565f503c0629013229e956fc32::utils {
    public fun key(arg0: &vector<u8>) : u32 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = v0;
        if (v0 > 4) {
            v1 = 4;
        };
        let v2 = 0;
        let v3 = 0;
        while (v1 > 0) {
            let v4 = v1 - 1;
            v1 = v4;
            let v5 = *0x1::vector::borrow<u8>(arg0, v4);
            let v6 = v5;
            if (v5 >= 97) {
                v6 = v5 - 32;
            };
            if (v6 >= 32) {
                v6 = v6 - 31;
            };
            v2 = v2 | (v6 as u32) << v3;
            v3 = v3 + 6;
        };
        if (v0 > 4) {
            let v7 = v0 - 1;
            let v8 = 0;
            while (v7 >= 4) {
                let v9 = *0x1::vector::borrow<u8>(arg0, v7);
                let v10 = v9;
                if (v9 >= 97) {
                    v10 = v9 - 32;
                };
                let v11 = v8 + (v10 as u32);
                v8 = v11 % 256;
                v7 = v7 - 1;
            };
            if (v8 == 0) {
                v8 = 1;
            };
            v2 = v2 | (v8 as u32) << 24;
        };
        v2
    }

    public fun unpack_key(arg0: u32) : vector<u8> {
        let v0 = 4;
        let v1 = arg0;
        let v2 = 0x1::vector::empty<u8>();
        while (v0 > 0) {
            let v3 = ((v1 & 63) as u8);
            if (v3 > 0) {
                0x1::vector::push_back<u8>(&mut v2, v3 + 31);
            };
            v1 = v1 >> 6;
            v0 = v0 - 1;
        };
        0x1::vector::reverse<u8>(&mut v2);
        if (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v2, 42);
            0x1::vector::push_back<u8>(&mut v2, (v1 as u8) / 100 + 48);
            0x1::vector::push_back<u8>(&mut v2, (v1 as u8) / 10 % 10 + 48);
            0x1::vector::push_back<u8>(&mut v2, (v1 as u8) % 10 + 48);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

