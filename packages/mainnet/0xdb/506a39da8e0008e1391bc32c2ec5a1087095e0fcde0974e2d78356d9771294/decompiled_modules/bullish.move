module 0xdb506a39da8e0008e1391bc32c2ec5a1087095e0fcde0974e2d78356d9771294::bullish {
    struct BULLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISH>(arg0, 6, b"BULLISH", b"BULLISH ON SUI", b"THE BOYS CLUB ARE BULLISH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullishlogo_e3b34c9427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

