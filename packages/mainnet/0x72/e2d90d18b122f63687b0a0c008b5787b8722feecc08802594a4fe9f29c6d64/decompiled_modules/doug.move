module 0x72e2d90d18b122f63687b0a0c008b5787b8722feecc08802594a4fe9f29c6d64::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ars75tQdiT2NchT99XxrUoCPH6nyYA9HXYaQ1euF6Y38.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOUG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOUG        ")))), trim_right(b"DOUG THE PUG                    "), trim_right(b"Doug the Pug isnt just cute  hes a full-on vibe. With millions of fans and a face thats instantly recognizable, Doug has become a pop culture icon without lifting a paw.                                                                                                                                                       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v4);
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

