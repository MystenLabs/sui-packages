module 0x20dbe2812837eb6831393b79bf2d2e3f8d6379571b0f8953da5486a015b41241::huh {
    struct HUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUH>(arg0, 6, b"HUH", b"Huuuuuuh", b"Huh huuh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01b890135d10009e9d997b4145954f1b_751d3802a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

