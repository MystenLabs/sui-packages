module 0x48a4191efc296f4444bc8656ba6a9166345592c937e881eb09aac0f3be98e62::zap {
    struct ZAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZAP>(arg0, 6, b"ZAP", b"HIGH VOLTAGE", b"SuiEmoji High Voltage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/zap.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZAP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

