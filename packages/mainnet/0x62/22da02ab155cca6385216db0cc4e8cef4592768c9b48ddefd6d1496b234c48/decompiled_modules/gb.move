module 0x6222da02ab155cca6385216db0cc4e8cef4592768c9b48ddefd6d1496b234c48::gb {
    struct GB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GB>(arg0, 9, b"GB", b"Game boss", b"Boss game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e1b3479-db69-4a6a-8034-0169cba1f929.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GB>>(v1);
    }

    // decompiled from Move bytecode v6
}

