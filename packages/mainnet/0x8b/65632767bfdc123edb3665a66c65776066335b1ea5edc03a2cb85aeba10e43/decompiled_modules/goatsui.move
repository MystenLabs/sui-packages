module 0x8b65632767bfdc123edb3665a66c65776066335b1ea5edc03a2cb85aeba10e43::goatsui {
    struct GOATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATSUI>(arg0, 6, b"GOATSUI", b"GOATSEUS MAXISUI", b"GOATSEUS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_08_36_07_796b2d3110.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

