module 0xac73072b94f14a87b23781c7004c77df6799fdee109f24271d4696bc4a6514a4::codec {
    public fun decode(arg0: &vector<u8>) : (u8, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) {
        assert!(0x1::vector::length<u8>(arg0) == 130 && *0x1::vector::borrow<u8>(arg0, 0) == 2, 100);
        let v0 = *0x1::vector::borrow<u8>(arg0, 1);
        assert!(v0 >= 1 && v0 <= 3, 100);
        (v0, word(arg0, 2), word(arg0, 34), word(arg0, 66), word(arg0, 98))
    }

    public fun encode(arg0: u8, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32) : vector<u8> {
        assert!(arg0 >= 1 && arg0 <= 3, 100);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, arg0);
        0x1::vector::append<u8>(&mut v0, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg4));
        v0
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

