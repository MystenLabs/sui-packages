module 0xdebfc04183656246a0af940f1b007064c3cf70b740efea1c78d7f8c0b07a76f9::fortuna {
    struct FORTUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EPF3XxaiTNp8q3wVpPd4rTZNZztYjfFkpDJtEe8gpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FORTUNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Fortuna     ")))), trim_right(b"Som Original - Fortuna          "), trim_right(b"Fortuna, Roman Goddess of Fortune, Luck & Fate. As the daughter of Jupiter, Fortuna was widely revered in ancient Roman culture and was considered an important deity in both public and private life. She was seen as a protector of the state and was invoked by individuals seeking good fortune. Elon Musk aka $Kekius loves"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTUNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTUNA>>(v4);
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

