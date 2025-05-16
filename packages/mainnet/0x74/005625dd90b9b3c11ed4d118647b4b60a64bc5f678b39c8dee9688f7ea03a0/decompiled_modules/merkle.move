module 0x74005625dd90b9b3c11ed4d118647b4b60a64bc5f678b39c8dee9688f7ea03a0::merkle {
    public fun verify_merkle(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) : vector<u8> {
        let v0 = 0;
        let v1 = arg1;
        let v2 = 0x1::vector::empty<u8>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg3, v0);
            if (0x1::string::utf8(v3) == 0x1::string::utf8(b"left")) {
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
                0x1::vector::append<u8>(&mut v2, v1);
                v1 = 0x1::hash::sha2_256(v2);
                v2 = 0x1::vector::empty<u8>();
            } else if (0x1::string::utf8(v3) == 0x1::string::utf8(b"right")) {
                0x1::vector::append<u8>(&mut v2, v1);
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
                v1 = 0x1::hash::sha2_256(v2);
                v2 = 0x1::vector::empty<u8>();
            };
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

