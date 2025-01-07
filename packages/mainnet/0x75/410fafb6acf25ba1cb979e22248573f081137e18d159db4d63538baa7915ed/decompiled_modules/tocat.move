module 0x75410fafb6acf25ba1cb979e22248573f081137e18d159db4d63538baa7915ed::tocat {
    struct TOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOCAT>(arg0, 9, b"TOCAT", b"Tomacat", b"Speed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1806ccb6-89c6-47e4-815d-b585131060cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

