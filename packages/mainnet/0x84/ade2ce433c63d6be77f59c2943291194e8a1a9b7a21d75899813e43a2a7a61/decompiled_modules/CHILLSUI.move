module 0x84ade2ce433c63d6be77f59c2943291194e8a1a9b7a21d75899813e43a2a7a61::CHILLSUI {
    struct CHILLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSUI>(arg0, 6, b"Chill Guy on Sui", b"CHILLSUI", b"Your chill guy on sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLSUI>>(0x2::coin::mint<CHILLSUI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

