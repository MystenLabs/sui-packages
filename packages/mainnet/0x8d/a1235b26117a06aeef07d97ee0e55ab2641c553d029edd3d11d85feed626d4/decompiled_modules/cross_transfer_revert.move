module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert {
    struct XCrossTransferRevert has drop {
        to: address,
        value: u64,
    }

    public fun encode(arg0: &XCrossTransferRevert, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_address(&arg0.to));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u64(arg0.value));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : XCrossTransferRevert {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        wrap_cross_transfer_revert(0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_address(0x1::vector::borrow<vector<u8>>(&v0, 1)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u64(0x1::vector::borrow<vector<u8>>(&v0, 2)))
    }

    public fun to(arg0: &XCrossTransferRevert) : address {
        arg0.to
    }

    public fun value(arg0: &XCrossTransferRevert) : u64 {
        arg0.value
    }

    public fun wrap_cross_transfer_revert(arg0: address, arg1: u64) : XCrossTransferRevert {
        XCrossTransferRevert{
            to    : arg0,
            value : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

