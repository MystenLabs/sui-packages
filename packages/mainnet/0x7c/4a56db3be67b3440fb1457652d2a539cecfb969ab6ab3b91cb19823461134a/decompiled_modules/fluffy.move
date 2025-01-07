module 0x7c4a56db3be67b3440fb1457652d2a539cecfb969ab6ab3b91cb19823461134a::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"TURBO FLUFFY", b"FLUFFY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962822984.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

