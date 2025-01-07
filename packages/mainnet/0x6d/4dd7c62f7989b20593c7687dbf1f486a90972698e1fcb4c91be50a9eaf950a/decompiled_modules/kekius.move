module 0x6d4dd7c62f7989b20593c7687dbf1f486a90972698e1fcb4c91be50a9eaf950a::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 6, b"KEKIUS", b"KEKIUS GROK MAXIMUMS", b"Grok AI AGENT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x26e550ac11b26f78a04489d5f20f24e3559f7dd9_8c6da28d39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

