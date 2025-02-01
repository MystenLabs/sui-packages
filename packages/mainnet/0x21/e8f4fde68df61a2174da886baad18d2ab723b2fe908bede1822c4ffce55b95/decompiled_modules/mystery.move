module 0x21e8f4fde68df61a2174da886baad18d2ab723b2fe908bede1822c4ffce55b95::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"MYSTERY", b"Mystery", b"the most memeable memecoin in existence. You wanted a second chance at PEPE, join the community to find out what the mystery cult is about.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087935_6ba2e3c4a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

