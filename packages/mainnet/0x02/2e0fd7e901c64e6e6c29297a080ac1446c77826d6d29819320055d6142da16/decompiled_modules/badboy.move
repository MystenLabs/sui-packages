module 0x22e0fd7e901c64e6e6c29297a080ac1446c77826d6d29819320055d6142da16::badboy {
    struct BADBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8G1izh9JSe7VSHSww2g9nQZtepMEFPP1TsXWBn5Epump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BADBOY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BADBOY      ")))), trim_right(b"BAD BOY BIKINI CLUB             "), trim_right(x"42414420424f592042494b494e4920434c55422077617320666f756e64656420627920612067726f7570206f6620706f77657266756c2062696c6c696f6e6169726520626561636820656e7468757369617374732077686f2077616e74656420746f20627265616b2074686520636861696e73206f6620636f6e76656e74696f6e616c207377696d77656172206e6f726d7320616e642063726561746520746865206d6f7374206578636c757369766520636f6d6d756e697479206f6e2074686520706c616e65742e0a0a4f7572206d656d6265727320696e636c75646520746f7020776f726c64206c6561646572732c207465636820766973696f6e61726965732c20616e6420636f6e74726f7665727369616c20706f6c69746963616c20666967757265732077686f20616c6c207368617265206f6e652070617373696f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADBOY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADBOY>>(v4);
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

