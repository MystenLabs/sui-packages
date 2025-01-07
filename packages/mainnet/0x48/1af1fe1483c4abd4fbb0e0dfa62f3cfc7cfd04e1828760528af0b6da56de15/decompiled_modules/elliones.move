module 0x481af1fe1483c4abd4fbb0e0dfa62f3cfc7cfd04e1828760528af0b6da56de15::elliones {
    struct ELLIONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLIONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELLIONES>(arg0, 9, b"ELLIONES", b"Elizabeth", b"Elizabeth Liones from Seventh Deadly Sins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8aa361c-cb21-4823-b323-363744de3ad2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLIONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELLIONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

