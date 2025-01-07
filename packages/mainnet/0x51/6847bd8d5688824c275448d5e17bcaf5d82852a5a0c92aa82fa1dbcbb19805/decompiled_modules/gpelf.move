module 0x516847bd8d5688824c275448d5e17bcaf5d82852a5a0c92aa82fa1dbcbb19805::gpelf {
    struct GPELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPELF>(arg0, 6, b"Gpelf", b"Gay Pelf", b"Im %98 gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfsfsdf_a5d8d088a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

