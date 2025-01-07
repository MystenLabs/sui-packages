module 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_identifier {
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

