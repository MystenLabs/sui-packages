module 0xa11035b2d28f64069b66ea735d111acbe18a649a3bb1793ec0e955fb6f0b438c::forcatous {
    struct FORCATOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORCATOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORCATOUS>(arg0, 6, b"Forcatous", b"Forca", b"sucezmoi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1157094_1c12dd5201.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORCATOUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORCATOUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

