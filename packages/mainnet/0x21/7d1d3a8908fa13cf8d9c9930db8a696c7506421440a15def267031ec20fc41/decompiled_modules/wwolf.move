module 0x217d1d3a8908fa13cf8d9c9930db8a696c7506421440a15def267031ec20fc41::wwolf {
    struct WWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWOLF>(arg0, 9, b"WWOLF", b"Wild Wolf", b"Wild Wolf Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/145211a1-e2e6-44fa-912c-6a4473628110.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

