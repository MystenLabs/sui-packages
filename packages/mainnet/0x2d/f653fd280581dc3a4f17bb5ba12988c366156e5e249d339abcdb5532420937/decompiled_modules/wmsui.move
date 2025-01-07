module 0x2df653fd280581dc3a4f17bb5ba12988c366156e5e249d339abcdb5532420937::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"Waterman", b"Waterman, the SUIperhero. Be water MF - https://t.me/waterman_SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker4_37d7059814.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

