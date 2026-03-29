module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price_identifier {
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

