module 0x386c31abddfd81a8ebf74b0373338196eb8c78d2a4d55a81fd50f477e84a59::oysti {
    struct OYSTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYSTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYSTI>(arg0, 9, b"OYSTI", b"Oysti", x"4f7973746920616e64206869732050726563696f757320506561726c2120e29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/278032db-d132-4187-8cc5-18edfb77180a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYSTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OYSTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

