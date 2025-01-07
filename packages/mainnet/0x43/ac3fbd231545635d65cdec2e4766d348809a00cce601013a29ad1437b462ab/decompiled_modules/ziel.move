module 0x43ac3fbd231545635d65cdec2e4766d348809a00cce601013a29ad1437b462ab::ziel {
    struct ZIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIEL>(arg0, 9, b"ZIEL", b"Ziel Smile", b"Ziel smile paint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1aa58bc3-6674-485b-a48c-6221d7245e5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

