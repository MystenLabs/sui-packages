module 0x20d4630f507bd47729a02df88a3d248c3063188e869a80cf23852c5a1dfe580e::maui {
    struct MAUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAUI>(arg0, 9, b"MAUI", b"Maui the B", b"Maui the Binance dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4715fac8-902a-476d-96f6-9eaed1bd158c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

