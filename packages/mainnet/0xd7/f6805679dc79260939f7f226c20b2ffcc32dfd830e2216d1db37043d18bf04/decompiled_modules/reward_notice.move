module 0xd7f6805679dc79260939f7f226c20b2ffcc32dfd830e2216d1db37043d18bf04::reward_notice {
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

