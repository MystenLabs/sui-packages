module 0x51012436320102d89d0b374d6af6f25de92a021d6bcf321bce7e7d96a24618fe::wwhl {
    struct WWHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWHL>(arg0, 6, b"WWHL", b"WILD WHALE", b"Making waves and spouting memes, Wild Whale is a giant in the meme ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_043739771_3a9fbca7bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

