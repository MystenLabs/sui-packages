module 0xea0d26d89c6d99b699b6c4145b59fd23a8666418f12c0108d736ab9aa6557914::soggy {
    struct SOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGGY>(arg0, 6, b"SOGGY", b"suiOGGY", b"sui oggy oni", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_01_02_22_c26e2627a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

