module 0xfcf7fcc58eeeaf15a6fb2451fc17ca56942636f99012a12d086e0eea7c990046::aad {
    struct AAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAD>(arg0, 6, b"AAD", b"aaa dog", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_11_58_14_426692be70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

