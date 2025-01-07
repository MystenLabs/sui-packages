module 0x2310a76d82cd60f3fe3c809fa0445d3f1dd044c4541355c64102805c9eef7378::owbe {
    struct OWBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWBE>(arg0, 9, b"OWBE", b"bdjd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/703607f5-2ad5-48e0-bb10-fbc600986490.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

