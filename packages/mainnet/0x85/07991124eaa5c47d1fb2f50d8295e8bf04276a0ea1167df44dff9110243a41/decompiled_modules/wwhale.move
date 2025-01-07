module 0x8507991124eaa5c47d1fb2f50d8295e8bf04276a0ea1167df44dff9110243a41::wwhale {
    struct WWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWHALE>(arg0, 6, b"WWHALE", b"Wrapped Whale", b"A Whale that's been wrapped.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_18_25_50_ecbd9e9bdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

