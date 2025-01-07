module 0xac343246d138fa55e269c00cf4627db044c6a7ec430aec14d204ed2b6f8ee065::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"Mizu", b"MizuSui", x"4d697a7520697320616e206f6666696369616c206d6173636f74206f66205375692e204d697a7520e6b0b420616c736f206d65616e7320776174657220696e204a6170616e6573652e20204d697a7520686f6c647320757020322066696e6765727320776869636820697320612073696d706c652067657374757265206f662070656163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735698829390.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

