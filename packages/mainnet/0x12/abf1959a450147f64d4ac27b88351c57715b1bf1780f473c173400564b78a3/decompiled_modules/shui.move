module 0x12abf1959a450147f64d4ac27b88351c57715b1bf1780f473c173400564b78a3::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", b"Shui on Sui", x"53687569206d65616e7320776174657220696e204368696e6573652e205368756920726570726573656e74732063616c6d6e6573732c20636865657266756c6e6573732c206a6f792c20616e64206e61747572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_01_46_22_27087285f9_1_6008eef9c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

