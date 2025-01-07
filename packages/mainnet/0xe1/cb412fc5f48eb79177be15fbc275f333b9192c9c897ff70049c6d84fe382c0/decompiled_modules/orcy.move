module 0xe1cb412fc5f48eb79177be15fbc275f333b9192c9c897ff70049c6d84fe382c0::orcy {
    struct ORCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCY>(arg0, 6, b"ORCY", b"Orcy", b"Hey there, I'm $ORCY! Your ultimate meme token, making waves in the SUI ecosystem. Lets dive in and conquer the ocean together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/orcy_c308eaf254.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

