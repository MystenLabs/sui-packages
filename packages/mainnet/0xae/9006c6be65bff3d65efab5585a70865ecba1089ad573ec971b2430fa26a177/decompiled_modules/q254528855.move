module 0xae9006c6be65bff3d65efab5585a70865ecba1089ad573ec971b2430fa26a177::q254528855 {
    struct Q254528855 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q254528855, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q254528855>(arg0, 9, b"Q254528855", x"5741564520f09f8c8a", b"Get rich together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98312d14-4c4f-421d-a08e-b0611da17ddf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q254528855>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q254528855>>(v1);
    }

    // decompiled from Move bytecode v6
}

