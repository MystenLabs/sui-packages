module 0x522302265c7a5cc00aca06c89e4a9915f825d210f8af4389c3cc66ccb7af8e5b::zowie {
    struct ZOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOWIE>(arg0, 6, b"ZOWIE", b"Zowie", b"In the ethereal realm where imagination takes flight, amidst the towering peaks of icy mountains,ZOWIE was born.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f6280f653c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

