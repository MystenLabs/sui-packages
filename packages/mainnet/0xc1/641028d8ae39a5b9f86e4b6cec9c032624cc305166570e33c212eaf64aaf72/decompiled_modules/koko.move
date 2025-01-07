module 0xc1641028d8ae39a5b9f86e4b6cec9c032624cc305166570e33c212eaf64aaf72::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 6, b"KOKO", b"Koko the AI Agent", b"First dog translator on sui arf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735954721749.51")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

