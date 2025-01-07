module 0x44db4f6a0a8178650142c29da892e2f5ac74541d65e2d941a3daec9ad4a6e250::suimonney {
    struct SUIMONNEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONNEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONNEY>(arg0, 6, b"SUIMONNEY", b"SUI Monney", b"Wen CG dev, Wen pump, Wen rug, Wen burn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sn_x1000_pad_750x1000_f8f8f8_35051bffc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONNEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONNEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

