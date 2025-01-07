module 0x1fce29cd064cce00791a5b70e8a1e7832fa2d8d6d93fff161691c1ea63de97c8::captain {
    struct CAPTAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPTAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPTAIN>(arg0, 6, b"CAPTAIN", b"Sui Captain", b"All aboard with $CAPTAIN! Leading the Sui fleet with steady hands and a sharp eye, this token navigates through any storm. Trust the captain and stay the course.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_29_e56a6d68c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPTAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPTAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

