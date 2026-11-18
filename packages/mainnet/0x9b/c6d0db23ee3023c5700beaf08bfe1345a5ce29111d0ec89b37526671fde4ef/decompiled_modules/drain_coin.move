module 0x9bc6d0db23ee3023c5700beaf08bfe1345a5ce29111d0ec89b37526671fde4ef::drain_coin {
    struct DRAIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAIN_COIN>(arg0, 6, b"DRC", b"DrainCoin", b"drain kit dummy locked-token type", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAIN_COIN>>(v1);
    }

    // decompiled from Move bytecode v7
}

