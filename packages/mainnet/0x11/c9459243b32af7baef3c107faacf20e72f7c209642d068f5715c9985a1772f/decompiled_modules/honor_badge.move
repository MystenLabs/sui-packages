module 0x11c9459243b32af7baef3c107faacf20e72f7c209642d068f5715c9985a1772f::honor_badge {
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

