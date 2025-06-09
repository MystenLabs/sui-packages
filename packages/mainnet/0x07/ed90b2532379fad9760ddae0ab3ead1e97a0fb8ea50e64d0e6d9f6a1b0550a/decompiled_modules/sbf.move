module 0x7ed90b2532379fad9760ddae0ab3ead1e97a0fb8ea50e64d0e6d9f6a1b0550a::sbf {
    struct SBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://imgur.com/gallery/sbf-2V9d5vU                                                                                                                                                                                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SBF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SBF     ")))), trim_right(b"Supreme Brilliany Family        "), trim_right(x"5265766f6c7574696f6e697a696e6720746865207265616c2065737461746520696e647573747279207769746820626c6f636b636861696e20746563686e6f6c6f67792e0a546865202453424620546f6b656e20616e64207468652053746174656c65737320546f776e2050726f6a656374206172652070726f766964696e6720657175697461626c6520696e766573746d656e74206f70706f7274756e697469657320776f726c64776964652e0a576520617265206261636b656420627920612070726f66657373696f6e616c207465616d2077697468206f766572203230207965617273206f6620657870657269656e636520696e20746865207265616c2065737461746520696e6475737472792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBF>>(v4);
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

