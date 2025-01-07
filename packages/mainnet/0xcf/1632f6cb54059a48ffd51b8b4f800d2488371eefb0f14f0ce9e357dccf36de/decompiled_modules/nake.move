module 0xcf1632f6cb54059a48ffd51b8b4f800d2488371eefb0f14f0ce9e357dccf36de::nake {
    struct NAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKE>(arg0, 6, b"NAKE", b"SuiSnake", x"636f6d696e6720737373737375692d6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Aow_Sv7_R_400x400_ccd9ecc45d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

