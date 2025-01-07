module 0x42579226a3bedeb475b5c7d974b436c591f08602ea06fb0d8573272dfe11cb00::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SuiDuck", b"SUIDUCKPLAY", b"SUIDUCK-themed PNGs, animated stickers, and emojis that are compatible with most social apps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_114437_1e411d77cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

