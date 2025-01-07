module 0x6b1c9578602dd304e48b5ca2c30ae62e18bccfd3d113aa44e9822b3a1b0f260::hopsearch {
    struct HOPSEARCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPSEARCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPSEARCH>(arg0, 6, b"HOPSEARCH", b"Where is HOP", b"So where is HOP.. we are waiting..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4190_ea3573a8f3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPSEARCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPSEARCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

