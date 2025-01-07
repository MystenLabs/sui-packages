module 0xb7628488ff74b534047724f3a038aa03da36db4b9370bd25c4ebbe9d16b3de80::chillg {
    struct CHILLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLG>(arg0, 6, b"CHILLG", b"Chill guy", b"Chill guy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/png3_0266b49bc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

