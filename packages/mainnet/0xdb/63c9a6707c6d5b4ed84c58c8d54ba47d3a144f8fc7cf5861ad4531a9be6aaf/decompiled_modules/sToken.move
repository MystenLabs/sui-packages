module 0xdb63c9a6707c6d5b4ed84c58c8d54ba47d3a144f8fc7cf5861ad4531a9be6aaf::sToken {
    struct STOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOKEN>(arg0, 6, b"FUSDC", b"fcihpy move token usdc", b"fcihpy test sui token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STOKEN>>(v1);
        let v3 = &mut v2;
        mint(v3, 500000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STOKEN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

