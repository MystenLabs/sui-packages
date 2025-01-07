module 0xfa3b5d69a285512ecf92b003dd72aef85f55d54c53dac5a35e36d7532b907024::oopss {
    struct OOPSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOPSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOPSS>(arg0, 9, b"OOPSS", b"OldPossum", b"Old Possum was here when $BTC was created", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b558434e-9c6b-4522-8919-c9dfe08ede9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOPSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOPSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

