module 0xfa1fcb584418a9e89435fb2a0d916018505ace58a89c7a92bdfe34b77f52e263::courage {
    struct COURAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COURAGE>(arg0, 6, b"COURAGE", b"Courage On Sui", b"Courage the paranoid sui dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_16_32_50_7b8d119ddd_8b452906e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COURAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

