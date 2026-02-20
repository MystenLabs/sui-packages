module 0x5cedebbd7a2a945e3b8bb0bbb17356a664b68b3e2888af95f1dc5d04cfc03879::perk_badge {
    struct PERK_BADGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERK_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERK_BADGE>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERK_BADGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PERK_BADGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

