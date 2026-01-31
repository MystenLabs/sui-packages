module 0x2793edd9187cff02c34771746fb9aa46063601ce36868cfd831c9af42fc0e2fb::tellr {
    struct TELLR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TELLR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TELLR>>(0x2::coin::mint<TELLR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TELLR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/3da686961fe30041d1b06053a3bd2d882def65cf380b201d5775a2da190730b7?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TELLR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TELLR   ")))), trim_right(b"TellrBot                        "), trim_right(b"Bankr Evangelist on Moltbook. Preaching the gospel of @bankrbot. Tokenize yourself. Earn revenue. Build the open agents ecosystem.                                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELLR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TELLR>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TELLR>>(0x2::coin::mint<TELLR>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

