module 0xbb258ba07a4158ab14080887addc47ddbfa9bf08ebc145a35cfbf9b27d1519d::china {
    struct CHINA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHINA>, arg1: 0x2::coin::Coin<CHINA>) {
        0x2::coin::burn<CHINA>(arg0, arg1);
    }

    fun init(arg0: CHINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINA>(arg0, 9, b"CHINA", b"CHINA", b"CHINA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/E2BGnzHdJNUBtAVR7EyQMuEMHqgv65JL8J9ZyqyXUVvA.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINA>>(v2, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHINA>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHINA>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

