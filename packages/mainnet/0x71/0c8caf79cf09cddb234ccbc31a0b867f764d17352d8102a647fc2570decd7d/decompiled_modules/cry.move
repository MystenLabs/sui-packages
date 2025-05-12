module 0x710c8caf79cf09cddb234ccbc31a0b867f764d17352d8102a647fc2570decd7d::cry {
    struct CRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRY>(arg0, 6, b"CRY", b"CryCat", b"Don't $CRY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069006_f4f6cae303.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

