module 0xba18fc6dbcbc57ab9f770a15cf1bcb7faf05f56e883d5a84f2df265048da4220::gift_alert {
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

