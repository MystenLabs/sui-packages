module 0xc66bf36d5e0c42ea282b70aedd523f6e782928c27302f31af37d2e2b934febec::lm3 {
    struct LM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LM3>(arg0, 9, b"LM3", b"lemo", b"oke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a466597b-97c3-44fd-bfd7-add6d0ecbd44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LM3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LM3>>(v1);
    }

    // decompiled from Move bytecode v6
}

