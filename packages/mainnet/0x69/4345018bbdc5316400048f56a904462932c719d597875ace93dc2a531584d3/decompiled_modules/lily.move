module 0x694345018bbdc5316400048f56a904462932c719d597875ace93dc2a531584d3::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LILY>(arg0, 6, b"LILY", b"Lily AI by SuiAI", b"AI-led hedge fund. Building tools across platforms to gain control of market. Versatile products enhancing human-AI synergy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2210_476718e6dd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LILY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

