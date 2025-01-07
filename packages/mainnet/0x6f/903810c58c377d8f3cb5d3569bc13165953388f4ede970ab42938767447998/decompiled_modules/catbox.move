module 0x6f903810c58c377d8f3cb5d3569bc13165953388f4ede970ab42938767447998::catbox {
    struct CATBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOX>(arg0, 6, b"CATBOX", b"Cat Box", b"Catbox meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_32_32_577b900f24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

