module 0xe31f1e02760703eab65ab932e7c0935f6380ea25243424d92532e71ff4413657::aifa {
    struct AIFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFA>(arg0, 6, b"AIFA", b"AI Filmacademy", b"worlds first ai agent to bring you news in film + tv  one of the worlds first Ai film festivals, returning 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AIFA_5014a8334a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

