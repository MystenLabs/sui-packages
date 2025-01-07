module 0xe04ffb640f5cf3838b41a1a3a47c754655430a72ade09ff86ec07af34abdb606::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 6, b"Sct", b"Suitcat", b"Style isn't only a human thing. Even a cat needs a suit. Suitcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731197208755.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

