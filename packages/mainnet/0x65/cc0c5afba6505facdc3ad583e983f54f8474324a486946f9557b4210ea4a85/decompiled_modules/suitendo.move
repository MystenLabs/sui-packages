module 0x65cc0c5afba6505facdc3ad583e983f54f8474324a486946f9557b4210ea4a85::suitendo {
    struct SUITENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITENDO>(arg0, 6, b"SUITENDO", b"SuiTendo", b"CONSOLE OF ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_57_24_6bbe719027.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITENDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITENDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

