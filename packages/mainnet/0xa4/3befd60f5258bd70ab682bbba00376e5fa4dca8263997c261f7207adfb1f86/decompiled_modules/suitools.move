module 0xa43befd60f5258bd70ab682bbba00376e5fa4dca8263997c261f7207adfb1f86::suitools {
    struct SUITOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOLS>(arg0, 6, b"SUITOOLS", b"SuiTools", x"46697273742073756920636861696e207375697363616e6e657220626f74206973206c6976650a0a405375695f5363616e6e65725f426f740a405375695f5363616e6e65725f426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028974_78913199c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

