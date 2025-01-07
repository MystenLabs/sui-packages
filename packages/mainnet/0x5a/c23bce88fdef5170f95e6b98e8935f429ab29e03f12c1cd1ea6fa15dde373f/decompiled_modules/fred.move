module 0x5ac23bce88fdef5170f95e6b98e8935f429ab29e03f12c1cd1ea6fa15dde373f::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"Fred", b"Fred aims to create a space where crypto enthusiasts can gather, share ideas, and explore potential without pressure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977947639.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

