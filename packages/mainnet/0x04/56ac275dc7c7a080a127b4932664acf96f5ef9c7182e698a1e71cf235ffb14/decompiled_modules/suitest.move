module 0x456ac275dc7c7a080a127b4932664acf96f5ef9c7182e698a1e71cf235ffb14::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEST>(arg0, 8, b"SUITEST", b"Suitest", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITEST>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

