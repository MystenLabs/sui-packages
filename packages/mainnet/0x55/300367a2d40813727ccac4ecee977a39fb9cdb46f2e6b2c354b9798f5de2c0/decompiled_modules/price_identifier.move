module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier {
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

