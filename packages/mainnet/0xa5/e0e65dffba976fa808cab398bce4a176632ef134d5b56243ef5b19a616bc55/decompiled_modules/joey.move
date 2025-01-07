module 0xa5e0e65dffba976fa808cab398bce4a176632ef134d5b56243ef5b19a616bc55::joey {
    struct JOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEY>(arg0, 6, b"JOEY", b"Sui Joey", b"Joey loves playing with the waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_74_a1ec9e4c4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

