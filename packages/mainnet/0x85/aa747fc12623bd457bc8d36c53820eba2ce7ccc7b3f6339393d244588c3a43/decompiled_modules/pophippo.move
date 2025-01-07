module 0x85aa747fc12623bd457bc8d36c53820eba2ce7ccc7b3f6339393d244588c3a43::pophippo {
    struct POPHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPHIPPO>(arg0, 6, b"POPHIPPO", b"Popsudeng", b"POP POP POP POP POP POP POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_c3900c8c86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

