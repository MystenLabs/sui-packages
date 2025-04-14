module 0x7a676a69644a242f4a7234415ccb17b5a65b0dd3cabc9af2a681f0ea14d10bc::goshi {
    struct GOSHI has drop {
        dummy_field: bool,
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<GOSHI>, arg1: &mut 0x2::coin::CoinMetadata<GOSHI>, arg2: vector<u8>) {
        0x2::coin::update_description<GOSHI>(arg0, arg1, 0x1::string::utf8(arg2));
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<GOSHI>, arg1: &mut 0x2::coin::CoinMetadata<GOSHI>, arg2: vector<u8>) {
        0x2::coin::update_name<GOSHI>(arg0, arg1, 0x1::string::utf8(arg2));
    }

    fun init(arg0: GOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSHI>(arg0, 9, b"GOSHI", b"Goshi Coin", b"A meme coin named after my cat Goshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-elaborate-skunk-662.mypinata.cloud/ipfs/bafkreidji3jamknocy3ds3pgbgkdkcb46j3c5ldn4cpb472lq35n5nqo3q")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOSHI>>(0x2::coin::mint<GOSHI>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSHI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_icon(arg0: &mut 0x2::coin::TreasuryCap<GOSHI>, arg1: &mut 0x2::coin::CoinMetadata<GOSHI>, arg2: vector<u8>) {
        0x2::coin::update_icon_url<GOSHI>(arg0, arg1, 0x1::ascii::string(arg2));
    }

    // decompiled from Move bytecode v6
}

