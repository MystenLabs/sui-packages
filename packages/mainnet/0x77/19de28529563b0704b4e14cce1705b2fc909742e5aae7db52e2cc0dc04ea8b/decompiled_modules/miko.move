module 0x7719de28529563b0704b4e14cce1705b2fc909742e5aae7db52e2cc0dc04ea8b::miko {
    struct MIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKO>(arg0, 6, b"MIKO", b"Miko Cash", b"Miko Real Cash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005044_3a2fc25414.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

