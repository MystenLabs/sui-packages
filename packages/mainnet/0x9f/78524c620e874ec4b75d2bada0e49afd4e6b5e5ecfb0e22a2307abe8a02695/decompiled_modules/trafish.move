module 0x9f78524c620e874ec4b75d2bada0e49afd4e6b5e5ecfb0e22a2307abe8a02695::trafish {
    struct TRAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAFISH>(arg0, 6, b"TRAFISH", b"Travis Scott Fish", x"2454524146495348202d205472617669732053636f74742046697368206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logooo_6b92658852.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

