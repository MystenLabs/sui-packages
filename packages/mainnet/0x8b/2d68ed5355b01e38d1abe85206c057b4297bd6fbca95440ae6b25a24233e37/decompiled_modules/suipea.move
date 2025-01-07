module 0x8b2d68ed5355b01e38d1abe85206c057b4297bd6fbca95440ae6b25a24233e37::suipea {
    struct SUIPEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEA>(arg0, 6, b"SUIPEA", b"SuiPea", b"Make SuiPea the unofficial meme of the Sui Network, a cute and fun meme with no social media presence, purely for community-driven viral appeal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4563_0fb38f0ffa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

