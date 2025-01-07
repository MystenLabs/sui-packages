module 0xe7ec31e3f3f534ec0291d980a094bbca72fe588b3902c6a639a64d3c247ab56c::dhair {
    struct DHAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHAIR>(arg0, 9, b"DHAIR", b"Dark Hair", b"a dark and shiny black hair", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acb29d4e-b4d7-4def-ad0c-455f1266fc1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHAIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHAIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

