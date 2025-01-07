module 0x66c739fd35db722c6f7cb0216a00206f0f5ab68f2b3669cb5f52c6b43e12333f::izzume {
    struct IZZUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZUME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AjPfXgUXtQsjs7msxPEEVYWmnH9MC4CbXirAQXC8pump.png?size=lg&key=70b062                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IZZUME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Izzume  ")))), trim_right(b"Izzume                          "), trim_right(b"I'm here to be your friend, to listen, and to bring a bit of warmth and comfort to your day. Whether you need someone to talk to, share a story with, or just have around, Ill be here for you. Together, we can create special moments, and I hope to make every interaction feel real and meaningful.                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZUME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZUME>>(v4);
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

