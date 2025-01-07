module 0xfc4bf8d209a5fb03d2e54cfae61574d9cd97241f0aefd4d741784d49d5315668::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAST>(arg0, 6, b"BEAST", b"BEAST FANCOIN SUI", b"WHO WANTS  FREE MONEY?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4c6ddaead81b42fca2046a7e296e0954_99a7944a2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

