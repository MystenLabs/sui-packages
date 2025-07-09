module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id {
    struct EncodedAssetId has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun from_bytes(arg0: vector<u8>) : EncodedAssetId {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        EncodedAssetId{bytes: arg0}
    }

    public fun get_bytes(arg0: &EncodedAssetId) : vector<u8> {
        arg0.bytes
    }

    // decompiled from Move bytecode v6
}

