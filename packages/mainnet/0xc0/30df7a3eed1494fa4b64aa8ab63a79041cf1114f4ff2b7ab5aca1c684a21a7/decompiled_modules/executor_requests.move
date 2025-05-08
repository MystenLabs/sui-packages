module 0xc030df7a3eed1494fa4b64aa8ab63a79041cf1114f4ff2b7ab5aca1c684a21a7::executor_requests {
    public fun make_cctp_v1_request(arg0: u32, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"ERC1");
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u32_be(&mut v0, arg0);
        0xdb0fe8bb1e2b5be628adbea0636063325073e1070ee11e4281457dfd7f158235::bytes::push_u64_be(&mut v0, arg1);
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

