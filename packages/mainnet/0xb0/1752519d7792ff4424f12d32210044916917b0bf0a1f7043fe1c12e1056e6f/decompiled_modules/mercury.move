module 0xb01752519d7792ff4424f12d32210044916917b0bf0a1f7043fe1c12e1056e6f::mercury {
    struct MERCURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCURY>(arg0, 6, b"Mercury", b"Mercury coin", b"Welcome to Mercury, the world of Sui, the blue ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/resized_image_3x_4f7f6e9015.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

