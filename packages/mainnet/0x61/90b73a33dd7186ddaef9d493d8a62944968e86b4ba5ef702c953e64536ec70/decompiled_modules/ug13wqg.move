module 0x6190b73a33dd7186ddaef9d493d8a62944968e86b4ba5ef702c953e64536ec70::ug13wqg {
    struct UG13WQG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG13WQG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG13WQG>(arg0, 0, b"UG13WQG", b"Sui Blue Gift User G13WQG", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG13WQG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UG13WQG>>(0x2::coin::mint<UG13WQG>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG13WQG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

