module 0x7a25ba9c98b6564fce0482ee23795e54a98bf1c3ad2a3e179d2974f36ac333b4::shuh {
    struct SHUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUH>(arg0, 6, b"SHUH", b"Sui HUH", b"Just a huh cat in sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HUH_cac5f3a5c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

