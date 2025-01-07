module 0xee9d78d86c60bc2750c852ee33d3c243c6703adce0e306dfe805b1ef7ba7b854::dny {
    struct DNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNY>(arg0, 9, b"DNY", b"Nusantara ", b"Dinasty Coin Nusantara ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df911878-1678-4b1c-acf6-445df1d469af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

