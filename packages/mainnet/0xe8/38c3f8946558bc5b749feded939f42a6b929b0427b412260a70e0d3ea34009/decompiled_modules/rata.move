module 0xe838c3f8946558bc5b749feded939f42a6b929b0427b412260a70e0d3ea34009::rata {
    struct RATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATA>(arg0, 6, b"RATA", b"Rata Sui", b"Rata Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030450_de0a9e4764.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

