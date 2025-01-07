module 0xb1b86dd450501f00dfd3b06bf13e2a444a67f1ee0217ed9f678a318057c3a162::jwr {
    struct JWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWR>(arg0, 9, b"JWR", b"JAWIR", b"kontol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/802241a9-4d56-42fb-9156-65b0c4a55576.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

