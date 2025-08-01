module 0xc4cc61566daeddd1ea388bfe48c91d2aedb11771d35527e9f6c439e3efa62591::odysseusa {
    struct ODYSSEUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODYSSEUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"931593761144301b16de5431b92dc3a67ce5c8c7cc20cc33a77859f94d31bbec                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ODYSSEUSA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ODYSSEUS    ")))), trim_right(b"Odysseus                        "), trim_right(b"Exchange token of the new crypto exchange \"OdysseyExchenge\". Here you can trade without commissions on spot, as well as liquidate with x777 leverage.The project also includes such tokens as Grimace and SEX, whose market cap exceeded more than 400 million dollars, and many other tokens that will definitely show themselv"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODYSSEUSA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODYSSEUSA>>(v4);
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

