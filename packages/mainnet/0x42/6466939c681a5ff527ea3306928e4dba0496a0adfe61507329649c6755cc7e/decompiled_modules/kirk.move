module 0x426466939c681a5ff527ea3306928e4dba0496a0adfe61507329649c6755cc7e::kirk {
    struct KIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRK>(arg0, 9, b"KIRK", b"Lazarus", b"Kirk Lazarus is the goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/791ff6a9-44a3-46ca-9e2f-3f90f8069a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

