module 0x6e7587210245c4984340d15a06f787aca053d2ed734cb5b249817b88b7393807::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAI>(arg0, 6, b"WAI", b"WAI by SuiAI", b"WAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_15_216674319c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

