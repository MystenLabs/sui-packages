module 0x5131d25fcb492ac0b2cfd15cbaaf7cec51793dfe1e7060f250497f7a93b85a00::xhamster {
    struct XHAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/wbKTzaj4vDWW7jm7fwwRXfZMK5tFf8c9dJ6UMHpgXCN.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XHAMSTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"xhamster    ")))), trim_right(b"xhamster                        "), trim_right(b"xHamster is the unofficial token of the xHamster website. xHamster is a popular adult entertainment platform offering a vast collection of user-generated and professional adult content, including videos, live streams, and photos. NFTs are sold out                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHAMSTER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XHAMSTER>>(v4);
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

