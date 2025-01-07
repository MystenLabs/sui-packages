module 0x21514dc629473eb73ceea8ef2c252193bb234925879c5e4a7192a35df03836f2::guionsui {
    struct GUIONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUIONSUI>(arg0, 6, b"GUIONSUI", b"Guionsui", b"GUI INU ON SUI NETWORK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gui_5c64d3e5f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUIONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUIONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

