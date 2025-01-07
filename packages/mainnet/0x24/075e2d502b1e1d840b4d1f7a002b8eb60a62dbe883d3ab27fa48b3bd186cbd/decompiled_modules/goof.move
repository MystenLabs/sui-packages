module 0x24075e2d502b1e1d840b4d1f7a002b8eb60a62dbe883d3ab27fa48b3bd186cbd::goof {
    struct GOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOF>(arg0, 6, b"GOOF", b"Captain GOOFY", x"546865206772656174657374206669736865726d616e206f662074686520407375696e6574776f726b206f6365616e20697320726561647920746f206861756c2024474f4f4620746f2074686520746f70210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOOF_MOVEPUMP_186334eda7_8dc0893305.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

