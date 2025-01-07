module 0xef4bfdba3c217f35f4735bf58c075c9b5266c2e32771e7c3c109ef37e0432064::grumpo {
    struct GRUMPO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GRUMPO>, arg1: 0x2::coin::Coin<GRUMPO>) {
        0x2::coin::burn<GRUMPO>(arg0, arg1);
    }

    fun init(arg0: GRUMPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPO>(arg0, 9, b"GRUMPO", b"GRUMPO", b"GRUMPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/E2BGnzHdJNUBtAVR7EyQMuEMHqgv65JL8J9ZyqyXUVvA.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPO>>(v2, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRUMPO>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GRUMPO>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

