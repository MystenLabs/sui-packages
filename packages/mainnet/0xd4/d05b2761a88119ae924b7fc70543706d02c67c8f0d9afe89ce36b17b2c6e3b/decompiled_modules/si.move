module 0xd4d05b2761a88119ae924b7fc70543706d02c67c8f0d9afe89ce36b17b2c6e3b::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SI>(arg0, 6, b"SI", b"SANSUI", b"TKOEN DEDICATED TO POPULAR SANSUI BRAND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002548811_e02714d892.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SI>>(v1);
    }

    // decompiled from Move bytecode v6
}

