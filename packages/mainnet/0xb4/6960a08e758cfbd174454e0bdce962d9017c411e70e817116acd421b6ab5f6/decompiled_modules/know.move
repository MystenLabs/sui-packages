module 0xb46960a08e758cfbd174454e0bdce962d9017c411e70e817116acd421b6ab5f6::know {
    struct KNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNOW>(arg0, 6, b"KNOW", b"SUI $KNOW", b"Sui Know is a smart, fun, community-focused meme token built on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0837_c3b85b5146.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

