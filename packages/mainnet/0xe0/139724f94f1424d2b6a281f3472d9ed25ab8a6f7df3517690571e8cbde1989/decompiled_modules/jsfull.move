module 0xe0139724f94f1424d2b6a281f3472d9ed25ab8a6f7df3517690571e8cbde1989::jsfull {
    struct JSFULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSFULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSFULL>(arg0, 9, b"JSFULL", b"Justfull", b"We're listing binance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08461ad3-d48d-4722-bffc-125f3cd8105d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSFULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JSFULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

