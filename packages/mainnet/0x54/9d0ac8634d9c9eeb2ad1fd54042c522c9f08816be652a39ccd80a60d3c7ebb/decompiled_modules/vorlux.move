module 0x549d0ac8634d9c9eeb2ad1fd54042c522c9f08816be652a39ccd80a60d3c7ebb::vorlux {
    struct VORLUX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VORLUX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VORLUX>>(0x2::coin::mint<VORLUX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VORLUX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7r1oxsUbFEaWySkv9VUPa9BJbBRwcwUuuS2KBERD22nJ.png?size=lg&key=5c4b6f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VORLUX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VORLUX  ")))), trim_right(b"VORLUX                          "), trim_right(b"As data threats become more complex in our digital world, Vorlux provides a security solution that combines AI technology and top-tier encryption, ensuring maximum protection for personal, business, and sensitive data.                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VORLUX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VORLUX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VORLUX>>(0x2::coin::mint<VORLUX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

