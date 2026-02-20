module 0xfc75c653456c16933699aa90967f3d5792f1b77cafc8f7285304a5fe6ce7ce6c::gift_alert {
    struct GIFT_ALERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFT_ALERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIFT_ALERT>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFT_ALERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIFT_ALERT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

