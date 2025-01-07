module 0x10b41b12df1ac6ca50ff1a33998eb7024032c13f68828c46ff56480fb21f94fb::maomeme99 {
    struct MAOMEME99 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOMEME99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOMEME99>(arg0, 9, b"MAOMEME99", b"maomeme", x"6d656f6d6164206cc3a0203120736f20636f6e206d656d65206e61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16894f52-8087-4ff6-89b9-7c987706c2f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOMEME99>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAOMEME99>>(v1);
    }

    // decompiled from Move bytecode v6
}

