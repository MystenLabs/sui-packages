module 0x5916f8eb02cc614b05dfd54ced4bcc594f6b53159d4b0ad56462387752ea36a3::xibaa {
    struct XIBAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIBAA>(arg0, 6, b"XIBAA", b"XIBAA", b"XIBAA is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIBAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIBAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

