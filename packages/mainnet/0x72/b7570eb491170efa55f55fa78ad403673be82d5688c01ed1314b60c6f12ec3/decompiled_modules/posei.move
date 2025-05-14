module 0x72b7570eb491170efa55f55fa78ad403673be82d5688c01ed1314b60c6f12ec3::posei {
    struct POSEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmSivYPEooi5pY3GnFdkQtwRizefynywALUpe4wSWW3npC                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POSEI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POSEI   ")))), trim_right(b"Poseidon                        "), trim_right(b"Poseidon was not placed on Sui by chance. The sea god belongs to the chain of the sea. $POSEI is not here to follow tides. It commands them. This is not a trend. It is convergence. A cultural token forged at the intersection of mythology, memes, and meaning.                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEI>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

