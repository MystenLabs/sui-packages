module 0x8e0ca3e75b994f12232072c71f99f20b36e1d41c9637023c3f003210d954dff0::wtd {
    struct WTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTD>(arg0, 9, b"WTD", b"WATERDROP", b"WATERDROP is a good token to buy and hold now because it's higher value and also a good narrative driving by community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ffc5482-81c9-4ee3-8a54-26427f10ac66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

