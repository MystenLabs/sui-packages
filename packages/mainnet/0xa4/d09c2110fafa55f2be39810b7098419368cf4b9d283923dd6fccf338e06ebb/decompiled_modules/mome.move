module 0xa4d09c2110fafa55f2be39810b7098419368cf4b9d283923dd6fccf338e06ebb::mome {
    struct MOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOME>(arg0, 9, b"MOME", b"MOME COIN", b"MOME Power the Sui ecosystem. Participate in decisions, get rewards, access exclusive features. Fast, secure Sui network. Unlock decentralized world potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc8bee58-d004-4acf-9149-3a0695117534.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

