module 0x9e91bd3ce4fc1c231b7af0e3edb144b5cabdca6b83409e245c8fb0f09c36a71::sguy {
    struct SGUY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SGUY>, arg1: 0x2::coin::Coin<SGUY>) {
        0x2::coin::burn<SGUY>(arg0, arg1);
    }

    fun init(arg0: SGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SGUY>(arg0, 9, b"SGUY", b"STRESS GUY", b"im, im okay, just a bit stressed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/dHadSsY2dvsoEDwDRP7rgq7EVYRZZ17qvpwkwsQpump.png?size=xl&key=8b75ef")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SGUY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGUY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SGUY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SGUY>>(v1, @0x1a06cec12b72d2461e4a41ad74fe2a80fd27ecede64f9fb31b7f9ea20b5105bc);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SGUY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SGUY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SGUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

