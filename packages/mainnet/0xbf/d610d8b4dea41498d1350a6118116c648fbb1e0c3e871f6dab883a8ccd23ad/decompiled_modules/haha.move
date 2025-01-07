module 0xbfd610d8b4dea41498d1350a6118116c648fbb1e0c3e871f6dab883a8ccd23ad::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 6, b"HAHA", b"haha", b"hahaz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_ab4da66fb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

