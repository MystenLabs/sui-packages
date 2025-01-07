module 0xf16949b1775d99bead73f2275fcf24b96de8b34ab2ff23ac1847818b33ad8588::loveu {
    struct LOVEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVEU>(arg0, 6, b"LoveU", b"SuiHeart", b"All Glory and Gratitude to God. Thank you for my Love, Stella", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734515110800.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVEU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVEU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

