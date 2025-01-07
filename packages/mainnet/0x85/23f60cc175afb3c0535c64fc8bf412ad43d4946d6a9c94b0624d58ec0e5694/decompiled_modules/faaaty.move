module 0x8523f60cc175afb3c0535c64fc8bf412ad43d4946d6a9c94b0624d58ec0e5694::faaaty {
    struct FAAATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAAATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAAATY>(arg0, 6, b"FAAATY", b"Faaaty", b"The Fattest Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_cc0f582845.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAAATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAAATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

