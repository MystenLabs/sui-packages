module 0xcfdf184e3bd9fc007e94a923a7db4f5a8fbc94d35d7a9dbd4b69f455d12ecb4b::SUIP {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 9, b"testSUIP", b"testSuiPad", b"testSuiPad The Premier Launchpad for Tier-1 Projects", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::coin::mint_and_transfer<SUIP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIP>>(v2);
    }

    // decompiled from Move bytecode v6
}

