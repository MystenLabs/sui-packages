module 0x3bdbfd79b62cc15aec4c78bc83e01f0f5c7c04308bad3c8beee73b4da46ea3fb::ezzz {
    struct EZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EZZZ>(arg0, 6, b"Ezzz", b"Ez", b"Sleepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732615019947.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EZZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EZZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

