module 0xa55f6f81649b071b5967dc56227bbee289e4c411ab610caeec7abce499e262b8::executor_requests {
    public fun make_cctp_v1_request(arg0: u32, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"ERC1");
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u32_be(&mut v0, arg0);
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u64_be(&mut v0, arg1);
        v0
    }

    public fun make_cctp_v2_request() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"ERC2");
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u8(&mut v0, 1);
        v0
    }

    public fun make_ntt_v1_request(arg0: u16, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"ERN1");
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u16_be(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        v0
    }

    public fun make_vaa_v1_request(arg0: u16, arg1: vector<u8>, arg2: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"ERV1");
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u16_be(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u64_be(&mut v0, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

