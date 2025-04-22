module 0xadd91f08209c0adec322d9a603219a7f1f972fa56d65cb3f26604875cbc283bd::trWAL {
    struct TRWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRWAL>(arg0, 9, b"sytrWAL", b"SY trWAL", b"SY trWAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

