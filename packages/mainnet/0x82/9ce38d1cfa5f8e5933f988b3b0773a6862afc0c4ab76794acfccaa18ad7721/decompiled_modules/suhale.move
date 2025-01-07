module 0x829ce38d1cfa5f8e5933f988b3b0773a6862afc0c4ab76794acfccaa18ad7721::suhale {
    struct SUHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUHALE>(arg0, 6, b"SUhale", b"SUIWhale", b"SUIWhale CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_1142_61d6f47e22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

