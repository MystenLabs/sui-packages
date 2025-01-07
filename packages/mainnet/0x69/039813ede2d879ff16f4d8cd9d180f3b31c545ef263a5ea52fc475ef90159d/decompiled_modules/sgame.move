module 0x69039813ede2d879ff16f4d8cd9d180f3b31c545ef263a5ea52fc475ef90159d::sgame {
    struct SGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAME>(arg0, 6, b"SGAME", b"Sui games", b"The jeers will be wasted.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5798_9f06450da3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

