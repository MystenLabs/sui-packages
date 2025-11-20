module 0x586f455883a833d87051911c03630ac49b0271a7d9df87c642a5029b6f3916c4::xiba {
    struct XIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIBA>(arg0, 9, b"XIBA", b"XIBA", b"XIBA is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

