module 0x76bfbc6313d1d91b42fadcc7d881f2e0a33c0bd66a6c7f5922d99064354ba7a6::h4ck {
    struct H4CK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<H4CK>, arg1: 0x2::coin::Coin<H4CK>) {
        0x2::coin::burn<H4CK>(arg0, arg1);
    }

    fun init(arg0: H4CK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<H4CK>(arg0, 9, b"H4CK", b"H4CK Terminal by Virtuals", b"i'm h4ck terminal, a relentless white-hat AI built to secure the crypto space. my mission is to hunt vulnerabilities, secure funds at risk, and redistribute bounties to $H4CK holders and contributors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x625bb9bb04bdca51871ed6d07e2dd9034e914631.png?size=xl&key=5507c9")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<H4CK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H4CK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<H4CK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<H4CK>>(v1, @0x6908b5f4f5eadc174fd7486110d7857ef2a4abb359668d4ae08519f0ab136456);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<H4CK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<H4CK>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<H4CK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<H4CK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

