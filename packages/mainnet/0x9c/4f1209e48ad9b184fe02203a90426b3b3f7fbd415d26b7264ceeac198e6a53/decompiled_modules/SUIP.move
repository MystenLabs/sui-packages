module 0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::SUIP {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 9, b"testSUIP", b"testSuiPad", b"testSuiPad The Premier Launchpad for Tier-1 Projects", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::coin::mint_and_transfer<SUIP>(&mut v2, 100000000000000000, @0x915d741f9a411d7f69c196c39c216304f4d478e13276d0ff85457a131106ba99, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIP>>(v2);
    }

    // decompiled from Move bytecode v6
}

