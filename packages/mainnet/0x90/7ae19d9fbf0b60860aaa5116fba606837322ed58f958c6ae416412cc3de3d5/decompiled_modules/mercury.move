module 0x907ae19d9fbf0b60860aaa5116fba606837322ed58f958c6ae416412cc3de3d5::mercury {
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

