module 0xf81656a484f1e8b6910d4c85ff485dc51146870457b6a9265305c5d287f61ad8::duke {
    struct DUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKE>(arg0, 6, b"DUKE", b"DUKES", b"Duke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_13_17_37_02_442821b823.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

