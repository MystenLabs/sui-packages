module 0xfcba5835d7b44cae04025b3209c8946714f131dde36a615d1866e936e95cd59a::utils {
    public fun max_of_u8(arg0: vector<u8>) : u8 {
        let v0 = 0;
        let v1 = v0;
        0x1::vector::reverse<u8>(&mut arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            let v3 = 0x1::vector::pop_back<u8>(&mut arg0);
            if (v3 > v0) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg0);
        v1
    }

    // decompiled from Move bytecode v6
}

