module 0xdae80def9579f823aecc21f1e20953688f1791c79ea9f18cea2e6ba2a1ed7269::lufy {
    struct LUFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFY>(arg0, 9, b"LUFY", b"LUFY ONE P", b"Meme coin one piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44ba3590-97c5-42ba-a540-174a3a4a3ff1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

