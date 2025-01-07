module 0xc6b1b11e3fea07ce7d34061c901a052ad4f4928dfd6350847af346b4728df967::mtos {
    struct MTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTOS>(arg0, 9, b"MTOS", b"MOMOAI", b"Mtos is new narration token in 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55486297-301a-4d56-ad5d-906c03d3fde4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

