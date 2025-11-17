module 0x7a25457b13a53283710f1e0f6ae2b9e259ec47098c73ad335ed8ce91d561fecd::sprungsui {
    struct SPRUNGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRUNGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRUNGSUI>(arg0, 9, b"", b"Staked SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRUNGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRUNGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

