module 0xcca853f5f3a6a744d2581fc6f7285a4460ceac7bd8d661185c32701fbf87df7b::oiia {
    struct OIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIA>(arg0, 6, b"OiiA", b"OiiA - The Agent Cat", b"Oiia oiia oiia, the first Cat AI Agent on SUI. Optimizing intelligence in adorable ways.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736000752629.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OIIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

