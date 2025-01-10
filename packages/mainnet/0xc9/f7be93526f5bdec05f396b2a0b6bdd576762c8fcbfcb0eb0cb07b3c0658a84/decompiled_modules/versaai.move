module 0xc9f7be93526f5bdec05f396b2a0b6bdd576762c8fcbfcb0eb0cb07b3c0658a84::versaai {
    struct VERSAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSAAI>(arg0, 6, b"VersaAi", b"Versa AI", b"DeFi Bot right from your browser and your favourite messaging app - Telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000091_3c40a5b554.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERSAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VERSAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

