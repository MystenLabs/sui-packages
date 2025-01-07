module 0x9bc67df8f4edba72939a96d31ece1430af58717d0df609a6bd3ae268a0096400::cwat {
    struct CWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAT>(arg0, 6, b"CWAT", b"Cwat on sui", b"Oh no this meme is so funny. $CWAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050439_56603e0ec0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

