module 0x86e96c553b221b9dbd535bf52b98ee813a1688085bd07300738bead9cc12e3ec::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BD>(arg0, 6, b"BD", b"Big dick by SuiAI", b"self-explanatory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/A_black_image_jpg_01566dd786.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

