module 0xc445519bf1d6ed8ab6002d20ad7ed81a9ad25e31990df9b72203d0ad86fd2e92::codec {
    public fun decode(arg0: &vector<u8>) : (u8, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, u64, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) {
        assert!(0x1::vector::length<u8>(arg0) == 138 && *0x1::vector::borrow<u8>(arg0, 0) == 3, 100);
        let v0 = *0x1::vector::borrow<u8>(arg0, 1);
        assert!(v0 >= 1 && v0 <= 4, 100);
        let v1 = 0;
        let v2 = 66;
        while (v2 < 74) {
            let v3 = v1 << 8;
            v1 = v3 | (*0x1::vector::borrow<u8>(arg0, v2) as u64);
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 100);
        (v0, word(arg0, 2), word(arg0, 34), v1, word(arg0, 74), word(arg0, 106))
    }

    public fun encode(arg0: u8, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg5: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : vector<u8> {
        let v0 = if (arg0 >= 1) {
            if (arg0 <= 4) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, 3);
        0x1::vector::push_back<u8>(v2, arg0);
        0x1::vector::append<u8>(&mut v1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg2));
        let v3 = 8;
        while (v3 > 0) {
            v3 = v3 - 1;
            0x1::vector::push_back<u8>(&mut v1, ((arg3 >> v3 * 8 & 255) as u8));
        };
        0x1::vector::append<u8>(&mut v1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg5));
        v1
    }

    fun word(arg0: &vector<u8>, arg1: u64) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(v0)
    }

    // decompiled from Move bytecode v7
}

