module 0xed6e5c5d56c4dcffb672d81ad18beac69023a08627018b0e69f2bcb0d4f24893::hankhancy {
    struct HANKHANCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANKHANCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9d4fc05674c937d414ea9e33e92ad363d6c35f6ce402c62287691f5aaac87e9d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HANKHANCY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HANKHANCY   ")))), trim_right(b"HANK LOVE HANCY                 "), trim_right(b"Sometimes love speaks through the smallest things a hug, a grin, a shared moment under the same sky. Hank and Hancy arent chasing fame or fortune; theyre just two bears teaching us that kindness and affection can be the loudest language.                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANKHANCY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANKHANCY>>(v4);
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

