module 0x788acb337a1dc986a2ee47365f4503fe5712f4366a01e11d64f4cea17b515136::honor_badge {
    struct HONOR_BADGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONOR_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONOR_BADGE>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONOR_BADGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HONOR_BADGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

