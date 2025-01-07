module 0xc3ef5db760abd5dfac10a1a33eacf00f1bac88b8e19b33798b95855853f95ec7::iceberg {
    struct ICEBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEBERG>(arg0, 6, b"ICEBERG", b"Sui Iceberg", b"Prepare to hit the tip of something massive! $ICEBERG is lurking on Sui, with secrets buried deep beneath the surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Iceberg_551e0cab15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEBERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICEBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

