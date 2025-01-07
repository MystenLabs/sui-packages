module 0x642cb0ea7a692205eca2904b67b46d3303435c8bbeaf66e8f5a78f7a1b29de99::ae {
    struct AE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AE>(arg0, 6, b"AE", b"AEAEAEA", b"EEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/968768_160_53afb70237.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AE>>(v1);
    }

    // decompiled from Move bytecode v6
}

