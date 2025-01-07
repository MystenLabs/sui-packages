module 0xf7a910952cee1cdc685987dc2a30f1ecebf2ce1eb2c389dbed9a558859b52660::niuniu {
    struct NIUNIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIUNIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIUNIU>(arg0, 6, b"Niuniu", b"SUINiuniu", b"Let's build a community meme together and create a good ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012716_75b47536fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIUNIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIUNIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

