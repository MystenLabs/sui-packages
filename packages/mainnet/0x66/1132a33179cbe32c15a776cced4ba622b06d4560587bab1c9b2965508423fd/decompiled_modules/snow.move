module 0x661132a33179cbe32c15a776cced4ba622b06d4560587bab1c9b2965508423fd::snow {
    struct SNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOW>(arg0, 6, b"SNOW", b"Suibunnies", b"Snow bunnies found sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3632_410031dca7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

