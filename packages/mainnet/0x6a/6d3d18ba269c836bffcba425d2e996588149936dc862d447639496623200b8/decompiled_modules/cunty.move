module 0x6a6d3d18ba269c836bffcba425d2e996588149936dc862d447639496623200b8::cunty {
    struct CUNTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CUNTY>(arg0, 6, b"CUNTY", b"Cunty the Cat", b"Cunty tokenomics dey tight! With the scarcity plan dem put, as more people dey buy, the price go shoot up like rocket.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cunty_2397ecdbe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CUNTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUNTY>>(v2);
    }

    // decompiled from Move bytecode v6
}

