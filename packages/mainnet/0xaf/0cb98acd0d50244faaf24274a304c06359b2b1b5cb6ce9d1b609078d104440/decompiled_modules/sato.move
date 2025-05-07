module 0xaf0cb98acd0d50244faaf24274a304c06359b2b1b5cb6ce9d1b609078d104440::sato {
    struct SATO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SATO>, arg1: 0x2::coin::Coin<SATO>) {
        0x2::coin::burn<SATO>(arg0, arg1);
    }

    fun init(arg0: SATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SATO>(arg0, 9, b"SATO", b"SATO", b"Sato the dog is inspired by Coinbase co-founder Brian Armstrong's pet cat Toshi. Named after the pseudonymous creator of Bitcoin, Satoshi Nakamoto. You cant have Toshi without Sato", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x5a70be406ce7471a44f0183b8d7091f4ad751db5.png?size=xl&key=155e96")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SATO>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SATO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SATO>>(v1, @0xe0c8df9539ae10dcedada4b81b6b209883c47d4d89cae1d8de9d29e1a2d1b359);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SATO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SATO>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SATO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SATO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

