module 0x7d2644bf2f8c5ecd38d7db638b4e3a6efa5072333a34e1e2fd9c0700511a32e3::ayw {
    struct AYW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYW>(arg0, 9, b"AYW", b"AYOWE", b"Promoting WEWE Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a136873-9c05-43e5-8473-7b19c8bea2b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYW>>(v1);
    }

    // decompiled from Move bytecode v6
}

