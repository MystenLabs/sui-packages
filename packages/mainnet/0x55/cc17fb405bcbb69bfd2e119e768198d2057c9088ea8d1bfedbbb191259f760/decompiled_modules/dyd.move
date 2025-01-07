module 0x55cc17fb405bcbb69bfd2e119e768198d2057c9088ea8d1bfedbbb191259f760::dyd {
    struct DYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYD>(arg0, 9, b"DYD", b"Dydx", b"Dydx fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dceb91fc-cc9c-4ca1-8ad5-575f0ed7c77c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYD>>(v1);
    }

    // decompiled from Move bytecode v6
}

