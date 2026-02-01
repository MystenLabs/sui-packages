module 0xeaee014558e1be614b1d017fbccd1869c2a0fdc6a96e6ed9ac32a39bb6ef412e::messiwc2 {
    struct MESSIWC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSIWC2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"1111        ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmdUs6cg2e84BiW7Efd3ar9JN338C6vEfSDzj2qd4zewWN                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MESSIWC2>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MessiWc2")))), trim_right(b"M10WC26                         "), trim_right(x"4120636f6d6d756e6974792d64726976656e206d656d6520636f696e206372656174656420746f20737570706f7274204d313020284d65737369292077696e6e696e6720746865203230323620576f726c64204375702e0a5468652070726f6a65637420636f6d62696e657320666f6f7462616c6c2070617373696f6e2c206d656d652063756c747572652c20616e6420636861726974792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSIWC2>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSIWC2>>(v4);
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

