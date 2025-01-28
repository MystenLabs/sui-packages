module 0xadf0d13e56fc81afedebd3816cbedd829b9ea6b68ae927135dad2f99c082e891::deepmigra {
    struct DEEPMIGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPMIGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"-ZQjM_FoSzRxZ6Tx                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEEPMIGRA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DeepMigra   ")))), trim_right(b"BuyTheDeep                      "), trim_right(b"BuyTheDeep is the ultimate meme token for fearless investors who thrive on market dips and crypto chaos! Inspired by the adventurous spirit of buying low and holding strong, this token embodies a bold, fun-loving community that turns downturns into opportunities. With a playful nod to the El Salvador presidents crypto "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPMIGRA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPMIGRA>>(v4);
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

