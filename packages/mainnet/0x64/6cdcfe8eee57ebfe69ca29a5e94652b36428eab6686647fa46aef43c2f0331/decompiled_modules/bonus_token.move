module 0x646cdcfe8eee57ebfe69ca29a5e94652b36428eab6686647fa46aef43c2f0331::bonus_token {
    struct BONUS_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONUS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONUS_TOKEN>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONUS_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONUS_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

