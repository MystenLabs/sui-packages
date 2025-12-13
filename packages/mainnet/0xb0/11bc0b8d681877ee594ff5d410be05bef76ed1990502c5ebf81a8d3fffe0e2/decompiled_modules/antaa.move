module 0xb011bc0b8d681877ee594ff5d410be05bef76ed1990502c5ebf81a8d3fffe0e2::antaa {
    struct ANTAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c889b4ce45c75b4ac816ed7a0b77befa589f20d9b648a1e09ee2cd9c7099a8fd                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANTAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANTA        ")))), trim_right(b"Santa Coin                      "), trim_right(b"Santa Coin- Welcome to the jolliest corner of crypto! The Santa Coin Community exists for one purpose: to sprinkle holiday magic on the blockchain. We're here to deliver big laughs, bigger vibes, andif the elves stop messing around-maybe even bigger gains. Our mission? -Spread cheer, memes, and moon missions in equal m"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTAA>>(v4);
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

