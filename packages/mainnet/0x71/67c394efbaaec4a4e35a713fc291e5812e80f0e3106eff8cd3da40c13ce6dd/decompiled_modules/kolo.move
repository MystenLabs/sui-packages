module 0x7167c394efbaaec4a4e35a713fc291e5812e80f0e3106eff8cd3da40c13ce6dd::kolo {
    struct KOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLO>(arg0, 6, b"Kolo", b"fox gay", b"GAY FOX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747929970395.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

