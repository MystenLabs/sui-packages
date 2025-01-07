module 0xa5b956ead3333ad866f580189b6cee1ff7f58f82b0e1a2709d80f30a737657f6::iendn {
    struct IENDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENDN>(arg0, 9, b"IENDN", b"hdjdn", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c09a99a7-413a-4917-b7d4-d943fcbc8a7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

