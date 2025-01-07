module 0xc974d6ef5948a6dcfc6236a465ba529732208bd9f42c306167ac3c0fe32582ed::biggy {
    struct BIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGGY>(arg0, 6, b"BIGGY", b"Biggy (Brett's Pig)", b"Biggy, Brett's Pig is exploring Sui! Make him feel loved, like when he is with Brett.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pigg_01_min_88a9c7da5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

