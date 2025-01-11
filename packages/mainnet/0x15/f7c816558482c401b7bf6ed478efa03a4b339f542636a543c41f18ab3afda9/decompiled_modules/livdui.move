module 0x15f7c816558482c401b7bf6ed478efa03a4b339f542636a543c41f18ab3afda9::livdui {
    struct LIVDUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIVDUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIVDUI>(arg0, 6, b"Livdui", b"LIVE DUI", b"Speeding and DUI Live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736561615148.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIVDUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIVDUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

