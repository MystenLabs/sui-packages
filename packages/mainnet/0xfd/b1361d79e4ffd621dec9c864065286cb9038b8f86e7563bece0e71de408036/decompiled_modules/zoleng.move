module 0xfdb1361d79e4ffd621dec9c864065286cb9038b8f86e7563bece0e71de408036::zoleng {
    struct ZOLENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOLENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOLENG>(arg0, 6, b"Zoleng", b"Zoleng on SUI", x"576520636f6d62696e6564204d6f6f64656e6720616e64205a6f6c6120666f7220796f7520616e642062726f7567687420697420746f205355492e200a4465762077616c6c6574206973204255524e54", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_22_17_45_11_53a1998676.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOLENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOLENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

