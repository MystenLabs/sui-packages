module 0xd3e558d415cab7a77f9ccc0a85187730da2a786940dd0a0c79782e676c778439::king_pepe {
    struct KING_PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING_PEPE>(arg0, 6, b"KING PEPE", b"KING PEPE ON SUI", b"Buy now or regret", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i0.wp.com/airdropalert.com/wp-content/uploads/2024/05/PEPE-meme-coin-ATH2.png?fit=1792%2C1024&ssl=1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING_PEPE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KING_PEPE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING_PEPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

