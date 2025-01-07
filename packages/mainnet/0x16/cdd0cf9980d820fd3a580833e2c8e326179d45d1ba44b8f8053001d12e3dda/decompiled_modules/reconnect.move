module 0x16cdd0cf9980d820fd3a580833e2c8e326179d45d1ba44b8f8053001d12e3dda::reconnect {
    struct RECONNECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECONNECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RECONNECT>(arg0, 9, b"RECONNECT", b"Tea", b"This token is named after the reconnecting with my friends and share some memories together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10973c05-4df0-49cd-bbfb-f7ac9c301e55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECONNECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RECONNECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

