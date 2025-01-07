module 0xab4da5bb1d9bb9922c9fd23e48caa9c05acf78ebbcd907aa3275ddb296e2d2e::sama {
    struct SAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMA>(arg0, 6, b"SAMA", b"SuiSama", b"o-machid sama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008610_f210eddabb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

