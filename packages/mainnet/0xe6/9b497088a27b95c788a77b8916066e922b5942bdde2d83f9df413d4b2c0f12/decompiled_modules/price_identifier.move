module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier {
    struct PriceIdentifier has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun from_byte_vec(arg0: vector<u8>) : PriceIdentifier {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        PriceIdentifier{bytes: arg0}
    }

    public fun get_bytes(arg0: &PriceIdentifier) : vector<u8> {
        arg0.bytes
    }

    // decompiled from Move bytecode v6
}

