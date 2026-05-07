module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price_identifier {
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

    // decompiled from Move bytecode v7
}

