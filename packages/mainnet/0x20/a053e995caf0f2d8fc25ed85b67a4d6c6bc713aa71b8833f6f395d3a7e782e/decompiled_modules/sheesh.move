module 0x20a053e995caf0f2d8fc25ed85b67a4d6c6bc713aa71b8833f6f395d3a7e782e::sheesh {
    struct SHEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEESH>(arg0, 6, b"SHEESH", b"Sheesh", b"Sheesh! Chill out bro. Yea, you've found a gem. Just join us already...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736881603387.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEESH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEESH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

