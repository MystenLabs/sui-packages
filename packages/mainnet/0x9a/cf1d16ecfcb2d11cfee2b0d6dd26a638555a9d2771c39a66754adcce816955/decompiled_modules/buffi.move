module 0x9acf1d16ecfcb2d11cfee2b0d6dd26a638555a9d2771c39a66754adcce816955::buffi {
    struct BUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFFI>(arg0, 6, b"Buffi", b"Buffysui", b"The Slayer is back on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012220_ee90be1fae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

