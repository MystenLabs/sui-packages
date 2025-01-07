module 0x5d608b836c701e1950e369a8da192ce33e240cc6683b2df0bcda0a71c99f9c9a::spooki {
    struct SPOOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKI>(arg0, 6, b"Spooki", b"SpookiSui", b"The Friendliest Ghosty On Sui .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957980396.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOOKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

