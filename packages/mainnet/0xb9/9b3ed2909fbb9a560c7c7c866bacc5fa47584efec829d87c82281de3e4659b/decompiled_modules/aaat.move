module 0xb99b3ed2909fbb9a560c7c7c866bacc5fa47584efec829d87c82281de3e4659b::aaat {
    struct AAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAT>(arg0, 6, b"AAAT", b"aaaTurbos", b"Can't stop won't stop (thinking about Turbos)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955572523.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

