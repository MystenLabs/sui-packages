module 0xd0596ab237721aef43ca2658dd5a60508bac70108b60059702df04d8bc3cd24::ltest {
    struct LTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTEST>(arg0, 6, b"LTEST", b"Launchpad Test", b"Test token published from the creator flow for STRATEGY launchpad validation", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTEST>>(v1);
    }

    // decompiled from Move bytecode v7
}

