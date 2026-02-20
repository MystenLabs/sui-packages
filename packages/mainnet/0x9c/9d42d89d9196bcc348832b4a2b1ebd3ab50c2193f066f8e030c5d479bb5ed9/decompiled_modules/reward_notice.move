module 0x9c9d42d89d9196bcc348832b4a2b1ebd3ab50c2193f066f8e030c5d479bb5ed9::reward_notice {
    struct REWARD_NOTICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REWARD_NOTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWARD_NOTICE>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWARD_NOTICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REWARD_NOTICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

