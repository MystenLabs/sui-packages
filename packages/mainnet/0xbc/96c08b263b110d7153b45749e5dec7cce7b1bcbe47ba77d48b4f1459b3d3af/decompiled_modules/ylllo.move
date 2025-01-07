module 0xbc96c08b263b110d7153b45749e5dec7cce7b1bcbe47ba77d48b4f1459b3d3af::ylllo {
    struct YLLLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLLLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YLLLO>(arg0, 9, b"YLLLO", b"YELLO", b"YELLO IS THE COLOR OF LUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3daa7b6-1134-4cd5-a49f-33b516286f71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLLLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YLLLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

