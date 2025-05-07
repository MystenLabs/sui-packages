module 0x563a2e3e3be911ae1e6d4573a253ba5bc6ed6c3fc0b3120bcca9d33fd31f3124::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SuiP", b"suiplay", x"6669727374206d656d65636f696e2061626f757420737569706c61790a737569706c617920697320667574757265206f662020776562332067616d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaypa6ecm72lo5h77lcalowcaqsv27oeoh4plhvrmc6ljaruokmde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

