module 0x670c02e853f9a1721df0ca984e7ee80b7ac7777ef4001424f45eb262edfdeeb2::kirk {
    struct KIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRK>(arg0, 9, b"KIRK", b"Lazarus", b"Kirk Lazarus is the goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ce21cb5-6f65-4c0e-9e04-42cf0d888607.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

