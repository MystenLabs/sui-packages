module 0x189da82056e08712c63a3a6cc8b04e871514ae826006a79cae58a3e8efb11e0::erdou {
    struct ERDOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERDOU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cd60ed9019de71bad65f5f3da8a336408a27e88764ab9f0170bc0d07c663c976                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ERDOU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ERDOU       ")))), trim_right(b"ERDOU CHINESE CAT               "), trim_right(b"Erdou, a Scottish Fold cat, is Douyin's top pet influencer with 39.5 million followers on the \"Talking Liu Erdou\" account as of August 2023. The account has over 400 million likes, with Erdou's charming videos driving massive engagement.                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERDOU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERDOU>>(v4);
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

