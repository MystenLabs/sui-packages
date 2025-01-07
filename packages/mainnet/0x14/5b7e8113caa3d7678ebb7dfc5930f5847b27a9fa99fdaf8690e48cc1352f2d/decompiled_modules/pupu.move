module 0x145b7e8113caa3d7678ebb7dfc5930f5847b27a9fa99fdaf8690e48cc1352f2d::pupu {
    struct PUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPU>(arg0, 6, b"PuPu", b"SuiPuPu", x"0a0a0a0a0a0a0a0a5368686820646f6e27742074656c6c20616e796f6e65206275742069207468696e6b202450555055206973204d6f737420736572696f75732050726f6a656374206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_cat_f3c90f0e69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

