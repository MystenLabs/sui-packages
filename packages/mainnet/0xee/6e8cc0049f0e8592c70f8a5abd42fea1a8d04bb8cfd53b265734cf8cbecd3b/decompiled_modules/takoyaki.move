module 0xee6e8cc0049f0e8592c70f8a5abd42fea1a8d04bb8cfd53b265734cf8cbecd3b::takoyaki {
    struct TAKOYAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKOYAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKOYAKI>(arg0, 6, b"TAKOYAKI", b"takoyaki", b"takoyaki (Japanese fast food)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_07_53_00_11b4c0f913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKOYAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAKOYAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

