module 0x35d82b2123d31642b3af9444a5a644678feade50c881aa65f0f59b1c30c4b290::wewek {
    struct WEWEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEK>(arg0, 9, b"WEWEK", b"Wiwiwk", b"Wewekgombel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a472535-107e-4519-baec-8c851a591dd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

