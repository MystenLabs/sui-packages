module 0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::yes {
    struct YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YES>(arg0, 6, b"YES", b"Prophecy YES", b"YES Share for Prophecy Market", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YES>>(v1);
    }

    // decompiled from Move bytecode v6
}

