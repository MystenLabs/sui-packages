module 0x5aa11f30a50bf2d2b7853f4bc16d194c465da27ad0951121087921d51abc994d::mcmeow {
    struct MCMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCMEOW>(arg0, 6, b"McMEOW", b"McME0W", b"\"Welcome to McMeownalds! What's your purrder sir?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_01_06_51_e65b06699b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

