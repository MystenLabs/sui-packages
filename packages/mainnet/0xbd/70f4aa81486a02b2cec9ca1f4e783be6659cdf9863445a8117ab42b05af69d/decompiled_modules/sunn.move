module 0xbd70f4aa81486a02b2cec9ca1f4e783be6659cdf9863445a8117ab42b05af69d::sunn {
    struct SUNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNN>(arg0, 6, b"SUNN", b"OHGOD", b"OHGOD: SUNN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Justin_Sun_scaled_335cc467ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

