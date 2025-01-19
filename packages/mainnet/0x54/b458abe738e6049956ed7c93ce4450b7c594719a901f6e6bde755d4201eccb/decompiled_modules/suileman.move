module 0x54b458abe738e6049956ed7c93ce4450b7c594719a901f6e6bde755d4201eccb::suileman {
    struct SUILEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEMAN>(arg0, 6, b"Suileman", b"suileman", b"the biggest believer of SUi is Suileman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737287188828.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILEMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

