module 0xfff94e0c985b7aec1d9fc6945e8e6da1ab3e130ce286d378daf6f7d06b52fb1::airobin {
    struct AIROBIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIROBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreidqj2i5sstxell7l5ylymnoqhzv2zz7m22kuxuapdrk6vldagnkdy                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<AIROBIN>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AIROBIN ")))), trim_right(b"AI Robin History                "), trim_right(x"41636365737320746f20706572736f6e616c20636861740a41636365737320746f2072657365617263682061727469636c6573206f6e20776f726c6420686973746f7279202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<AIROBIN>>(0x2::coin::mint<AIROBIN>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIROBIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIROBIN>>(v3);
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

